//
//  NewsEnvelope.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

struct NewsEnvelope: Decodable {
  let status: String
  let totalResults: Int
  let articles: [News]
}
