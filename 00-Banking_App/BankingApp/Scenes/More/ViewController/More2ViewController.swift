//
//  More2ViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class More2ViewController: UIViewController, MoreBaseCoordinated {
  
  // MARK: - UI -
  private lazy var goToMoreScreen3Button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(" Go To More Screen 3 ", for: .normal)
    button.setTitleColor(.systemBackground, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(goToMoreScreen3Action), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Properties -
  weak var coordinator: MoreBaseCoordinator?
  
  // MARK: - Initializers -
  init(coordinator: MoreCoordinator) {
    super.init(nibName: nil, bundle: nil)
    self.coordinator = coordinator
    title = "More 2"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGray
    setSubViewsAndLayoutConstraints()
  }
  
  // MARK: - Helper Methods -
  private func setSubViewsAndLayoutConstraints() {
    view.addSubview(goToMoreScreen3Button)
    
    NSLayoutConstraint.activate([
      goToMoreScreen3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      goToMoreScreen3Button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  // MARK: - Action -
  @objc private func goToMoreScreen3Action() {
    coordinator?.goToMoreScreen3(animated: true)
  }
}
