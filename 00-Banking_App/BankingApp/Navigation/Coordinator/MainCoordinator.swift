//
//  MainCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AppFlow Enum -
enum AppFlow {
  case Home
  case More
}

// MARK: - Conform to MainBaseCoordinator -
class MainCoordinator: MainBaseCoordinator {
  
  // MARK: - Properties -
  /// Create a parentCoordinator (in our case the MainCoordinator does not have a parent so it will stay nil)
  var parentCoordinator: MainBaseCoordinator?
  
  /// Create the the child Coordinators for the MainCoordinator
  /// They are lazy because I want to guarantee that this can be never nil.
  lazy var homeCoordinator: TransactionBaseCoordinator = TransactionCoordinator()
  lazy var moreCoordinator: MoreBaseCoordinator = MoreCoordinator()
  
  /// Create the UITabBarController as the root of the whole application
  lazy var rootViewController: UIViewController = UITabBarController()
  
  // MARK: - Methods -
  /// We start every child coordinator with it's own start() function and set them to the UITabBarController.
  func start() -> UIViewController {
    
    let homeViewController = homeCoordinator.start()
    homeCoordinator.parentCoordinator = self
    homeViewController.tabBarItem = UITabBarItem(title: LocalizedString.TabBarItem.transactions,
                                                 image: UIImage.arrowLeftArrowRightCircle,
                                                 tag: 0)
    
    let moreViewController = moreCoordinator.start()
    moreCoordinator.parentCoordinator = self
    moreViewController.tabBarItem = UITabBarItem(title: LocalizedString.TabBarItem.more,
                                                 image: UIImage.ellipsisCircle,
                                                 tag: 1)
    
    (rootViewController as? UITabBarController)?.viewControllers = [homeViewController, moreViewController]
    
    return rootViewController

  }
  
  /// Is the method that all the coordinators can use to change the app flow.
  func moveTo(flow: AppFlow) {
    switch flow {
      case .Home:
        (rootViewController as? UITabBarController)?.selectedIndex = 0
      case .More:
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
  }
  
  /// Is just a overwrite of the resetToRoot, and in this case has a custom reset.
  func resetToRoot() -> Self {
    homeCoordinator.resetToRoot()
    moveTo(flow: .Home)
    return self
  }
  
}
