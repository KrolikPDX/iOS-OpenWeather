//
//  WeatherButton.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/23/20.
//
import SwiftUI

struct WeatherButtonLabel: View {
    var buttonText: String
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .font(.system(size: 25, weight: .medium, design: .default))
            .cornerRadius(55)
        
    }
}
