//
//  SearchForecastWeatherUsecase.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation
import RxSwift

protocol SearchForecastWeatherUsecaseProtocol {
    func execute(requestValue: SearchWeatherUseCaseRequestValue) -> Single<WeatherForecast>
}

final class SearchForecastWeatherUsecase: SearchForecastWeatherUsecaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol
    
    required init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }
    
    func execute(requestValue: SearchWeatherUseCaseRequestValue) -> Single<WeatherForecast> {
        return weatherRepository.fetchForecast(cityName: requestValue.cityName)
    }
}
