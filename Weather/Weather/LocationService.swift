//
//  LocationService.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/25/20.
//

import Foundation
import CoreLocation
import MapKit

class LocationService: NSObject, ObservableObject{
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    
    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    
    //request weather for location
}
