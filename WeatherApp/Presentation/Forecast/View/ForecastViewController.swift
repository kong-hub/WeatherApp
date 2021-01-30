//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import UIKit
import RxSwift

class ForecastViewController: UIViewController, UseStoryboard, UseViewModel {
    struct Configuration {
        static var headerTitleHeight: CGFloat = 20
        static var cellHeight: CGFloat = 60
    }
    typealias Model = ForecastViewModel
    static var storyboardName: String { "Forecast" }
    static var storyboardIdentifier: String { "ForecastViewController" }
    private var disposeBag = DisposeBag()
    var viewModel: ForecastViewModel?
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    func bind(to model: ForecastViewModel) {
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.reloadData
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.forecastTableView.reloadData()
            })
            .disposed(by: disposeBag)
        viewModel?.loadForecast()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel?.title
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
        forecastTableView.register(nib, forCellReuseIdentifier: ForecastTableViewCell.Configuration.cellIdentifier)
        forecastTableView.tableFooterView = UIView()
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(with: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.Configuration.cellIdentifier,
                                                 for: indexPath)
        if let viewModel = viewModel?.forecastCellViewModelInRow(indexPath: indexPath),
           let forecastCell = cell as? ForecastTableViewCell {
            forecastCell.configure(with: viewModel)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection() ?? 0
    }
}

extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.sectionHeaderTitle(with: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Configuration.headerTitleHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Configuration.cellHeight
    }
}
