//
//  MoreBaseCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

protocol MoreBaseCoordinator: Coordinator {
  @discardableResult func goToMoreScreen2(animated: Bool ) -> Self
  @discardableResult func goToMoreScreen3(animated: Bool) -> Self
}
