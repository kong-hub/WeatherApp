//
//  SearchCurrentWeatherUsecase.swift
//  WeatherAppTests
//
//  Created by Sorawit Trutsat on 31/1/2564 BE.
//

import Foundation
import RxSwift
@testable import WeatherApp

final class MockWeatherRepository: WeatherRepositoryProtocol {
    func fetchWeather(cityName: String) -> Single<Weather> {
        let bundle = Bundle(for: type(of: self))
        if let mock = Mock.sukhothaiWeather.responseObject(with: bundle),
           let weatherDTO = try? JSONDecoder().decode(WeatherResponseDTO.self, from: mock) {
            let weather = weatherDTO.toDomain()
            return .just(weather)
        }
        return .never()
    }
    
    func fetchForecast(cityName: String) -> Single<WeatherForecast> {
        let bundle = Bundle(for: type(of: self))
        if let mock = Mock.sukhothaiForecast.responseObject(with: bundle),
           let weatherForecastDTO = try? JSONDecoder().decode(WeatherForecastDTO.self, from: mock) {
            let weatherForecast = weatherForecastDTO.toDomain()
            return .just(weatherForecast)
        }
        return .never()
    }
}
