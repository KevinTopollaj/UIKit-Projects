//
//  TransactionsViewModel.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

// MARK: - TransactionsViewModelDelegate -
protocol TransactionsViewModelDelegate: AnyObject {
  func didSucceed(_ viewModel: TransactionsViewModel)
  func didSucceedWithEmptyTransactions(_ viewModel: TransactionsViewModel)
  func didFail(_ viewModel: TransactionsViewModel, error: String)
}

class TransactionsViewModel {
  
  // MARK: - Properties -
  var transactions: Variable<[TransactionResponse.Transaction]> = Variable([])
  let service: TransactionsServicing
  weak var delegate: TransactionsViewModelDelegate?
  
  // MARK: - Initializer -
  init(service: TransactionsServicing) {
    self.service = service
  }
  
  // MARK: - Methods -
  func fetchTransactions() {
    service.loadTransactions { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let transactions):
        if !transactions.isEmpty {
          self.transactions.value = transactions
          self.delegate?.didSucceed(self)
        } else {
          self.delegate?.didSucceedWithEmptyTransactions(self)
        }
        
      case .failure(let error):
        self.delegate?.didFail(self, error: error.rawValue)
      }
    }
  }
  
  func totalBalance() -> NSDecimalNumber {
    let amount = transactions.value.map { $0.amount.decimalValue }
    let total = amount.reduce(NSDecimalNumber.zero) { result, elemet in
      result.adding(elemet)
    }
    return total
  }
}
