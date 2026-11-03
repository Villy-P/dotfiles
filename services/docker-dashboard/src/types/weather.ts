export interface Weather {
    current: {
        time: number,
        temperature_2m: number,
        apparent_termperature: number,
        precipitation: number
    },

    hourly: {
        time: number[],
        temperature_2m: number[],
        precipitation_probability: number[],
        precipitation: number[]
    },

    daily: {
        time: number[],
        temperature_2m_max: number[],
        temperature_2m_min: number[],
        sunrise: number[],
        sunset: number[],
        precipitation_sum: number[],
        precipitation_hours: number[],
        precipitation_probability_max: number[]
    }
}
