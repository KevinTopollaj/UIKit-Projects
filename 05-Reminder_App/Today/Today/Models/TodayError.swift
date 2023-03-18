//
//  TodayError.swift
//  Today
//
//  Created by Kevin on 24.09.22.
//

import Foundation

enum TodayError: LocalizedError {
  case accessDenied
  case accessRestricted
  case failedReadingCalendarItem
  case failedReadingReminders
  case reminderHasNoDueDate
  case unkown
  
  var errorDescription: String? {
    switch self {
      case .accessDenied:
        return NSLocalizedString("The app doesn't have permissions to read reminders.", comment: "access denied error description")
      case .accessRestricted:
        return NSLocalizedString("This device doesn't allow access to reminders.", comment: "access restricted error description")
      case .failedReadingCalendarItem:
        return NSLocalizedString("Failed to read a calendar item.", comment: "failed reading calendar item description.")
      case .failedReadingReminders:
        return NSLocalizedString("Failed to read reminders.", comment: "failed reading reminders error description")
      case .reminderHasNoDueDate:
        return NSLocalizedString("A reminder has no due date.", comment: "reminder has no due date error description")
      case .unkown:
        return NSLocalizedString("An unknown error ocurred.", comment: "unknown error description")
    }
  }
}
