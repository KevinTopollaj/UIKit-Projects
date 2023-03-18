//
//  AddEventCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

final class AddEventCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private var modalNavigationController: UINavigationController?
  private var completion: (UIImage) -> Void = { _ in }
  
  var parentCoordinator: (EventUpdatingCoordinator & Coordinator)?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    self.modalNavigationController = UINavigationController()
    let addEventViewController: AddEventViewController = .instantiate()
    modalNavigationController?.setViewControllers([addEventViewController], animated: false)
    let addEventViewModel = AddEventViewModel(eventCellBuilder: EventCellBuilder())
    addEventViewModel.coordinator = self
    addEventViewController.viewModel = addEventViewModel
    if let modalNavigationController = modalNavigationController {
      navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func didFinishSaveEvent() {
    parentCoordinator?.onUpdateEvent()
    navigationController.dismiss(animated: true, completion: nil)
  }
  
  func showImagePicker(completion: @escaping (UIImage) -> Void) {
    guard let modalNavigationController = modalNavigationController else { return }
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
    imagePickerCoordinator.onFinishPicking = { [weak self] image in
      guard let self = self else { return }
      self.completion(image)
      self.modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    imagePickerCoordinator.parentCoordinator = self
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}
