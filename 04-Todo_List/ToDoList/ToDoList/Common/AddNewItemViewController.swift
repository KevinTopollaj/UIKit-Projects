//
//  AddNewItemViewController.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 20.4.21.
//

import CoreData
import UIKit

protocol AddNewItemViewControllerDelegate: class {
  func saveNewItem(item: String)
}

final class AddNewItemViewController: UIViewController {
  // MARK: - Properties -
  weak var delegate: AddNewItemViewControllerDelegate?
  
  // MARK: - UI -
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.text = "Add New"
    label.textColor = .darkGray
    return label
  }()
  
  private lazy var titleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.placeholder = "Add new item"
    return textField
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Save", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - Actions -
  @objc private func didTapSave() {
    guard let text = titleTextField.text,
          !text.isEmpty else {
      return
    }
    
    delegate?.saveNewItem(item: text)
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Subviews and Constraints -
  private func setupView() {
    view.backgroundColor = .white
    [titleLabel, titleTextField, saveButton].forEach { uiView in
      view.addSubview(uiView)
    }
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
      
      titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

      saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      saveButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
      saveButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
