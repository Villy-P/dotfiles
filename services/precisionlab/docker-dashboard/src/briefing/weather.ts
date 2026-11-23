import { EmbedBuilder } from 'discord.js';
import { formatHour } from './util';
import { getWeatherData } from '#lib/server/weather.ts';

const RAIN_WARN_CUTOFF = 30;
const DAY_START_HOUR = 6;
const DAY_END_HOUR = 23;

interface RainPeriod {
	start: number;
	end: number;
	max_probability: number;
	total_inches: number;
}

export function getRainPeriods(weather: any) {
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

export function printPeriod(period: RainPeriod) {
	return formatHour(period.start) + ' to ' + formatHour(period.end);
}

export function groupRainPeriods(items: RainPeriod[]) {
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

export async function getWeatherEmbed() {
	const weather = await getWeatherData();
	const high = Math.round(weather.daily.temperature_2m_max?.[0] ?? 0);
	const low = Math.round(weather.daily.temperature_2m_min?.[0] ?? 0);
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
					(e) =>
						`🌧 Rain from ${printPeriod(e)} · ${e.max_probability}% chance · ~${e.total_inches}in`
				)
			]
				.filter(Boolean)
				.join('\n')
		)
		.setColor(rainPeriods.length > 0 !== null ? 0xf5a623 : 0x5865f2);

    return weatherEmbed;
}
