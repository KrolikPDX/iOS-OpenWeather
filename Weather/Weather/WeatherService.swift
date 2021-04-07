//
//  WeatherService.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/25/20.
//

import Foundation
import CoreLocation
import SwiftUI




public final class WeatherService: NSObject {
    let locationManager = CLLocationManager()
    private var completionHandler: ((Weather) -> Void)?
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(coordinates: CLLocationCoordinate2D){
        guard let url = URL.urlForcast(coords: coordinates) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            if let forecastResponse = try? JSONDecoder().decode(Weather_Results.self, from: data){
                guard let newURL = URL.urlCurrent(coords: coordinates) else {return}
                URLSession.shared.dataTask(with: newURL) { data, response, error in
                    guard let data = data, error == nil else {return}
                    if let currentResponse = try? JSONDecoder().decode(Current_Results.self, from: data){
                        self.completionHandler?(Weather(weatherResults: forecastResponse, currentResults: currentResponse)) //Add geolocation results here too
                    } else { print("ERROR! FAILED TO PARSE DATA")}
                    
                }.resume()
            } else { print("ERROR! FAILED TO PARSE DATA")}
            
        }.resume()
        

        
    }
}

//Gets current location and makesDataRequest 
extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        makeDataRequest(coordinates: locValue)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("ERROR in locationManager: \(error.localizedDescription)")
    }
}






