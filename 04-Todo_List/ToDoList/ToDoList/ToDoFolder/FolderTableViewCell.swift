//
//  FolderTableViewCell.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 20.4.21.
//

import UIKit

final class FolderTableViewCell: UITableViewCell {
  
  // MARK: - Properties -
  var model: TodoFolder? {
    didSet {
      if let folder = model {
        folderTitle.text = folder.title
      }
    }
  }
  
  // MARK: - UI -
  private lazy var folderTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.numberOfLines = 0
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
    contentView.addSubview(folderTitle)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      folderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      folderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      folderTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      folderTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}
