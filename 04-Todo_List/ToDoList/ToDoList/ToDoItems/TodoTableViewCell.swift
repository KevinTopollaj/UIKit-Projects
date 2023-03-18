//
//  TodoTableViewCell.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 20.4.21.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
  
  // MARK: - Properties -
  var model: TodoItem? {
    didSet {
      if let item = model {
        todoTitleLabel.text = item.title
      }
    }
  }
  
  // MARK: - UI -
  private lazy var todoTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  
  // MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Subviews and Constraints -
  func setupView() {
    contentView.addSubview(todoTitleLabel)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      todoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      todoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      todoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      todoTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}
