//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 27/1/2564 BE.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

final class HomeViewModel {
    // MARK: Input
    let unitOfTemperatureTapped = PublishSubject<UnitTemperature>()
    let cityNameInput = PublishSubject<String>()
    
    // MARK: Output
    let weatherIconUrl = BehaviorRelay<URL?>(value: nil)
    let temperatureString = BehaviorRelay<String>(value: "")
    let descriptionString = BehaviorRelay<String>(value: "")
    let humidityString = BehaviorRelay<String>(value: "")
    let sunsetString = BehaviorRelay<String>(value: "")
    let sunriseString = BehaviorRelay<String>(value: "")
    let errorMessage = PublishSubject<String>()

    private var weather: Weather?
    private var currentUnitTemperature: UnitTemperature = .celsius
    private let disposeBag = DisposeBag()
    private var weatherUsecase: SearchWeatherUseCaseProtocol
    var router: StrongRouter<AppRoute>
    
    init(router: StrongRouter<AppRoute>,
         weatherUsecase: SearchWeatherUseCaseProtocol) {
        self.router = router
        self.weatherUsecase = weatherUsecase
        bindingRx()
    }
    
    func bindingRx() {
        cityNameInput
            .filter({ $0.count > 3 })
            .asObservable()
            .subscribe(onNext: { [unowned self] cityName in
                self.requestCurrentWeather(with: cityName)
            })
            .disposed(by: disposeBag)
        
        unitOfTemperatureTapped
            .asObserver()
            .subscribe(onNext: { [unowned self] unit in
                guard let currentCelsiusTemp = self.weather?.temperature else { return }
                self.currentUnitTemperature = unit
                switch unit {
                case.celsius:
                    let measurement = Measurement(value: currentCelsiusTemp, unit: UnitTemperature.celsius)
                    let temperatureString = self.temperatureString(from: measurement)
                    self.temperatureString.accept(temperatureString)
                case.fahrenheit:
                    let measurement = Measurement(value: currentCelsiusTemp, unit: UnitTemperature.celsius)
                    let temperatureString = self.temperatureString(from: measurement.converted(to: .fahrenheit))
                    self.temperatureString.accept(temperatureString)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func routeToForecast() {
        if let cityName = weather?.name {
            router.trigger(.forecast(cityName: cityName))
        }
    }
    
    private func requestCurrentWeather(with cityName: String) {
        let request = SearchWeatherUseCaseRequestValue(cityName: cityName)
        weatherUsecase.execute(requestValue: request)
            .subscribe { [unowned self] weather in
                self.weather = weather
                self.weatherIconUrl.accept(weather.iconUrl)
                self.descriptionString.accept(weather.weatherDescription)
                self.unitOfTemperatureTapped.onNext(self.currentUnitTemperature)
                self.sunsetString.accept(weather.sunset.toTimeString())
                self.sunriseString.accept(weather.sunrise.toTimeString())
                self.humidityString.accept("\(weather.humidity)")
            } onError: { error in
                self.errorMessage.onNext("No results found. :)")
                // TODO: should display the error or message popup
            }
            .disposed(by: disposeBag)
    }

    private func temperatureString(from measurement: Measurement<UnitTemperature>) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
}
