//
//  PexelsClient.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import Foundation

final class PexelsClient: APIClient {
  var session: URLSession
  
  init(config: URLSessionConfiguration) {
    self.session = URLSession(configuration: config)
  }
  
  convenience init() {
    self.init(config: .default)
  }
  
  func getPhotos(from photoFeedType: PhotoFeed, completion: @escaping (Result<PhotoFeedResult, APIError>) -> Void) {
    
    fetch(with: photoFeedType.request,
          decode: { json -> PhotoFeedResult? in
                    guard let photoFeedResult = json as? PhotoFeedResult else { return nil }
                    return photoFeedResult
          },
          completion: completion)
  }
}
