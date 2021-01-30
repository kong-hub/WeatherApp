//
//  SearchWeatherUsecase.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation
import RxSwift

protocol SearchWeatherUseCaseProtocol {
    func execute(requestValue: SearchWeatherUseCaseRequestValue) -> Single<Weather>
}

final class SearchCurrentWeatherUsecase: SearchWeatherUseCaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol
    
    required init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }
    
    func execute(requestValue: SearchWeatherUseCaseRequestValue) -> Single<Weather> {
        return weatherRepository.fetchWeather(cityName: requestValue.cityName)
    }
}
