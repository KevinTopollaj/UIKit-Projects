//
//  MoreCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class MoreCoordinator: MoreBaseCoordinator {
  
  // MARK: - Properties -
  weak var parentCoordinator: MainBaseCoordinator?
  lazy var rootViewController: UIViewController = UIViewController()
  
  // MARK: - Methods -
  func start() -> UIViewController {
    let moreViewController = MoreViewController(coordinator: self)
    let navigationController = UINavigationController(rootViewController: moreViewController)
    rootViewController = navigationController
    return rootViewController
  }
  
  func goToMoreScreen2(animated: Bool) -> Self {
    let more2ViewController = More2ViewController(coordinator: self)
    navigationRootViewController?.pushViewController(more2ViewController, animated: animated)
    return self
  }
  
  func goToMoreScreen3(animated: Bool) -> Self {
    navigationRootViewController?.pushViewController(More3ViewController(coordinator: self), animated: animated)
    return self
  }
  
}
