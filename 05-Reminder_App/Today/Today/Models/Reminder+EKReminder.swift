//
//  Reminder+EKReminder.swift
//  Today
//
//  Created by Kevin on 24.09.22.
//

import Foundation
import EventKit

extension Reminder {
  
  init(with ekReminder: EKReminder) throws {
    guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
      throw TodayError.reminderHasNoDueDate
    }
    id = ekReminder.calendarItemIdentifier
    title = ekReminder.title
    self.dueDate = dueDate
    notes = ekReminder.notes
    isComplete = ekReminder.isCompleted
  }
}
