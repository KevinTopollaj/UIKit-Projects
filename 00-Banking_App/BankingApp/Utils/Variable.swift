//
//  Variable.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

class Variable<Value> {
  
  // MARK: - Computed Properties -
  var value: Value {
    didSet {
      DispatchQueue.main.async {
        self.onUpdate?(self.value)
      }
    }
  }
  
  var onUpdate: ((Value) -> Void)? {
    didSet {
      DispatchQueue.main.async {
        self.onUpdate?(self.value)
      }
    }
  }
  
  // MARK: - Initializer -
  init(_ value: Value, _ onUpdate: ((Value) -> Void)? = nil) {
    self.value = value
    self.onUpdate = onUpdate
    
    DispatchQueue.main.async {
      self.onUpdate?(self.value)
    }
  }
  
}
