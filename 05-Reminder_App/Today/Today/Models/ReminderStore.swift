//
//  ReminderStore.swift
//  Today
//
//  Created by Kevin on 24.09.22.
//

import Foundation
import EventKit

class ReminderStore {
  
  // MARK: - Properties -
  static let shared = ReminderStore()
  
  private let ekStore = EKEventStore()
  
  var isAvailable: Bool {
    EKEventStore.authorizationStatus(for: .reminder) == .authorized
  }
  
  // MARK: - Helper Methods -
  
  func requestAccess() async throws {
    let status = EKEventStore.authorizationStatus(for: .reminder)
    
    switch status {
      case .authorized:
        return
      case .restricted:
        throw TodayError.accessRestricted
      case .notDetermined:
        let accessGranted = try await ekStore.requestAccess(to: .reminder)
        guard accessGranted else { throw TodayError.accessDenied }
      case .denied:
        throw TodayError.accessDenied
      @unknown default:
        throw TodayError.unkown
    }
  }
  
  // read a specific calendar reminder by id
  private func read(with id: Reminder.ID) throws -> EKReminder {
    guard let ekReminder = ekStore.calendarItem(withIdentifier: id) as? EKReminder else {
      throw TodayError.failedReadingCalendarItem
    }
    return ekReminder
  }
  
  func readAll() async throws -> [Reminder] {
    guard isAvailable else { throw TodayError.accessDenied }
    
    let predicate = ekStore.predicateForReminders(in: nil)
    let ekReminders = try await ekStore.fetchReminders(matching: predicate)
    
    // The resulting array contains only the reminders that have alarms corresponding to their due dates.
    let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
      do {
        return try Reminder(with: ekReminder)
      } catch TodayError.reminderHasNoDueDate {
        return nil
      }
    }
    
    return reminders
    
  }
  
  func remove(with id: Reminder.ID) throws {
    
    guard isAvailable else { throw TodayError.accessDenied }
    let ekReminder = try read(with: id)
    try ekStore.remove(ekReminder, commit: true)
  }
  
  // save a reminder based on an id
  @discardableResult
  func save(_ reminder: Reminder) throws -> Reminder.ID {
    guard isAvailable else { throw TodayError.accessDenied }
    
    let ekReminder: EKReminder
    
    do {
      ekReminder = try read(with: reminder.id)
    } catch {
      ekReminder = EKReminder(eventStore: ekStore)
    }
    
    ekReminder.update(using: reminder, in: ekStore)
    try ekStore.save(ekReminder, commit: true)
    
    return ekReminder.calendarItemIdentifier
  }
  
}
