//
//  ReminderViewController.swift
//  Today
//
//  Created by Kevin on 15.09.22.
//

import UIKit

class ReminderViewController: UICollectionViewController {
  
  // MARK: - Type Alias -
  private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
  
  // MARK: - Properties -
  var reminder: Reminder {
    didSet {
      onChange(reminder)
    }
  }
  // a property that stores the edits until the user decides to save or discart them
  var workingReminder: Reminder
  var isAddingNewReminder = false
  var onChange: (Reminder) -> Void
  private var dataSource: DataSource!
  
  // MARK: - Initializer -
  init(reminder: Reminder, onChange: @escaping (Reminder) -> Void) {
    self.reminder = reminder
    self.workingReminder = reminder
    self.onChange = onChange
    
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    listConfiguration.showsSeparators = false
    listConfiguration.headerMode = .firstItemInSection
    
    let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    super.init(collectionViewLayout: listLayout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Always initialize ReminderViewController using init(reminder:)")
  }
  
  // MARK: - Life Cycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
    
    dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                          for: indexPath,
                                                          item: itemIdentifier)
    }
    
    navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
    navigationItem.rightBarButtonItem = editButtonItem
    
    updateSnapshotForViewing()
    
  }
  
  // MARK: - System method that is run when Edit/Done button is tapped -
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    if editing {
      prepareForEditing()
    } else {
      if !isAddingNewReminder {
        prepareForViewing()
      } else {
        onChange(workingReminder)
      }
      
    }
    
  }
  
  // MARK: - Register the cell -
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
    
    let section = section(for: indexPath)
    switch (section, row) {
        
      case (_, .header(let title)):
        cell.contentConfiguration = headerConfiguration(for: cell, with: title)
      case (.view, _):
        
        cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        
      case (.title, .editText(let title)):
        cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        
      case (.date, .editDate(let date)):
        cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        
      case (.notes, .editText(let note)):
        cell.contentConfiguration = notesConfiguration(for: cell, with: note)
        
      default:
        fatalError("Unexpected combination of section and row.")
    }
    
    
    cell.tintColor = .todayPrimaryTint
  }
  
  // MARK: - Action -
  @objc func didCancelEdit() {
    workingReminder = reminder
    setEditing(false, animated: true)
  }
  
  // When the user enters the editing mode
  private func prepareForEditing() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                       target: self,
                                                       action: #selector(didCancelEdit))
    updateSnapshotForEditing()
  }
  
  // MARK: - Update Snapshot for Editing mode -
  private func updateSnapshotForEditing() {
    var snapshot = Snapshot()
    snapshot.appendSections([.title, .date, .notes])
    snapshot.appendItems([.header(Section.title.name), .editText(reminder.title)], toSection: .title)
    snapshot.appendItems([.header(Section.date.name), .editDate(reminder.dueDate)], toSection: .date)
    snapshot.appendItems([.header(Section.notes.name), .editText(reminder.notes)], toSection: .notes)
    dataSource.apply(snapshot)
  }
  
  // When the user leaves the editing mode
  private func prepareForViewing() {
    navigationItem.leftBarButtonItem = nil
    if workingReminder != reminder {
      reminder = workingReminder
    }
    updateSnapshotForViewing()
  }
  
  // MARK: - Update Snapshot for Viewing mode -
  private func updateSnapshotForViewing() {
    
    var snapshot = Snapshot()
    snapshot.appendSections([.view])
    snapshot.appendItems([.header(""), .viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
    dataSource.apply(snapshot)
    
  }
  
  // Returns the section for a row that you pass in
  private func section(for indexPath: IndexPath) -> Section {
    let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
    guard let section = Section(rawValue: sectionNumber) else { fatalError("Unable to find matching section") }
    return section
  }

}
