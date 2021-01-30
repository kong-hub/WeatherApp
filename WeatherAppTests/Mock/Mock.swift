//
//  Mock.swift
//  WeatherAppTests
//
//  Created by Sorawit Trutsat on 31/1/2564 BE.
//

import Foundation

enum Mock: String {
    case sukhothaiWeather
    case sukhothaiForecast
    
    public func responseObject(with bundle: Bundle?) -> Data? {
        let bundle = bundle ?? Bundle.main
        if let url = bundle.url(forResource: self.rawValue, withExtension: "json") {
            do {
                return try Data(contentsOf: url, options: .mappedIfSafe)
            } catch {
                print("Error!! Unable to parse \(self.rawValue).json")
            }
        }
        return nil
    }
}
