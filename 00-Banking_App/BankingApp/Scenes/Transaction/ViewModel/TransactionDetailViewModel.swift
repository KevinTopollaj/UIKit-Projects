//
//  TransactionDetailViewModel.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

class TransactionDetailViewModel {
  
  // MARK: - Properties -
  let transaction: TransactionResponse.Transaction
  
  // MARK: - Initializer -
  init(transaction: TransactionResponse.Transaction) {
    self.transaction = transaction
  }
}
