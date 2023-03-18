//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

struct TransactionResponse: Decodable {
  let collection: [Transaction]
  
  struct Transaction: Decodable {
    
    let id: String
    let title: String
    let subtitle: String?
    let amount: Amount
    let additionalTexts: AdditionalTexts
    
    struct Amount: Decodable {
      let value: Int
      let precision: Int
      let currency: String
    }
    
    struct AdditionalTexts: Decodable {
      let lineItems: [String]
    }
    
  }
  
}
