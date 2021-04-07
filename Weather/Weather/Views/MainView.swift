//
//  ContentView.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/10/20.
//


import SwiftUI

public struct StartingView: View {
    @ObservedObject public var viewModel: WeatherModel

    public var body: some View {
        if viewModel.doneLoading {
            MainView(isModal: false, viewModel: viewModel)
        }
        else {
            ProgressView(){
                Text("Loading Weather")
                    .onAppear(perform: {
                        viewModel.refresh()
                    })
            }
        }
    } //End body
} //End view


//Main view after loading screen
public struct MainView: View {
    @State var isModal: Bool = false
    let currentWeekDay = Calendar.current.component(.weekday, from: Date())
    @ObservedObject public var viewModel: WeatherModel
    public var body: some View {
        NavigationView {
            ZStack {
                BackGroundView(firstColor: viewModel.isNight ? .black : .blue,
                               secondColor: viewModel.isNight ? .init(.purple) : .init(.systemTeal))
                VStack{                //Main Vertical Stack which holds all vertical main elements
                    CurrentMainView(cityName: viewModel.cityName, weatherIcon: viewModel.weatherIcon, currentTemp: viewModel.temp)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .center, spacing: 25){
                            ForEach(0..<16) { i in
                                HourlyView(currentHour: viewModel.hourly[i].dt, imageIcon: iconHourly(hourAhead: i), temperature: Int(viewModel.hourly[i].temp), percipChance: viewModel.hourly[i].pop)
                            }
                        } //End of HStack
                            .padding(.all, 10)
                        Divider()
                    }
                    CustomDivider()
                    //Daily Forecast Links
                    HStack(spacing: 15){
                        ForEach(1..<6) { i in
                            NavigationLink(destination: DetailedView(todaysForcast: viewModel.forecast[i], isNight: viewModel.isNight,currentDay: weekday[currentWeekDay+i]!)) {
                                WeatherDayView(dayOfWeek: weekday[currentWeekDay+i]!, imageIcon: iconForecast(dayAhead: i), tempOfDay: Int(viewModel.forecast[i].temp.max), percipImage: "drop", percipChance: returnPrecip(dayAhead: i))
                            }//End NavigationLink
                        } //End of for-loop
                    } //End HStack
                } //End VStack
            } //End ZStack
            .foregroundColor(.white)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }//End Navigation View
        .accentColor(viewModel.isNight ? .white : .black)

    }//End View

    func iconForecast(dayAhead: Int) -> String {
        return icons[viewModel.forecast[dayAhead].weather[0].icon] ?? "?"
    }
    
    func iconHourly(hourAhead: Int) -> String {
        return icons[viewModel.hourly[hourAhead].weather[0].icon] ?? "?"
    }
    
    func returnPrecip(dayAhead: Int) -> Int {
        return Int(viewModel.forecast[dayAhead].pop*100)
    }
    
}//End Struct


//Hourly view for current day
struct HourlyView: View {
    var currentHour: Double
    var imageIcon: String
    var temperature: Int
    var percipChance: Double
    
    var body: some View {
        VStack(alignment: .center, spacing: 2){ //Vertical stack for each day
            Text(convertToDate(timeResult: currentHour))
                .font(.system(size: 15, weight: .light))
            Image(systemName: imageIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30 , height: 30)
            Text(String(temperature) + "°")
                .font(.system(size: 20,weight: .bold))
            HStack(spacing: 2){
                Image(systemName: "drop")
                    .renderingMode(.original)
                    .colorInvert()
                Text(String(Int(percipChance * 100)) + "%")
            }
        }
    }

}

//Daily view for weekdays
struct WeatherDayView: View {
    var dayOfWeek: String
    var imageIcon: String
    var tempOfDay: Int
    var percipImage: String
    var percipChance: Int
    
    var body: some View {
        VStack(spacing: 5){ //Vertical stack for each day
            Text(dayOfWeek.prefix(3))
            Image(systemName: imageIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            Text(String(tempOfDay) + "°")
            HStack(){
                Image(systemName: percipImage)
                    .renderingMode(.original)
                    .colorInvert()
                Text(String(percipChance) + "%")
            }
        }
    }
}

//Background of currentView
struct BackGroundView: View {
    var firstColor: Color
    var secondColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [firstColor, secondColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

//Main view with cityname and temp and icon
struct CurrentMainView: View {
    var cityName: String
    var weatherIcon: String
    var currentTemp: String
    
    var body: some View {
        VStack(spacing: 0){
            Text(cityName) //Title
                .font(.system(size: 50, weight: .medium, design: .default))
                .padding(.bottom, 50)
            Image(systemName: weatherIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text(currentTemp + "°")
                .font(.system(size: 55, weight: .medium, design: .default))
        }
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}



