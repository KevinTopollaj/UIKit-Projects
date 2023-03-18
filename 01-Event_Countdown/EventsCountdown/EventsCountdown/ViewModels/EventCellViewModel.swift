//
//  EventCellViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 7.4.21.
//

import UIKit
import CoreData

struct EventCellViewModel {

  let date = Date()
  static let imageCache = NSCache<NSString, UIImage>()
  private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
  
  var onSelect: (NSManagedObjectID) -> Void = { _ in }
  
  private var cacheKey: String {
    event.objectID.description
  }
  
  var timeRemainingStrings: [String] {
    guard let eventDate = event.date else { return [] }
    return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
  }
  
  var dateText: String? {
    guard let eventDate = event.date else { return nil }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter.string(from: eventDate)
  }
  
  var eventName: String? {
    event.name
  }
  
  var timeRemainingViewModel: TimeRemainingViewModel? {
    guard let eventDate = event.date,
          let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {
      return nil
    }
    return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
  }
  
  func loadImage(completion: @escaping (UIImage?) -> Void) {
    if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
      completion(image)
    } else {
      imageQueue.async {
        guard let imageData = event.image,
              let image = UIImage(data: imageData) else {
          completion(nil)
          return
        }
        Self.imageCache.setObject(image, forKey: cacheKey as NSString)
        DispatchQueue.main.async {
          completion(image)
        }
      }
    }
  }
  
  func didSelect() {
    onSelect(event.objectID)
  }
  
  private let event: Event
  
  init(_ event: Event) {
    self.event = event
  }
}

