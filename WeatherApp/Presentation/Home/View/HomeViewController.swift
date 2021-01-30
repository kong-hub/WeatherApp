//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 27/1/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController, UseStoryboard, UseViewModel {
    typealias Model = HomeViewModel
    struct Configuration {
        static var iconPlaceholder = UIImage(named: "icon-placeholder")
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temparetureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    @IBOutlet weak var forecastNavButton: UIBarButtonItem!
    
    var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    func bind(to model: HomeViewModel) {
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingRx()
        setupViews()
    }
    
    private func setupViews() {
        viewModel?.cityNameInput.onNext(searchBar.text ?? "")
        searchBar.delegate = self
    }
    
    private func bindingRx() {
        guard let viewModel = viewModel else { return }
        // MARK: Binding Input
        unitSwitch.rx
            .selectedSegmentIndex
            .map({ index -> UnitTemperature in
                return index == 0 ? .celsius : .fahrenheit
            })
            .bind(to: viewModel.unitOfTemperatureTapped)
            .disposed(by: disposeBag)
        
        forecastNavButton.rx
            .tap
            .bind {
                self.viewModel?.routeToForecast()
            }
            .disposed(by: disposeBag)
        
        // MARK: Binding Output
        viewModel.weatherIconUrl
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] iconUrl in
                self.weatherImage.sd_setImage(with: iconUrl,
                                              placeholderImage: Configuration.iconPlaceholder)
            })
            .disposed(by: disposeBag)
        
        viewModel.temperatureString
            .asDriver()
            .drive(temparetureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.descriptionString
            .asDriver()
            .drive(weatherDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.sunsetString
            .asDriver()
            .drive(sunsetLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.sunriseString
            .asDriver()
            .drive(sunriseLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.humidityString
            .asDriver()
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] msg in
                let alert = UIAlertController(title: "Opps! Something went wrong.",
                                              message: msg,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
        })
        .disposed(by: disposeBag)
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cityName = searchBar.text {
            viewModel?.cityNameInput.onNext(cityName)
        }
    }
}
