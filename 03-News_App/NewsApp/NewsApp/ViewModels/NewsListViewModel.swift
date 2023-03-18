//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

class NewsListViewModel {
  // MARK: - Properties -
  var newsViewModels = [NewsViewModel]()
  
  var count: Int {
    newsViewModels.count
  }
  
  // MARK: - Helper Methods -
  func getNews(completion: @escaping (Result<[NewsViewModel],APIError>) -> Void) {
    NetworkManager.shared.getNews { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let news):
        let newsViewModels = news.map(NewsViewModel.init)
        DispatchQueue.main.async {
          self.newsViewModels = newsViewModels
          completion(.success(newsViewModels))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getNewsViewModel(for indexPath: IndexPath) -> NewsViewModel {
    newsViewModels[indexPath.row]
  }
}
