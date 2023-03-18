//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation


// MARK: - TransactionsService -
class TransactionsService: TransactionsServicing {
  
  /// Loads a list of transaction - you can assume that all transactions have the same currency
  func loadTransactions(completion: @escaping (Result<[TransactionResponse.Transaction], CustomError>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + (Double(arc4random_uniform(5000)) / 1000.0)) {
      switch arc4random_uniform(100) {
      case 0..<25:
        completion(.failure(.randomError))
      default:
        completion(.success(self.readTransactions()))
      }
    }
  }
  
  private func readTransactions() -> [TransactionResponse.Transaction] {
    let file = Bundle(for: TransactionsService.self).path(forResource: "transactions", ofType: "json")!
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: file), options: [])
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .millisecondsSince1970
      let transactionResponse = try decoder.decode(TransactionResponse.self, from: data)
      return transactionResponse.collection
    } catch let error {
      assertionFailure("Got error \(error) while parsing transactions.")
      return [TransactionResponse.Transaction]()
    }
  }
  
}

