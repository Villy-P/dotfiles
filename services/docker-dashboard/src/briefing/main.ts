import { getWeatherData } from '#lib/server/weather.ts';
import { EmbedBuilder, WebhookClient } from 'discord.js';

const RAIN_WARN_CUTOFF = 30;
const DAY_START_HOUR = 6;
const DAY_END_HOUR = 23;

const BARS = '▁▂▃▄▅▆▇█';

function formatHour(h: number) {
	return `${h % 12 || 12} ${h >= 12 ? 'PM' : 'AM'}`;
}

interface RainPeriod {
	start: number;
	end: number;
	max_probability: number;
	total_inches: number;
}

function getRainPeriods(weather: any) {
	const periods: RainPeriod[] = [];

	for (let i = DAY_START_HOUR; i < DAY_END_HOUR + 1; i++) {
		const precipitation_prob = weather.hourly.precipitation_probability[i];
		const precipitation = weather.hourly.precipitation[i];
		if (precipitation_prob >= RAIN_WARN_CUTOFF) {
			if (periods.length == 0 || (periods.at(-1)?.end || 0) < i - 1) {
				periods.push({ start: i, end: i, max_probability: precipitation_prob, total_inches: 0 });
			}

			const last = periods.at(-1)!;

			last.end = i;
			last.max_probability = Math.max(last.max_probability, precipitation_prob);
			last.total_inches += precipitation;
		}
	}

	return periods;
}

function printPeriod(period: RainPeriod) {
	return formatHour(period.start) + ' to ' + formatHour(period.end);
}

function groupRainPeriods(items: RainPeriod[]) {
	if (items.length === 0) return '';
	if (items.length === 1) return printPeriod(items[0]);
	if (items.length === 2) return `${printPeriod(items[0])} and ${printPeriod(items[1])}`;

	const allButLast = items
		.slice(0, -1)
		.map((e) => printPeriod(e))
		.join(', ');
	const last = printPeriod(items[items.length - 1]);
	return `${allButLast}, and ${last}`;
}

export async function sendBriefing() {
	const url = process.env.DISCORD_WEB_HOOK;
	if (!url) throw new Error('DISCORD_WEB_HOOK is not set');

	const weather = await getWeatherData();
	const high = Math.round(weather.daily.temperature_2m_max?.[0] ?? 0);
	const low = Math.round(weather.daily.temperature_2m_min?.[0] ?? 0);

	const longDate = new Date().toLocaleDateString('en-US', {
		weekday: 'long',
		month: 'long',
		day: 'numeric'
	});

	const content = `# Good Morning Valerius! ☀️\n-# ${longDate}`;

	const rainPeriods = getRainPeriods(weather);
	const weatherEmbed = new EmbedBuilder()
		.setTitle('🌤 Weather')
		.setDescription(
			[
				rainPeriods.length > 0
					? `☂️ Bring an umbrella, rain from ${groupRainPeriods(rainPeriods)}\n`
					: `☀️ No umbrella needed`,
				`**High** ${high}°F · **Low** ${low}°F`,
				...rainPeriods.map(
					(e) => `🌧 Rain from ${printPeriod(e)} · ${e.max_probability}% chance · ~${e.total_inches}in`
				)
			]
				.filter(Boolean)
				.join('\n')
		)
		.setColor(rainPeriods.length > 0 !== null ? 0xf5a623 : 0x5865f2);

	const client = new WebhookClient({ url });
	await client.send({
		username: 'Your Daily Briefing',
		content,
		embeds: [weatherEmbed]
	});

	console.log(weather);
}

sendBriefing().catch((err) => {
	console.error('Briefing failed:', err);
	process.exit(1);
});
