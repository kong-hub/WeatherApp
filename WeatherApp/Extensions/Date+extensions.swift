//
//  Date+extensions.swift
//  WeatherApp
//
//  Created by Sorawit Trutsat on 30/1/2564 BE.
//

import Foundation

extension Date {
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    var dayOfWeekComponent: DateComponents {
        Calendar.current.dateComponents([.day, .weekday, .month, .year, .calendar], from: self)
    }
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
