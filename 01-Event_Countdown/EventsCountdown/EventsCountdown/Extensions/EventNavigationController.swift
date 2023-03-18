//
//  EventNavigationController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 10.4.21.
//

import UIKit

final class EventNavigationController: UINavigationController {
  override var childForStatusBarStyle: UIViewController? {
    topViewController
  }
}
