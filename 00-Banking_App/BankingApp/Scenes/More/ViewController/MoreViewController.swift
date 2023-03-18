//
//  MoreViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, MoreBaseCoordinated {
  
  // MARK: - UI -
  private lazy var goToMoreScreen2: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(" Go To More Screen 2 ", for: .normal)
    button.setTitleColor(.systemBackground, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(goToMoreScreen2Action), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Properties -
  weak var coordinator: MoreBaseCoordinator?
  
  // MARK: - Initializers -
  init(coordinator: MoreBaseCoordinator) {
    super.init(nibName: nil, bundle: nil)
    self.coordinator = coordinator
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "More"
    view.backgroundColor = .systemBackground
    
    setSubViewsAndLayoutConstraints()
  }
  
  // MARK: - Helper Methods -
  private func setSubViewsAndLayoutConstraints() {
    view.addSubview(goToMoreScreen2)
    
    NSLayoutConstraint.activate([
      goToMoreScreen2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      goToMoreScreen2.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  // MARK: - Action -
  @objc private func goToMoreScreen2Action() {
    coordinator?.goToMoreScreen2(animated: true)
  }
}
