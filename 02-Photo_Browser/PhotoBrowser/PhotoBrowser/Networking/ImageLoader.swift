//
//  ImageLoader.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class ImageLoader {
  
  // cache
  private var imagesCache = NSCache<NSString, NSData>()
  
  // requests being performed for image download
  private var runningRequests = [UUID: URLSessionDataTask]()
  
  func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> Void) -> UUID? {
    
    if let imageData = imagesCache.object(forKey: url.absoluteString as NSString) {
      completion(.success(imageData as Data))
      return nil
    }
    
    let uuid = UUID()
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      defer { self.runningRequests.removeValue(forKey: uuid) }
      
      if let data = data {
        self.imagesCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
        completion(.success(data))
        return
      }
      
      guard let error = error else { return }
      
      guard (error as NSError).code == NSURLErrorCancelled else {
        completion(.failure(error))
        return
      }
    }
    
    task.resume()
    
    runningRequests[uuid] = task
    return uuid
  }
  
  func cancel(uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
  
}
