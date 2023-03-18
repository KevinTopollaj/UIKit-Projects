//
//  EventDetailCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import CoreData
import UIKit

final class EventDetailCoordinator: Coordinator, EventUpdatingCoordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let eventID: NSManagedObjectID
  
  var parentCoordinator: EventListCoordinator?
  var onUpdateEvent = {}
  
  init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
    self.eventID = eventID
    self.navigationController = navigationController
  }
  
  func start() {
    // create event detail view controller
    let detailViewController: EventDetailViewController = .instantiate()
    // create and add event detail view model to the detail view controller
    let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
    eventDetailViewModel.coordinator = self
    onUpdateEvent =  {
      eventDetailViewModel.reload()
      self.parentCoordinator?.onUpdateEvent()
    }
    detailViewController.viewModel = eventDetailViewModel
    // push detail view controller into navigation controller
    navigationController.pushViewController(detailViewController, animated: true)
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func onEditEvent(_ event: Event) {
    let editEventCoordinator = EditEventCoordinator(event: event, navigationController: navigationController)
    editEventCoordinator.parentCoordinator = self
    childCoordinators.append(editEventCoordinator)
    editEventCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}
