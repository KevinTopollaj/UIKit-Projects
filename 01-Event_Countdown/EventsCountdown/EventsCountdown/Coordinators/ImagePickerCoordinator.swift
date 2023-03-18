//
//  ImagePickerCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
  
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  
  var parentCoordinator: Coordinator?
  var onFinishPicking: (UIImage) -> Void = { _ in }
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    navigationController.present(imagePickerController, animated: true)
  }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      onFinishPicking(image)
    }
    parentCoordinator?.childDidFinish(self)
  }
}
