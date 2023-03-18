//
//  MockTransactionsService.swift
//
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

// MARK: - MockTransactionsService -
class MockTransactionsService: TransactionsServicing {
  
  // MARK: - Properties -
  var getTransactionCounter = 0
  
  // MARK: - Methods -
  func loadTransactions(completion: @escaping (Result<[TransactionResponse.Transaction], CustomError>) -> Void) {
    
    getTransactionCounter += 1
    
    let response = TransactionResponse(collection: [
      TransactionResponse.Transaction(id: "001",
                                      title: "TransactionTitle1",
                                      subtitle: "TransactionSubtitle1",
                                      amount: TransactionResponse.Transaction.Amount(value: 100,
                                                                                     precision: 00,
                                                                                     currency: "USD"),
                                      additionalTexts: TransactionResponse.Transaction.AdditionalTexts(lineItems: ["lineItem1", "lineItem2", "lineItem3"]))
    ])
    
    completion(.success(response.collection))
  }
}
