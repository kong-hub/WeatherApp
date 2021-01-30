//
//  WeatherResponseDTO.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation

// MARK: - Mappings to Domain
extension WeatherResponseDTO {
    func toDomain() -> Weather {
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sys?.sunrise ?? 0))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sys?.sunset ?? 0))
        let dateTime = Date(timeIntervalSince1970: TimeInterval(dt ?? 0))
        let weatherModel = Weather(name: name ?? "",
                                   temperature: main?.temp ?? 0,
                                   humidity: main?.humidity ?? 0,
                                   sunrise: sunriseDate,
                                   sunset: sunsetDate,
                                   icon: weather?.first?.icon ?? "",
                                   windSpeed: wind?.speed ?? 0,
                                   weatherDescription: weather?.first?.weatherDescription ?? "",
                                   dateTime: dateTime)
        return weatherModel
    }
}


// MARK: - WeatherResponseDTO
struct WeatherResponseDTO: Decodable {
    let weather: [WeatherDTO]?
    let base: String?
    let main: MainDTO?
    let visibility: Int?
    let wind: WindDTO?
    let dt: Int?
    let sys: SysDTO?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?

    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

// MARK: - Main
struct MainDTO: Decodable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

// MARK: - SysDTO
struct SysDTO: Decodable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: - WeatherDTO
struct WeatherDTO: Decodable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

// MARK: - WindDTO
struct WindDTO: Decodable {
    let speed: Double?
    let deg: Int?

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}
