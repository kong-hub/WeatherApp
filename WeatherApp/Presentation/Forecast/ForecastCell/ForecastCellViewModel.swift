//
//  ForecastCellViewModel.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation

struct ForecastCellViewModel {
    var time: String
    var temperature: String
    var iconUrl: URL?
    var weatherDescription: String
    
    init(weather: Weather) {
        self.time = weather.dateTime.toTimeString()
        self.temperature = weather.temperature.celsiusFormat
        self.iconUrl = weather.iconUrl
        self.weatherDescription = weather.weatherDescription
    }
}
