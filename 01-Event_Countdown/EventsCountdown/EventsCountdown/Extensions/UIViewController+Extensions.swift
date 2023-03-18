//
//  UIViewController+Extensions.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

extension UIViewController {
  static func instantiate<T>() -> T {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
    return controller
  }
}
