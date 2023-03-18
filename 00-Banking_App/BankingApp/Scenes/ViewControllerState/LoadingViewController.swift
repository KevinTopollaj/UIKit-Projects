//
//  LoadingViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
  
  // MARK: - UI -
  fileprivate lazy var loadingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .title3, weight: .semibold)
    label.numberOfLines = 1
    label.text = LocalizedString.ViewControllerState.loading
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
    view.addSubview(loadingLabel)
    
    NSLayoutConstraint.activate([
      loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
  }
  
}


