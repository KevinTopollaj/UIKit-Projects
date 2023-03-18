//
//  NSDecimalNumber+Extension.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
  
  // MARK: - Computed Properties -
  var integerValueWithPrecision2: Int {
    let decimalNumberBehavior = NSDecimalNumberHandler(
      roundingMode: NSDecimalNumber.RoundingMode.plain,
      scale: 0,
      raiseOnExactness: false,
      raiseOnOverflow: false,
      raiseOnUnderflow: false,
      raiseOnDivideByZero: false
    )
    
    let beforeComma = self.rounding(accordingToBehavior: decimalNumberBehavior)
    let afterComma = self.subtracting(beforeComma)
    
    let beforeCommaMultipliedBy100 = beforeComma.multiplying(
      byPowerOf10: 2,
      withBehavior: decimalNumberBehavior
    )
    
    if afterComma != NSDecimalNumber.zero {
      let afterCommaCommaMultipliedBy100 = afterComma.multiplying(
        byPowerOf10: 2,
        withBehavior: decimalNumberBehavior
      )
      return beforeCommaMultipliedBy100.adding(afterCommaCommaMultipliedBy100).intValue
    } else {
      return beforeCommaMultipliedBy100.intValue
    }
  }
  
}
