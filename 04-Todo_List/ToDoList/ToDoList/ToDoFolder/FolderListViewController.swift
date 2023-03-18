//
//  ViewController.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 19.4.21.
//

import CoreData
import UIKit

class FolderListViewController: UIViewController {
  
  // MARK: - UI -
  private lazy var tableView: GenericTableView<FolderTableViewCell, TodoFolder> = {
    let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    let dataProvider = DataProvider<TodoFolder>(managedObjectContext: CoreDataManager.shared.managedObjectContext,
                                                sortDescriptors: sortDescriptors)
    let tableView = GenericTableView<FolderTableViewCell, TodoFolder>(dataProvider: dataProvider) { (cell, folder) in
      cell.model = folder
    } selectionHandler: { [weak self] folder in
      guard let self = self,
            let folderTitle = folder.title else { return }
      let todoListViewController = TodoListViewController(folder: folderTitle)
      self.navigationController?.pushViewController(todoListViewController, animated: true)
    }
    return tableView
  }()
  
  private lazy var addNewButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold)
    let image = UIImage(systemName: "plus", withConfiguration: config)
    button.setImage(image, for: .normal)
    button.tintColor = .white
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 10
    button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    button.addTarget(self, action: #selector(didTapNew(_:)), for: .touchUpInside)
    return button
  }()

  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    tableView.performFetch()
  }

  // MARK: - Actions -
  @objc private func didTapNew(_ sender: UIButton) {
    let addNewItemViewController = AddNewItemViewController()
    addNewItemViewController.delegate = self
    present(addNewItemViewController, animated: true)
  }
  
  // MARK: - Subviews and Constraints -
  func setupView() {
    title = "Todo Folders"
    view.addSubview(tableView)
    view.addSubview(addNewButton)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      addNewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 12),
      addNewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.bounds.width / 15),
      addNewButton.widthAnchor.constraint(equalToConstant: 44),
      addNewButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}

// MARK: - AddNewItemViewControllerDelegate -
extension FolderListViewController: AddNewItemViewControllerDelegate {
  func saveNewItem(item: String) {
    CoreDataManager.shared.saveFolder(name: item)
    tableView.performFetch()
  }
}
