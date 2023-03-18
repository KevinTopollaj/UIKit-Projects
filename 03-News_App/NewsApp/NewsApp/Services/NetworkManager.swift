//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import Foundation

class NetworkManager {
  
  // MARK: - Properties -
  let imagesCache = NSCache<NSString, NSData>()
  static let shared = NetworkManager()
  
  private let baseURL = "https://newsapi.org/v2/"
  private let USTopHeadLine = "top-headlines?country=us"
  
  // MARK: - Initializer -
  private init() {}
  
  // MARK: - Helper Methods -
  func getNews(completion: @escaping (Result<[News],APIError>) -> Void) {
    let urlString = "\(baseURL)\(USTopHeadLine)&apiKey=\(APIKey.key)"
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      guard error == nil else {
        completion(.failure(.requestFailed))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
        completion(.failure(.responseUnsuccessful))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let news = try JSONDecoder().decode(NewsEnvelope.self, from: data)
        completion(.success(news.articles))
      } catch {
        completion(.failure(.jsonParsingFailed))
      }
      
    }
    task.resume()
  }
  
  func getImage(urlString: String, completion: @escaping (Result<Data,APIError>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
    if let imageData = imagesCache.object(forKey: url.absoluteString as NSString) {
      completion(.success(imageData as Data))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      guard error == nil else {
        completion(.failure(.requestFailed))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
        completion(.failure(.responseUnsuccessful))
        return
      }
      
      if let data = data {
        self.imagesCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
        completion(.success(data))
        return
      }
      
    }
    task.resume()
  }
}
