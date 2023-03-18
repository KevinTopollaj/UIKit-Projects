//
//  RetryViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

@objc protocol FailableView: AnyObject {
  func retry()
}

class RetryViewController: UIViewController {
  
  // MARK: - UI -
  lazy var errorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .headline, weight: .semibold)
    label.numberOfLines = 0
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var retryButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.ViewControllerState.retry, for: .normal)
    button.setTitleColor(.systemBackground, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    button.addTarget(nil,
                     action: #selector(FailableView.retry),
                     for: .primaryActionTriggered)
    return button
  }()
  
  lazy var mainStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [errorLabel, retryButton])
    stack.alignment = .center
    stack.distribution = .fill
    stack.axis = .vertical
    stack.spacing = 16
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    setSubviewsAndLayout()
  }
  
  // MARK: - Subviews and Layout -
  func setSubviewsAndLayout() {
    view.backgroundColor = .systemBackground
    view.addSubview(mainStackView)
    
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
  }
}
