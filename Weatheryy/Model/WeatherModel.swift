//
//  WeatherModel.swift
//  Weatheryy
//
//  Created by Emir on 3.07.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherModel: WeatherModel, weatherManager: WeatherManager)
    func didFailWithError(error: Error)
}

struct WeatherModel {
    let wUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=8823fc19b748074f2e0fbe531455a25e"
    
    var delegate: WeatherManagerDelegate?
    
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
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data { // RETRIEVE DATA HERE
                    if let weatherMan = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weatherManager: weatherMan)
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func fetchWeather(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let urlString = "\(wUrl)&lat=\(lat)&lon=\(lon)"
        // Create URL
        if let url = URL(string: urlString) {
            // Create a URLSession
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil { // PRINT ERROR HERE
                    print(error!)
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data { // RETRIEVE DATA HERE
                    if let weatherMan = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weatherManager: weatherMan)
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherManager? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let weatherManager = WeatherManager(conditionId: id, cityName: cityName, temperature: temp)
            return weatherManager
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
