//
//  WeatherCurrentViewModelTests.swift
//  WeatherAppTests
//
//  Created by Sorawit Trutsat on 31/1/2564 BE.
//

import XCTest
import RxSwift
@testable import WeatherApp

class WeatherCurrentViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag!
    override func setUpWithError() throws {
        let mockRepo = MockWeatherRepository()
        let usecase = SearchCurrentWeatherUsecase(weatherRepository: mockRepo)
        viewModel = HomeViewModel(router: AppDelegate.shared.router, weatherUsecase: usecase)
        disposeBag = DisposeBag()
    }
    
    func testViewModel() {
        let expect = expectation(description: "Integation test")
        viewModel.cityNameInput.onNext("Sukhothai")
        XCTAssertEqual(viewModel.humidityString.value, "99")
        XCTAssertEqual(viewModel.sunriseString.value, "06:53")
        XCTAssertEqual(viewModel.sunsetString.value, "18:16")
        XCTAssertEqual(viewModel.temperatureString.value, 25.0.celsiusFormat)
        expect.fulfill()
        wait(for: [expect], timeout: defaultTimeout)
    }
    
    func testChangeUnit() {
        let expect = expectation(description: "Integation test change unit")
        viewModel.cityNameInput.onNext("Sukhothai")
        XCTAssertEqual(viewModel.humidityString.value, "99")
        XCTAssertEqual(viewModel.sunriseString.value, "06:53")
        XCTAssertEqual(viewModel.sunsetString.value, "18:16")
        XCTAssertEqual(viewModel.temperatureString.value, 25.0.celsiusFormat)
        viewModel.unitOfTemperatureTapped.onNext(.fahrenheit)
        XCTAssertEqual(viewModel.humidityString.value, "99")
        XCTAssertEqual(viewModel.sunriseString.value, "06:53")
        XCTAssertEqual(viewModel.sunsetString.value, "18:16")
        XCTAssertEqual(viewModel.temperatureString.value, 77.0.fahrenheitFormat)
        expect.fulfill()
        wait(for: [expect], timeout: defaultTimeout)
    }
}

fileprivate extension Double {
    var fahrenheitFormat: String {
        let measurement = Measurement(value: self, unit: UnitTemperature.fahrenheit)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
}
