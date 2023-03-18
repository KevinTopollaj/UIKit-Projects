//
//  Date+Extensions.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 7.4.21.
//

import Foundation

extension Date {
  func timeRemaining(until endDate: Date) -> String? {
    let dateComponentsFormatter = DateComponentsFormatter()
    dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
    dateComponentsFormatter.unitsStyle = .full
    return dateComponentsFormatter.string(from: self, to: endDate)
  }
}
