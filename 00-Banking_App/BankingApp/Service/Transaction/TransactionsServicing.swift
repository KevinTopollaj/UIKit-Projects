//
//  TransactionsServicing.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

// MARK: - TransactionsServicing -
protocol TransactionsServicing {
  func loadTransactions(completion: @escaping (Result<[TransactionResponse.Transaction], CustomError>) -> Void)
}
