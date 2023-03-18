//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 20.4.21.
//

import UIKit

final class TodoListViewController: UIViewController {
  
  // MARK: - Properties -
  var folder: String
  
  // MARK: - UI -
  private lazy var tableView: GenericTableView<TodoTableViewCell, TodoItem> = {
    let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    let predicate = NSPredicate(format: "folder == %@", folder)
    
    let dataProvider = DataProvider<TodoItem>(managedObjectContext: CoreDataManager.shared.managedObjectContext,
                                              sortDescriptors: sortDescriptors, predicate: predicate)
    
    let tableView = GenericTableView<TodoTableViewCell, TodoItem>(dataProvider: dataProvider) { (cell, todoItem) in
      cell.model = todoItem
    } selectionHandler: { todoItem in
      print("\(todoItem.title ?? "")")
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
  
  // MARK: - Initializers -
  init(folder: String) {
    self.folder = folder
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    title = "Todo Items for: \(folder)"
    view.backgroundColor = .white
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
extension TodoListViewController: AddNewItemViewControllerDelegate {
  func saveNewItem(item: String) {
    CoreDataManager.shared.saveTodo(folder: folder, item: item)
    tableView.performFetch()
  }
}
