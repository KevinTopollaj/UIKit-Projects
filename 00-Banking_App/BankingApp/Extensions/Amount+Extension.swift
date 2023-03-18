//
//  Amount+Extension.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

extension TransactionResponse.Transaction.Amount {
  
  // MARK: - Computed Properties -
  var decimalValue: NSDecimalNumber {
    get {
      let mantissa =  llabs(Int64(value))
      let exponent = Int16(precision * -1)
      
      return NSDecimalNumber(
        mantissa: UInt64(mantissa),
        exponent: exponent,
        isNegative: self.value < 0
      )
    }
  }
  
  // MARK: - Initializer -
  public init(decimalValue: NSDecimalNumber, currency: String) {
    self.currency = currency
    self.precision = 2
    
    self.value = decimalValue.integerValueWithPrecision2
  }
  
}
