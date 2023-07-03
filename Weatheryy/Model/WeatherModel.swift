//
//  WeatherModel.swift
//  Weatheryy
//
//  Created by Emir on 3.07.2023.
//

import Foundation

struct WeatherModel {
    let wUrl = "https://api.openweathermap.org/data/2.5/weather?q=london&units=metric&appid=8823fc19b748074f2e0fbe531455a25e"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(wUrl)&q=\(cityName)"
    }
}
