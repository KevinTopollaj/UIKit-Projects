//
//  AppCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

protocol Coordinator: class {
  // keeps track of coordinators and makes sure we dont dealocate them imediately
  var childCoordinators: [Coordinator] { get }
  // entry point for each coordinator
  func start()
  
  func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
  func childDidFinish(_ childCoordinator: Coordinator) { }
}

final class AppCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = EventNavigationController()
    
    let eventListCoordinator = EventListCoordinator(navigationController: navigationController)

    childCoordinators.append(eventListCoordinator)
    eventListCoordinator.start()
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
