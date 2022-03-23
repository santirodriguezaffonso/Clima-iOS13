//
//  WeatherManager.swift
//  Clima
//
//  Created by Santiago Rodriguez Affonso on 21/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    var weatherModel = WeatherModel.self
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=7c76f28176126711c0afd661e413f671&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            weatherModel.getConditionName(id)
        } catch {
            print(error)
        }
    }
}
