//
//  EmptyViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {
  
  // MARK: - UI -
  fileprivate lazy var emptyLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .title3, weight: .semibold)
    label.numberOfLines = 1
    label.text = LocalizedString.ViewControllerState.emptyTransactionList
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    setSubviewsAndLayout()
  }
  
  // MARK: - Subviews and Layout -
  func setSubviewsAndLayout() {
    view.backgroundColor = .systemBackground
    view.addSubview(emptyLabel)
    
    NSLayoutConstraint.activate([
      emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
  }
  
}
