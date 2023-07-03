//
//  WeatherModel.swift
//  Weatheryy
//
//  Created by Emir on 3.07.2023.
//

import Foundation

struct WeatherModel {
    let wUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=8823fc19b748074f2e0fbe531455a25e"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(wUrl)&q=\(cityName)"
        // Create URL
        if let url = URL(string: urlString) {
            // Create a URLSession
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil { // PRINT ERROR HERE
                    print(error!)
                    return
                }
                if let safeData = data { // RETRIEVE DATA HERE
                    parseJSON(data: safeData)
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: data)
            print(decodedData.name)
        } catch {
            print(error)
        }
    }
}
