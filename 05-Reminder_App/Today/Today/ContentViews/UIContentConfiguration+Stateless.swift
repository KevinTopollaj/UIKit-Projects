//
//  UIContentConfiguration+Stateless.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import UIKit

extension UIContentConfiguration {
  
  // allows the UIContentConfiguration to provide a specialized configuration for all the states (normal, highlighted, selected)
  func updated(for state: UIConfigurationState) -> Self {
    return self
  }
}
