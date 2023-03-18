//
//  DetailViewModel.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

final class DetailViewModel {
  
  // MARK: - Properties -
  private let imageLoader: ImageLoader
  
  // MARK: - Initializer -
  init() {
    imageLoader = ImageLoader()
  }
  
  // MARK: - Helper Methods -
  func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> Void) -> UUID? {
    let uuid = imageLoader.loadImage(url: url, completion: completion)
    return uuid
  }
}
