//
//  EventListCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator, EventUpdatingCoordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  
  var onUpdateEvent: () -> Void = {}
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let eventListViewController: EventListViewController = .instantiate()
    let eventListViewModel = EventListViewModel()
    eventListViewModel.coordinator = self
    onUpdateEvent = eventListViewModel.reload
    eventListViewController.viewModel = eventListViewModel
    navigationController.setViewControllers([eventListViewController], animated: false)
  }
  
  func startAddEvent() {
    let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
    addEventCoordinator.parentCoordinator = self
    childCoordinators.append(addEventCoordinator)
    addEventCoordinator.start()
  }
  
  func onSelect(_ id: NSManagedObjectID) {
    // call event detail coordinator
    let eventDetailCoordinator = EventDetailCoordinator(eventID: id, navigationController: navigationController)
    eventDetailCoordinator.parentCoordinator = self
    childCoordinators.append(eventDetailCoordinator)
    eventDetailCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}

