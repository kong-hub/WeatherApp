//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import Foundation
import Moya

enum WeatherEndpoint {
    case current(cityName: String)
    case forecast(cityName: String)
}

extension WeatherEndpoint: TargetType {
    private var appid: String {
        return AppConfig.shared.appid
    }
    var baseURL: URL {
        return AppConfig.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .current: return "/weather"
        case .forecast: return "/forecast"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .current(let cityName),
             .forecast(let cityName):
            let parameters: [String: Any] = ["q": cityName,
                                             "units": "metric",
                                             "appid": appid]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
