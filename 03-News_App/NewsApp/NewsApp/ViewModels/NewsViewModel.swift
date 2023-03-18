//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

struct NewsViewModel {
  
  let news: News
  
  var author: String {
    return news.author ?? "Unknown Author"
  }
  
  var title: String {
    return news.title ?? "Unknown Title"
  }
  
  var description: String {
    return news.description ?? "Unknown Description"
  }
  
  var url: String {
    return news.url ?? ""
  }
  
  var urlToImage: String {
    return news.urlToImage ?? "https://www.kindpng.com/picc/m/182-1827064_breaking-news-banner-png-transparent-background-breaking-news.png"
  }
}
