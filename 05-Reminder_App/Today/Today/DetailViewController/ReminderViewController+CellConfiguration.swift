//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import UIKit

extension ReminderViewController {
  
  // Default list view cell configration
  func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = text(for: row)
    contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
    contentConfiguration.image = row.image
    return contentConfiguration
  }
  
  // Header Configuration
  func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = title
    return contentConfiguration
  }
  
  //
  func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
    var contentConfiguration = cell.textFieldConfiguration()
    contentConfiguration.text = title
    contentConfiguration.onChange = { [weak self] title in
      self?.workingReminder.title = title
    }
    return contentConfiguration
  }
  
  func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
    var contentConfiguration = cell.datePickerConfiguration()
    contentConfiguration.date = date
    contentConfiguration.onChange = { [weak self] date in
      self?.workingReminder.dueDate = date
    }
    return contentConfiguration
  }
  
  func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
    var contentConfiguration = cell.textViewConfiguration()
    contentConfiguration.text = notes
    contentConfiguration.onChange = { [weak self] notes in
      self?.workingReminder.notes = notes
    }
    return contentConfiguration
  }
  
  // Get text for each specific row
  func text(for row: Row) -> String? {
    switch row {
      case .viewDate:  return reminder.dueDate.dayText
      case .viewNotes: return reminder.notes
      case .viewTime:  return reminder.dueDate.formatted(date: .omitted, time: .shortened)
      case .viewTitle: return reminder.title
      default: return nil
    }
  }
  
}
