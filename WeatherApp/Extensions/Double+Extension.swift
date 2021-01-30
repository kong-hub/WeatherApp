//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation


extension Double {
    var celsiusFormat: String {
        let measurement = Measurement(value: self, unit: UnitTemperature.celsius)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
}
