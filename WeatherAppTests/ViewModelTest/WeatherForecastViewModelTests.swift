//
//  WeatherForecastViewModelTests.swift
//  WeatherAppTests
//
//  Created by Sorawit Trutsat on 31/1/2564 BE.
//

import XCTest
import RxSwift
@testable import WeatherApp

class WeatherForecastViewModelTests: XCTestCase {

    var viewModel: ForecastViewModel!
    var disposeBag: DisposeBag!
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        let params = "Sukhothai"
        let request = SearchWeatherUseCaseRequestValue(cityName: params)
        let mockWeatherRepo = MockWeatherRepository()
        let mockUsecase = SearchForecastWeatherUsecase(weatherRepository: mockWeatherRepo)
        viewModel = ForecastViewModel(router: AppDelegate.shared.router,
                                      request: request,
                                      forecastUsecase: mockUsecase)
    }
    
    func testTitleName() {
        XCTAssertEqual(viewModel.title, "Sukhothai", "title name should equal mock data")
    }
    
    func testFetchForecast() {
        let expect = expectation(description: "Fetch json successfully!")
        viewModel.reloadData
            .subscribe(onNext: { _ in
                let numberOfSection = self.viewModel.numberOfSection()
                XCTAssertEqual(numberOfSection, 5, "should be 5 becuase forecast json have 5 days")
                XCTAssertEqual(self.viewModel.numberOfRowsInSection(with: 0), 8)
                let indexPath = IndexPath(row: 0, section: 0)
                let firstSection = self.viewModel.forecastCellViewModelInRow(indexPath: indexPath)
                XCTAssertNotNil(firstSection, "Should not be nil")
                XCTAssertEqual(firstSection?.time, "01:00")
                XCTAssertEqual(firstSection?.weatherDescription, "clear sky")
                XCTAssertNotNil(firstSection?.iconUrl, "icon image url should not be nil")
                XCTAssertEqual(firstSection?.temperature, 24.31.celsiusFormat)
                expect.fulfill()
        }, onError: { error in
            XCTFail(error.localizedDescription)
            expect.fulfill()
        })
        .disposed(by: disposeBag)
        viewModel.loadForecast()
        wait(for: [expect], timeout: defaultTimeout)
    }
}
