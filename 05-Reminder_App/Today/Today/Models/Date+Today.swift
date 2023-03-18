//
//  Date+Today.swift
//  Today
//
//  Created by Kevin on 13.09.22.
//

import Foundation

extension Date {
  
  var dayAndTimeText: String {
    let timeText = formatted(date: .omitted, time: .shortened)
      
    if Locale.current.calendar.isDateInToday(self) {
      let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
      return String(format: timeFormat, timeText)
    } else {
      let dateText = formatted(.dateTime.month(.abbreviated).day())
      let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and Time format string")
      return String(format: dateAndTimeFormat, dateText, timeText)
    }
    
  }
  
  var dayText: String {
    if Locale.current.calendar.isDateInToday(self) {
      return NSLocalizedString("Today", comment: "Today due date description")
    } else {
      return formatted(.dateTime.month().day().weekday(.wide))
    }
  }
  
}
