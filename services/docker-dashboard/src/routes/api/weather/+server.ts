import type { RequestHandler } from '@sveltejs/kit';
import { fetchWeatherApi } from 'openmeteo';

const UT_AUSTIN_LAT = 30.28;
const UT_AUSTIN_LONG = -97.73;

const params = {
	latitude: UT_AUSTIN_LAT,
	longitude: UT_AUSTIN_LONG,

	daily: [
		'temperature_2m_max',
		'temperature_2m_min',
		'sunrise',
		'sunset',
		'precipitation_sum',
		'precipitation_hours',
		'precipitation_probability_max'
	],
	hourly: ['temperature_2m', 'precipitation_probability', 'precipitation'],
	current: ['temperature_2m', 'apparent_temperature', 'precipitation'],
	timezone: 'America/Chicago',
	wind_speed_unit: 'mph',
	temperature_unit: 'fahrenheit',
	precipitation_unit: 'inch'
};
const url = 'https://api.open-meteo.com/v1/forecast';

export const GET: RequestHandler = async ({ request }) => {
	const responses = await fetchWeatherApi(url, params);

	const response = responses[0];
	const utcOffsetSeconds = response.utcOffsetSeconds();

	const current = response.current()!;
	const hourly = response.hourly()!;
	const daily = response.daily()!;

	const sunrise = daily.variables(2)!;
	const sunset = daily.variables(3)!;

	const weatherData = {
		current: {
			time: new Date((Number(current.time()) + utcOffsetSeconds) * 1000),
			temperature_2m: current.variables(0)!.value(),
			apparent_temperature: current.variables(1)!.value(),
			precipitation: current.variables(2)!.value()
		},
		hourly: {
			time: Array.from(
				{ length: (Number(hourly.timeEnd()) - Number(hourly.time())) / hourly.interval() },
				(_, i) =>
					new Date((Number(hourly.time()) + i * hourly.interval() + utcOffsetSeconds) * 1000)
			),
			temperature_2m: hourly.variables(0)!.valuesArray(),
			precipitation_probability: hourly.variables(1)!.valuesArray(),
			precipitation: hourly.variables(2)!.valuesArray()
		},
		daily: {
			time: Array.from(
				{ length: (Number(daily.timeEnd()) - Number(daily.time())) / daily.interval() },
				(_, i) => new Date((Number(daily.time()) + i * daily.interval() + utcOffsetSeconds) * 1000)
			),
			temperature_2m_max: daily.variables(0)!.valuesArray(),
			temperature_2m_min: daily.variables(1)!.valuesArray(),
			sunrise: [...Array(sunrise.valuesInt64Length())].map(
				(_, i) => new Date((Number(sunrise.valuesInt64(i)) + utcOffsetSeconds) * 1000)
			),
			sunset: [...Array(sunset.valuesInt64Length())].map(
				(_, i) => new Date((Number(sunset.valuesInt64(i)) + utcOffsetSeconds) * 1000)
			),
			precipitation_sum: daily.variables(4)!.valuesArray(),
			precipitation_hours: daily.variables(5)!.valuesArray(),
			precipitation_probability_max: daily.variables(6)!.valuesArray()
		}
	};

	return Response.json(weatherData);
};
