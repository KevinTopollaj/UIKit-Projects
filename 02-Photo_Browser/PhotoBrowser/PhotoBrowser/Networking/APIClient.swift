//
//  APIClient.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import Foundation

protocol APIClient {
  var session: URLSession { get }
  func fetch<T: Decodable>(with request: URLRequest,
                         decode: @escaping (Decodable) -> T?,
                         completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
  typealias JSONTaskCompletionHandler = (Result<Decodable, APIError>) -> Void
  
  private func decodingTask<T: Decodable>(with request: URLRequest,
                                          decodingType: T.Type,
                                          completion: @escaping JSONTaskCompletionHandler) -> URLSessionTask {
    
    let task = session.dataTask(with: request) { data, response, error in
        
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.requestFailed))
        return
      }
      
      guard httpResponse.statusCode == 200 else {
        completion(.failure(.responseUnsuccessful))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let genericModel = try JSONDecoder().decode(decodingType, from: data)
        completion(.success(genericModel))
      } catch {
        completion(.failure(.jsonConversionFailed))
      }
      
    }
    
    return task
  }
  
  func fetch<T: Decodable>(with request: URLRequest,
                         decode: @escaping (Decodable) -> T?,
                         completion: @escaping (Result<T, APIError>) -> Void) {
    
    let task = decodingTask(with: request, decodingType: T.self) { result in
      switch result {
      case .success(let decodableObject):
        guard let object = decode(decodableObject) else {
          completion(.failure(.jsonParsingFailed))
          return
        }
        completion(.success(object))
      case .failure(let error):
        completion(.failure(error))
      }
    }
    task.resume()
    
  }

}
