//
//  Weather.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/26/20.
//

import Foundation

public struct Weather{
    let city: String
    let sunrise: Double
    let sunset: Double
    let temperature: Int
    let forecast: [Weather_daily]
    let main_icon: String
    let description: String
    let hourly: [Weather_hourly]

    
    init(weatherResults: Weather_Results, currentResults: Current_Results) { //(weather: Weather_Results, geolocation: GeoLocation_Results) {
        city = currentResults.name
        sunrise = weatherResults.current.sunrise
        sunset = weatherResults.current.sunset
        temperature = Int(weatherResults.current.temp.rounded())
        forecast = weatherResults.daily
        main_icon = "\(weatherResults.current.weather[0].icon)"
        description = weatherResults.current.weather[0].description
        hourly = weatherResults.hourly
    }
}




