//
//  AppRoute.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import XCoordinator

enum AppRoute: Route {
    case home
    case forecast(cityName: String)
}
