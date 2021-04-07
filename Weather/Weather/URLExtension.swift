//
//  URLExtension.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/26/20.
//

import Foundation
import CoreLocation

let API_KEY = "103d4e18b0aae07e9fe31efa64c9c79d"


extension URL {

    
    static func urlForcast(coords: CLLocationCoordinate2D) -> URL?{
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coords.latitude)&lon=\(coords.longitude)&exclude=minutely,alerts&appid=\(API_KEY)&units=imperial")
        else {return nil}
        print(url)
        return url
    }
    
    static func urlCurrent(coords: CLLocationCoordinate2D) -> URL? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude )&lon=\(coords.longitude)&appid=\(API_KEY)")
        else {return nil}
        return url
    }
    
        
    
    static func urlWeatherZip(zipcode: Int) -> URL? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=\(zipcode),us&appid=\(API_KEY)")
        else {
            print("ERROR in URL!")
            return nil
        }

        return url
    }
    
}
