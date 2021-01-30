//
//  Weather.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation

struct Weather {
    var name: String
    var temperature: Double
    var humidity: Int
    var sunrise: Date
    var sunset: Date
    var icon: String
    var windSpeed: Double
    var weatherDescription: String
    var dateTime: Date
}

extension Weather {
    var iconUrl: URL? {
        let imagePath = "https://openweathermap.org/img/wn/\(icon)@4x.png"
        return URL(string: imagePath)
    }
}
