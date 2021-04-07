//
//  DetailsView.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 1/6/21.
//

import SwiftUI

public struct DetailedView: View {
    

    var todaysForcast: Weather_daily
    var isNight: Bool = false
    var currentDay: String = "--"

    
    public var body: some View {
        ZStack{
            BackGroundView(firstColor: isNight ? .black : .blue,
                           secondColor: isNight ? .init(.purple) : .init(.systemTeal)).onAppear(perform: {
                            UITableView.appearance().backgroundColor = .clear
                           })
            VStack(spacing: 30){
                Text(currentDay).foregroundColor(.white) //Monday, Tuesday...
                    .font(.system(size: 60, weight: .medium, design: .default))
                CustomDivider(width: 200)
                
                Main_Info(dayTemp: todaysForcast.temp.day, feelsLike: todaysForcast.feels_like.day, weatherIcon: icons[todaysForcast.weather[0].icon]!)
                    .frame(width: UIScreen.screenWidth, height: 100)
                
                General_Info(precip: todaysForcast.pop, wind: todaysForcast.wind_speed, humid: todaysForcast.humidity, uvi: todaysForcast.uvi)
                    .frame(width: UIScreen.screenWidth-10, height: 150)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2))

                Additional_Info(min: todaysForcast.temp.min, max: todaysForcast.temp.max, day: todaysForcast.temp.day, night: todaysForcast.temp.night, morn: todaysForcast.temp.morn, eve: todaysForcast.temp.eve, sunrise: "\(convertToDate(timeResult: todaysForcast.sunrise))", sunset: "\(convertToDate(timeResult: todaysForcast.sunset))")
                    .frame(width: UIScreen.screenWidth-10)

                Spacer(minLength: 100)
                
            }//End Vstack
            .foregroundColor(.white)
            .font(.system(size: 30, weight: .medium, design: .default))

        }//End ZStack
    }//End BodyView
}//End DetailedView

//struct Sheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedView(todaysForcast: WeatherModel(ws: WeatherService()).forecast[1], currentDay: "Monday")
//    }
//}

struct Main_Info: View {
    var dayTemp: Double = 82
    var feelsLike: Double = 79
    var weatherIcon: String = "sun.max.fill"
    
    
    var body: some View {
        HStack(spacing: 20){
            VStack{
                Text("\(dayTemp.rounded(.up), specifier: "%.f")°")
                    .font(.system(size: 55, weight: .bold))
                Text("Feels like: \(feelsLike.rounded(.up), specifier: "%.f")˚")
                    .font(.system(size: 20, weight: .medium, design: .default))
            }

            Image(systemName: weatherIcon) //icons[viewModel.forecast[dayChosen].weather[0].icon]!
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
        }
    }
}

struct General_Info: View {
    var precip: Double = 35
    var wind: Double = 9.4
    var humid: Int = 15
    var uvi: Double = 2.55
    
    var body: some View {
        VStack(alignment: .center){
            HStack(spacing: 50){
                HStack{
                    Image(systemName: "drop.fill") //icons[viewModel.forecast[dayChosen].weather[0].icon]!
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .colorInvert()
                    Print("Precip: \(precip)")
                    Text("\(precip*100.rounded(.up), specifier: "%.f")%")
                        .font(.system(size: 30, weight: .medium, design: .default))
                }
                HStack{
                    Image(systemName: "wind")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    Text("\(wind.rounded(.toNearestOrAwayFromZero), specifier: "%.f") mph")
                        .font(.system(size: 30, weight: .medium, design: .default))
                }
            }
            HStack(spacing: 25){ //Humidity and UV index
                HStack{
                    Image(systemName: "barometer")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .colorInvert()
                    VStack{
                        Text("Humidity") //Min temp for the day
                            .font(.system(size: 25, weight: .light))
                        Text("\(humid)%") //Min temp for the day
                            .font(.system(size: 25, weight: .bold))
                    }
                }
                HStack{
                    Image(systemName: "sun.max.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    VStack{
                        Text("UV index") //Min temp for the day
                            .font(.system(size: 25, weight: .light))
                        Text("\(uvi, specifier: "%.2f")") //Min temp for the day
                            .font(.system(size: 25, weight: .bold))
                    }
                }
            }
        }

        
        
    } //End Body
}

struct Additional_Info: View {
    @State var isExpanded: Bool = false
    var min: Double = 67.66
    var max: Double = 75.55
    var day: Double = 74.44
    var night: Double = 67.44
    var morn: Double = 69.55
    var eve: Double = 73.66
    
    var sunrise: String
    var sunset: String

    var body: some View {
        VStack(spacing: 10){ //Temps and Sunrise + Sunset
            HStack{ //Both columns of temps
                if !isExpanded{
                    HStack(spacing: 30){
                        VStack(alignment: .center){
                            Text("Min \(min.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚").font(.system(size: 35))
                            Text("Max \(max.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚").font(.system(size: 35))
                        }
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }


                }
                else {
                    HStack{
                        VStack(alignment: .center){
                            Text("Morning \(morn.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚")
                            Text("Noon \(day.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚")
                        }.font(.system(size: UIScreen.screenWidth*0.075, weight: .medium))
                        CustomDivider(width: 1, height: 100, padding: 10)
                        VStack(alignment: .center){
                            Text("Evening \(eve.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚")
                            Text("Night \(night.rounded(.toNearestOrAwayFromZero), specifier: "%.f")˚")
                        }.font(.system(size: UIScreen.screenWidth*0.075, weight: .medium))
                    }

                }
                
            }.frame(minHeight: 100)
            .onTapGesture { self.isExpanded.toggle() }
            .animation(.linear(duration: 0.3))
            
            CustomDivider(padding: 10)
            HStack(spacing: 25){ //Sunrise and sunset
                HStack{
                    Image(systemName: "sunrise.fill")
                        .renderingMode(.original)
                    VStack(alignment: .center){
                        Text("Sunrise") //Min temp for the day
                            .font(.system(size: 25, weight: .light))
                        Text(sunrise) //Min temp for the day
                            .font(.system(size: 25, weight: .bold))
                    }
                }
                HStack{
                    Image(systemName: "sunset.fill")
                        .renderingMode(.original)
                    VStack(alignment: .center){
                        Text("Sunset") //Min temp for the day
                            .font(.system(size: 25, weight: .light))
                        Text(sunset) //Min temp for the day
                            .font(.system(size: 25, weight: .bold))
                    }
                }
            }
        }
    }
}


struct CustomDivider: View {
    var width: CGFloat = 200
    var height: CGFloat = 1
    var padding: CGFloat = 0
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: width, height: height)
            .padding(padding)
    }
}

extension UIScreen{
  static let screenWidth = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height
  static let screenSize = UIScreen.main.bounds.size
}
