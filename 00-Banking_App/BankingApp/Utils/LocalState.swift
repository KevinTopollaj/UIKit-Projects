//
//  LocalState.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

class LocalState {
  
  // MARK: - Keys Enum -
  private enum Keys: String {
    case hasOnboarded
  }
  
  // MARK: - Computed Properties -
  public static var hasOnboarded: Bool {
    get {
      return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
    }
    set(newValue) {
      UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
    }
  }
}
