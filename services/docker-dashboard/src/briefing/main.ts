import { EmbedBuilder, WebhookClient } from 'discord.js';
import ical, { type CalendarComponent, type CalendarResponse, type VEvent } from 'node-ical';
import { getWeatherEmbed } from './weather';

type Occurrence = ReturnType<typeof ical.expandRecurringEvent>[number];

function isVEvent(c: CalendarComponent | undefined): c is VEvent {
	return c?.type === 'VEVENT';
}

async function getTodaysEvents(): Promise<Occurrence[]> {
	const ICAL_CATEGORIES = process.env.ICAL_CATEGORIES;
	const PRIVATE_ICAL = process.env.PRIVATE_ICAL;

	if (!ICAL_CATEGORIES || !PRIVATE_ICAL) {
		return [];
	}

	const icalLinks: string[] = ICAL_CATEGORIES.split(',').map((e) => `${PRIVATE_ICAL}${e}?export`);
	const calendars: CalendarResponse[] = await Promise.all(
		icalLinks.map(async (u) => {
			try {
				return await ical.async.fromURL(u);
			} catch (err) {
				console.error(`Calendar ${u} failed:`, err);
				throw err;
			}
		})
	);

	const start = new Date();
	start.setHours(0, 0, 0, 0);
	const end = new Date(start);
	end.setDate(end.getDate() + 1);

	return calendars
		.flatMap((cal) => Object.values(cal))
		.filter(isVEvent)
		.flatMap((e) =>
			ical.expandRecurringEvent(e, {
				from: start,
				to: end,
				includeOverrides: true,
				excludeExdates: true
			})
		)
		.sort((a, b) => a.start.getTime() - b.start.getTime());
}

export async function sendBriefing() {
	const url = process.env.DISCORD_WEB_HOOK;
	if (!url) throw new Error('DISCORD_WEB_HOOK is not set');

	const longDate = new Date().toLocaleDateString('en-US', {
		weekday: 'long',
		month: 'long',
		day: 'numeric'
	});

	const content = `# Good Morning Valerius! ☀️\n-# ${longDate}`;

	const events = await getTodaysEvents();

	const timeFmt = new Intl.DateTimeFormat('en-US', { hour: 'numeric', minute: '2-digit' });

	const atMidnight = (d: Date) =>
		d.getHours() === 0 && d.getMinutes() === 0 && d.getSeconds() === 0;

	const isAllDay = (e: Occurrence) => atMidnight(e.start) && atMidnight(e.end);

	const lines = events.map((e) =>
		isAllDay(e)
			? `All day - ${e.summary}`
			: `${timeFmt.format(e.start)} - ${timeFmt.format(e.end)} - ${e.summary}`
	);

	const dailyCalendarEmbed = new EmbedBuilder()
		.setTitle('📅 Your Day')
		.setDescription(lines.length ? lines.join('\n').slice(0, 4096) : 'No events today 🎉');

	const client = new WebhookClient({ url });
	await client.send({
		username: 'Your Daily Briefing',
		content,
		embeds: [await getWeatherEmbed(), dailyCalendarEmbed]
	});
}

sendBriefing().catch((err) => {
	console.error('Briefing failed:', err);
	process.exit(1);
});
