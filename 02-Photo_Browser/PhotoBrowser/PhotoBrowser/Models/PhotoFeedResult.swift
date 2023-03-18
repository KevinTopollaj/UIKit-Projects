//
//  PhotoFeedResult.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import Foundation

struct PhotoFeedResult: Codable {
  let total_results: Int
  let page: Int
  let per_page: Int
  let photos: [Photo]
}
