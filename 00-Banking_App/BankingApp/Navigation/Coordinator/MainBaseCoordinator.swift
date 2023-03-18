//
//  MainBaseCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation
import UIKit

protocol MainBaseCoordinator: Coordinator {
  var homeCoordinator: TransactionBaseCoordinator { get }
  var moreCoordinator: MoreBaseCoordinator { get }
  func moveTo(flow: AppFlow)
}

protocol TransactionBaseCoordinated {
  var coordinator: TransactionBaseCoordinator? { get }
}

protocol MoreBaseCoordinated {
  var coordinator: MoreBaseCoordinator? { get }
}

