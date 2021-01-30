//
//  UseStoryboard.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import UIKit


protocol UseStoryboard {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension UseStoryboard where Self: UIViewController {
    static var storyboardName: String { return "Home" }
    static var storyboardIdentifier: String { return String(describing: Self.self) }
    static var storyboard: UIStoryboard? {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    static var viewController: Self? {
        return storyboard?.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self
    }
}

protocol UseViewModel {
    associatedtype Model
    var viewModel: Model? { get set }
    func bind(to model: Model)
}

extension UseViewModel where Self: UIViewController, Self: UseStoryboard {
    static func newInstance(with viewModel: Model) -> Self {
        let storyboard = UIStoryboard(name: Self.storyboardName, bundle: Bundle.main)
        let vcIdentifier = Self.storyboardIdentifier
        if let viewController = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? Self {
            viewController.bind(to: viewModel)
            return viewController
        } else {
            return Self()
        }
    }
    
    static func newInstance() -> Self {
        let storyboard = UIStoryboard(name: Self.storyboardName, bundle: Bundle.main)
        let vcIdentifier = Self.storyboardIdentifier
        if let viewController = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? Self {
            return viewController
        } else {
            return Self()
        }
    }
}
