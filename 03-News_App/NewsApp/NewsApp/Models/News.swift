//
//  News.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

struct News: Decodable {
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
}
