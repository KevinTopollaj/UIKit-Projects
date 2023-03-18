//
//  APIError.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

enum APIError: Error {
  case requestFailed
  case invalidData
  case responseUnsuccessful
  case jsonParsingFailed
  case jsonConversionFailed
  
  var localizedDescription: String {
    switch self {
    case .requestFailed:
      return "Request Failed"
    case .invalidData:
      return "Invalid Data"
    case .responseUnsuccessful:
      return "Response Unsuccessful"
    case .jsonParsingFailed:
      return "Json Parsing Failed"
    case .jsonConversionFailed:
      return "Json Conversion Failed"
    }
  }
}
