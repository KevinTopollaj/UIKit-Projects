//
//  PhotoFeed.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import Foundation

enum PhotoFeed {
  case searchByCategory(category: String, perPage: Int)
  case curated(currentPage: Int, perPage: Int)
}

extension PhotoFeed: Endpoint {
  var base: String {
    return "https://api.pexels.com"
  }
  
  var path: String {
    switch self {
    case .searchByCategory:
      return "/v1/search"
    case .curated:
      return "/v1/curated"
    }
  }
  
  var query: String {
    switch self {
    case .searchByCategory(category: let category, perPage: let perPage):
      return "query=\(category)&per_page=\(perPage)"
    case .curated(currentPage: let currentPage, perPage: let perPage):
      return "page=\(currentPage)&per_page=\(perPage)"
    }
  }
}
