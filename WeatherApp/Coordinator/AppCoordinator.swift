//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation
import XCoordinator

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            let repo = WeatherRepository()
            let usecase = SearchCurrentWeatherUsecase(weatherRepository: repo)
            let viewModel = HomeViewModel(router: strongRouter, weatherUsecase: usecase)
            let viewController = HomeViewController.newInstance(with: viewModel)
            return .set([viewController])
        case .forecast(let cityName):
            let repo = WeatherRepository()
            let usecase = SearchForecastWeatherUsecase(weatherRepository: repo)
            let request = SearchWeatherUseCaseRequestValue(cityName: cityName)
            let viewModel = ForecastViewModel(router: strongRouter,
                                              request: request,
                                              forecastUsecase: usecase)
            let viewController = ForecastViewController.newInstance(with: viewModel)
            return .push(viewController)
        }
    }
}
