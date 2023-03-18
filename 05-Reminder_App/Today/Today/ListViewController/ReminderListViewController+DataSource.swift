//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Kevin on 13.09.22.
//

import UIKit

extension ReminderListViewController {
  
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
  //  A snapshot represents the state of your data at a specific point in time.
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
  
  /// Computed Properties for Completed and NonCompleted Values
  var reminderCompletedValue: String {
    NSLocalizedString("Completed", comment: "Reminder completed value")
  }
  
  var reminderNotCompletedValue: String {
    NSLocalizedString("Not completed", comment: "Reminder not completed value")
  }
  
  private var reminderStore: ReminderStore { ReminderStore.shared }
  
  /// Update Snapshots based on the Reminder ids
  func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
    let ids = idsThatChanged.filter { id in filterReminders.contains(where: {$0.id == id} ) }
    // initialize snapshot and apply it to datasource
    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(filterReminders.map { $0.id })
    if !ids.isEmpty {
      snapshot.reloadItems(ids)
    }
    dataSource.apply(snapshot)
    
    headerView?.progress = progress
  }
  
  /// Create a Cell Registration
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
    let reminder = reminder(for: id)
    
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = reminder.title
    contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
    contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
    cell.contentConfiguration = contentConfiguration
    
    var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
    doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
    cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
    cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
    cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
    
    var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
    backgroundConfiguration.backgroundColor = .todayListCellBackground
    cell.backgroundConfiguration = backgroundConfiguration
  }
  
  /// Complete a reminder based on the ID
  func completeReminder(with id: Reminder.ID) {
    var reminder = reminder(for: id)
    reminder.isComplete.toggle()
    update(reminder, with: id)
    updateSnapshot(reloading: [id])
  }
  
  /// Create Accessibility for the reminder
  private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
    let name = NSLocalizedString("Toggle Completion", comment: "Reminder done button accessibility label")
    let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
      self?.completeReminder(with: reminder.id)
      return true
    }
    return action
  }
  
  /// Create a Custom Configuration for DoneButton
  private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
    let symbolName = reminder.isComplete ? "circle.fill" : "circle"
    let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
    let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
    
    let button = ReminderDoneButton()
    button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
    button.id = reminder.id
    button.setImage(image, for: .normal)
    return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
  }
  
  // MARK: - Helper Methods -
  
  func prepareReminderStore() {
    // By creating a Task, you create a new unit of work that executes asynchronously.
    Task {
      do {
        try await reminderStore.requestAccess()
        reminders = try await reminderStore.readAll()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventStoreChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: nil)
      } catch TodayError.accessDenied, TodayError.accessRestricted {
        #if DEBUG
        reminders = Reminder.sampleData
        #endif
      } catch {
        showError(error)
      }
      
      updateSnapshot()
    }
  }
  
  // notifies when a reminder store changes
  func reminderStoreChanged() {
    Task {
      reminders = try await reminderStore.readAll()
      updateSnapshot()
    }
  }
  
  func deleteReminder(with id: Reminder.ID) {
    
    do {
      try reminderStore.remove(with: id)
      let index = reminders.indexOfReminder(with: id)
      reminders.remove(at: index)
    } catch TodayError.accessDenied {
      
    } catch {
      showError(error)
    }
    
  }
  
  func add(_ reminder: Reminder) {
    var reminder = reminder
    do {
      let idFromStore = try reminderStore.save(reminder)
      reminder.id = idFromStore
      reminders.append(reminder)
    } catch TodayError.accessDenied {
      
    } catch {
      showError(error)
    }
    
  }
  
  /// Get a reminder based on the ID
  func reminder(for id: Reminder.ID) -> Reminder {
    let index = reminders.indexOfReminder(with: id)
    return reminders[index]
  }
  
  /// Update a reminder based on the ID
  func update(_ reminder: Reminder, with id: Reminder.ID) {
    
    do {
      try reminderStore.save(reminder)
      let index = reminders.indexOfReminder(with: id)
      reminders[index] = reminder
    } catch TodayError.accessDenied {
      
    } catch {
      showError(error)
    }
    
  }
}
