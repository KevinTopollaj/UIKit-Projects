//
//  More3ViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class More3ViewController: UIViewController, MoreBaseCoordinated {
  
  // MARK: - Properties -
  weak var coordinator: MoreBaseCoordinator?
  
  // MARK: - Initializers -
  init(coordinator: MoreCoordinator) {
    super.init(nibName: nil, bundle: nil)
    self.coordinator = coordinator
    title = "More 3"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemIndigo
  }
  
}
