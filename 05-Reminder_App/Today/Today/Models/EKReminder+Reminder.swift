//
//  EKReminder+Reminder.swift
//  Today
//
//  Created by Kevin on 25.09.22.
//

import Foundation
import EventKit

extension EKReminder {
  
  // update the reminder in calendar from the app Reminder
  func update(using reminder: Reminder, in store: EKEventStore) {
    title = reminder.title
    notes = reminder.notes
    isCompleted = reminder.isComplete
    calendar = store.defaultCalendarForNewReminders()
    
    // Iterate through the alarms, removing any alarm that doesn’t correspond to the reminder’s due date.
    alarms?.forEach{ alarm in
      guard let absoluteDate = alarm.absoluteDate else { return }
      let comparison = Locale.current.calendar.compare(reminder.dueDate,
                                                       to: absoluteDate,
                                                       toGranularity: .minute)
      if comparison != .orderedSame {
        removeAlarm(alarm)
      }
    }
    
    // If the reminder has no alarms, add an alarm for the due date.
    if !hasAlarms {
      addAlarm(EKAlarm(absoluteDate: reminder.dueDate))
    }
  }
  
}
