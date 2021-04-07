//
//  WeatherStructures.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/27/20.
//

import Foundation

struct Current_Results: Decodable {
    let name: String
}


//Main structure with all the results
struct Weather_Results: Decodable {
    let lat: Double
    let lon: Double
    let current: Weather_Current
    let daily: [Weather_daily]
    let hourly: [Weather_hourly]
}

    struct Weather_Current: Decodable {
        let sunrise: Double
        let sunset: Double
        let temp: Double
        let weather: [Weather_current_weather]
    }
        
        struct Weather_current_weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }

    //Forecast for the week
    struct Weather_daily: Decodable {
        let temp: Weather_daily_temp
        let sunrise: Double
        let sunset: Double
        let weather: [Weather_daily_weather] //Contains ID, Main, Description, and Icon
        let feels_like: Weather_daily_feels
        let pressure: Int
        let humidity: Int
        let wind_speed: Double
        let clouds: Int
        let pop: Double
        let uvi: Double
    }
        
        struct Weather_daily_temp: Decodable{
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }

        struct Weather_daily_weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }

        struct Weather_daily_feels: Decodable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
            
        }

    struct Weather_hourly: Decodable {
        let dt: Double
        let temp: Double
        let pop: Double
        let weather: [Weather_hourly_weather]
    }

        struct Weather_hourly_weather: Decodable {
            let icon: String
        }

