import { getWeatherData } from '#lib/server/weather.ts';
import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async () => {
	return Response.json(await getWeatherData());
};
