//
//  ViewController.swift
//  Weatheryy
//
//  Created by Emir on 2.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherModel = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherModel.delegate = self
        searchTextField.delegate = self
    }
}

// MARK: - Text Field Delegate
extension ViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "You have to type"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherModel.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - Weather Manager Delegate
extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherModel: WeatherModel, weatherManager: WeatherManager) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherManager.tempString
            self.conditionImageView.image = UIImage(systemName: weatherManager.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
