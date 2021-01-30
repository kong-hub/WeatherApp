//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {
    struct Configuration {
        static let cellIdentifier = "ForecastTableViewCell"
        static var iconPlaceholder = UIImage(named: "icon-placeholder")
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        iconImage.image = nil
        descriptionLabel.text = nil
        temperatureLabel.text = nil
    }
    
    func configure(with viewModel: ForecastCellViewModel) {
        timeLabel.text = viewModel.time
        descriptionLabel.text = viewModel.weatherDescription
        temperatureLabel.text = viewModel.temperature
        iconImage.sd_setImage(with: viewModel.iconUrl, placeholderImage: Configuration.iconPlaceholder)
    }
}

