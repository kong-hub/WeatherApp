//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol WeatherRepositoryProtocol {
    func fetchWeather(cityName: String) -> Single<Weather>
    func fetchForecast(cityName: String) -> Single<WeatherForecast>
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private var service: MoyaProvider<WeatherEndpoint>
    
    init(service: MoyaProvider<WeatherEndpoint> = MoyaProvider<WeatherEndpoint>()) {
        self.service = service
    }
    
    func fetchWeather(cityName: String) -> Single<Weather> {
        let target = WeatherEndpoint.current(cityName: cityName)
        return service.rx.request(target).map(WeatherResponseDTO.self).map({ $0.toDomain() })
    }
    
    func fetchForecast(cityName: String) -> Single<WeatherForecast> {
        let target = WeatherEndpoint.forecast(cityName: cityName)
        return service.rx.request(target).map(WeatherForecastDTO.self).map({ $0.toDomain() })
    }
}

