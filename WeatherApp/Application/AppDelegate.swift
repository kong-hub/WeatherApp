//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 24/1/2564 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window: UIWindow! = UIWindow()
    static let shared = (UIApplication.shared.delegate as? AppDelegate) ?? AppDelegate()
    let router = AppCoordinator().strongRouter
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router.setRoot(for: window)
        return true
    }
}

