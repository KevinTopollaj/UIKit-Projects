//
//  Coordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation
import UIKit

protocol FlowCoordinator: AnyObject {
  var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
  var rootViewController: UIViewController { get set }
  func start() -> UIViewController
  @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
  var navigationRootViewController: UINavigationController? {
    get {
      (rootViewController as? UINavigationController)
    }
  }
  
  func resetToRoot() -> Self {
    navigationRootViewController?.popToRootViewController(animated: false)
    return self
  }
}
