//
//  AppConfig.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 31/1/2564 BE.
//

import Foundation

final class AppConfig {
    static let shared = AppConfig()
    private let configs: NSDictionary
    
    init() {
        if let configPath = Bundle.main.path(forResource: .fileName, ofType: .fileType),
           let loadedConfig = NSDictionary(contentsOfFile: configPath) {
            configs = loadedConfig
        } else {
            configs = [:]
        }
    }
    
    func configStringValue(for key: String) -> String {
        let result = configs.object(forKey: key) as? String ?? ""
        return result
    }
    
    lazy var baseUrl = {
        return configStringValue(for: .baseUrl)
    }()
    
    var baseURL: URL {
        do {
            return try baseUrl.asURL()
        } catch {
            print("error initialzing url")
        }
        fatalError("cannot initialzing url!")
    }
    
    lazy var appid = {
        return configStringValue(for: .appidKey)
    }()
}

fileprivate extension String {
    static let fileName = "AppConfig"
    static let fileType = "plist"
    static let baseUrl = "baseUrl"
    static let apiVersion = "apiVesion"
    static let appidKey = "appidkey"
}
