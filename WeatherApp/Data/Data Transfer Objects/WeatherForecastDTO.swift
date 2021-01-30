//
//  WeatherForecastDTO.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation

// MARK: - Mappings to Domain
extension WeatherForecastDTO {
    func toDomain() -> WeatherForecast {
        let cityName = city?.name ?? ""
        let forecastList = list?.compactMap({ $0.toDomain(name: cityName) }) ?? []
        let dayForecast = Dictionary(grouping: forecastList, by: { $0.dateTime.dayOfWeekComponent })
        let weatherForecast = WeatherForecast(name: cityName, dayForecast: dayForecast)
        return weatherForecast
    }
}

// MARK: - WeatherForecastDTO
struct WeatherForecastDTO: Decodable {
    let cnt: Int?
    let list: [ForecastDTO]?
    var city: CityDTO?

    enum CodingKeys: String, CodingKey {
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
}

// MARK: - CityDTO
struct CityDTO: Decodable {
    let id: Int?
    let name: String?
    let country: String?
    let timezone: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case timezone = "timezone"
    }
}

extension ForecastDTO {
    func toDomain(name: String) -> Weather {
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sys?.sunrise ?? 0))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sys?.sunset ?? 0))
        let dateTime = Date(timeIntervalSince1970: TimeInterval(dt ?? 0))
        let weatherModel = Weather(name: name,
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

// MARK: - ForecastDTO
struct ForecastDTO: Decodable {
    let dt: Int?
    let main: MainDTO?
    let weather: [WeatherDTO]?
    let wind: WindDTO?
    let visibility: Int?
    let pop: Double?
    let sys: SysDTO?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case sys = "sys"
        case dtTxt = "dt_txt"
    }
}
