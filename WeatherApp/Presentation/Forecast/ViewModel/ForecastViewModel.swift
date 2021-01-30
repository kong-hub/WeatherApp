//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

final class ForecastViewModel {
    
    private var request: SearchWeatherUseCaseRequestValue
    private var forecastUsecase: SearchForecastWeatherUsecaseProtocol
    private var disposeBag = DisposeBag()
    
    var reloadData = PublishSubject<Void>()
    
    private var weatherForecast: WeatherForecast?
    private var daysForecast: [DateComponents: [Weather]] = [:]
    private var sectionDaysComponents: [DateComponents] {
        return daysForecast.keys.sorted { (firstDate, secondDate) -> Bool in
            let calendar = Calendar.current
            guard let firstTime = calendar.date(from: firstDate)?.timeIntervalSince1970,
                  let secondTime = calendar.date(from: secondDate)?.timeIntervalSince1970 else { return false }
            return firstTime < secondTime
        }
    }
    var title: String
    var router: StrongRouter<AppRoute>
    
    required init(router: StrongRouter<AppRoute>,
                  request: SearchWeatherUseCaseRequestValue,
                  forecastUsecase: SearchForecastWeatherUsecaseProtocol) {
        self.router = router
        self.request = request
        self.forecastUsecase = forecastUsecase
        self.title = request.cityName
    }
    
    
    func loadForecast() {
        forecastUsecase.execute(requestValue: request)
            .subscribe(onSuccess: { [unowned self] weatherForecast in
                self.daysForecast = weatherForecast.dayForecast
                self.reloadData.onNext(())
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func numberOfSection() -> Int {
        return sectionDaysComponents.count
    }
    
    func numberOfRowsInSection(with section: Int) -> Int {
        return daysForecast[sectionDaysComponents[section]]?.count ?? 0
    }
    
    func forecastCellViewModelInRow(indexPath: IndexPath) -> ForecastCellViewModel? {
        let section = sectionDaysComponents[indexPath.section]
        if let weather = daysForecast[section]?[indexPath.row] {
            return ForecastCellViewModel(weather: weather)
        }
        return nil
    }
    
    func sectionHeaderTitle(with section: Int) -> String? {
        let calendar = Calendar.current
        let dateComponent = sectionDaysComponents[section]
        if let date = dateComponent.date {
            if calendar.isDateInToday(date) { return "Today" }
            return date.dayOfWeek
        }
        return nil
    }
}
