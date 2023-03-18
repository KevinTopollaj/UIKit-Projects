//
//  ViewController.swift
//  Today
//
//  Created by Kevin on 12.09.22.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
  
  // MARK: - Properties -
  var dataSource: DataSource!
  
  var reminders: [Reminder] = []
  
  var filterReminders: [Reminder] {
    return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted { $0.dueDate < $1.dueDate }
  }
  
  var listStyle: ReminderListStyle = .today
  
  let listStyleSegmentedControl = UISegmentedControl(items: [ReminderListStyle.today.name,
                                                             ReminderListStyle.future.name,
                                                             ReminderListStyle.all.name])
  
  var headerView: ProgressHeaderView?
  
  var progress: CGFloat {
    let chunkSize = 1.0 / CGFloat(filterReminders.count)
    let progress = filterReminders.reduce(0.0) {
      let chunk = $1.isComplete ? chunkSize : 0
      return $0 + chunk
    }
    return progress
  }
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .todayGradientFutureBegin
    
    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout
    
    // register a cell
    let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
    
    // initialize datasource
    dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView,
                                                               indexPath: IndexPath,
                                                               itemIdentifier: Reminder.ID) in
      
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }
    
    // register supplementary view
    let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind,
                                                                        handler: supplementaryRegistrationHandler)
    
    dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
      return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                        for: indexPath)
    }
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
    addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
    navigationItem.rightBarButtonItem = addButton
        
    listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
    listStyleSegmentedControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
    navigationItem.titleView = listStyleSegmentedControl
    
    updateSnapshot()
    
    collectionView.dataSource = dataSource
    
    prepareReminderStore()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    refreshBackground()
  }
  
  // MARK: - CollectionViewDelegate -
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let id = filterReminders[indexPath.item].id
    showDetail(for: id)
    return false
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String,
                               at indexPath: IndexPath) {
    
    guard elementKind == ProgressHeaderView.elementKind,
          let progressView = view as? ProgressHeaderView else { return }
    
    progressView.progress = progress
  }
  
  // MARK: - Refresh Background -
  func refreshBackground() {
    collectionView.backgroundView = nil
    let backgroundView = UIView()
    let gradientLayer = CAGradientLayer.gradientLayer(for: listStyle, in: collectionView.frame)
    backgroundView.layer.addSublayer(gradientLayer)
    collectionView.backgroundView = backgroundView
  }
  
  // MARK: - Navigate to Detail View -
  
  func showDetail(for id: Reminder.ID) {
    let reminder = reminder(for: id)
    let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
      self?.update(reminder, with: reminder.id)       // update the model
      self?.updateSnapshot(reloading: [reminder.id])  // update the UI
    }
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Show errors -
  func showError(_ error: Error) {
    let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
    let alert = UIAlertController(title: alertTitle,
                                  message: error.localizedDescription,
                                  preferredStyle: .alert)
    let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
    
    alert.addAction(UIAlertAction(title: actionTitle,
                                  style: .default,
                                  handler: { [weak self] _ in
      self?.dismiss(animated: true)
    }))
    present(alert, animated: true, completion: nil)
  }

  // MARK: - Create Layout -
  private func listLayout() -> UICollectionViewCompositionalLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    listConfiguration.headerMode = .supplementary
    listConfiguration.showsSeparators = false
    listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeAction
    listConfiguration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }
  
  // MARK: - Create swipe action configuration -
  
  private func makeSwipeAction(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
    guard let indexPath = indexPath,
          let id = dataSource.itemIdentifier(for: indexPath) else {
      return nil
    }

    let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
    let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
      self?.deleteReminder(with: id)
      self?.updateSnapshot()
      completion(false)
    }
    
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }

  // MARK: - Supplementary View Registration -
  private func supplementaryRegistrationHandler(progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath) {
    headerView = progressView
  }
  
}

