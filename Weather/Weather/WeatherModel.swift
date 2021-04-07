//
//  WeatherModel.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/25/20.
//

import Foundation

public class WeatherModel: ObservableObject {
    @Published var cityName: String = "--"
    @Published var sunrise: Double = 0
    @Published var sunset: Double = 0
    @Published var temp: String = "--"
    @Published var weatherIcon: String = "?"
    @Published var doneLoading: Bool = false
    @Published var current_description: String = "--"
    @Published var forecast: [Weather_daily] = [Weather_daily]()
    @Published var isNight: Bool = false
    @Published var hourly: [Weather_hourly] = [Weather_hourly]()
    let currentTime = Date().timeIntervalSince1970

    
    public let weatherService: WeatherService
    
    public init(ws: WeatherService){
        self.weatherService = ws
    }

    public func refresh(){
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async { [self] in
                self.cityName = weather.city
                self.sunrise = weather.sunrise
                self.sunset = weather.sunset
                self.temp = "\(weather.temperature)˚F"
                self.forecast = weather.forecast
                self.weatherIcon = icons[weather.main_icon] ?? "?"
                self.current_description = weather.description
                self.hourly = weather.hourly
                    if (currentTime > sunrise && currentTime < sunset) {self.isNight = false}
                    else {self.isNight = true}

                self.doneLoading = true                
            }
        }
    }

}

func convertToDate(timeResult: Double) -> String{
    let date = Date(timeIntervalSince1970: timeResult)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
    dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
    dateFormatter.timeZone = .current
    let time = dateFormatter.string(from: date)
    return time
}

extension String {

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}

let weekday = [
    1: "Sunday",
    2: "Monday",
    3: "Tuesday",
    4: "Wednesday",
    5: "Thursday",
    6: "Friday",
    7: "Saturday",
    8: "Sunday",
    9: "Monday",
    10: "Tuesday",
    11: "Wednesday",
    12: "Thursday",
    13: "Friday",
    14: "Saturday",
    15: "Sunday"
]

let icons = [
    "01d": "sun.max.fill",
    "01n": "moon.fill",
    
    "02d": "cloud.sun.fill",
    "02n": "cloud.moon.fill",

    "03d": "cloud.fill",
    "03n": "cloud.fill",

    "04d": "cloud.fill",
    "04n": "cloud.fill",
    
    "09d": "cloud.drizzle.fill",
    "09n": "cloud.drizzle.fill",
    
    "10d": "cloud.rain.fill",
    "10n": "cloud.rain.fill",
    
    "11d": "cloud.bolt.rain.fill",
    "11n": "cloud.bolt.rain.fill",

    "13d": "snow",
    "13n": "snow",

    "50d": "cloud.fog.fill",
    "50n": "cloud.fog.fill",
]
