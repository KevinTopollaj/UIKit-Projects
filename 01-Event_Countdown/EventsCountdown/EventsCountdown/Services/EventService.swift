//
//  EventService.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 10.4.21.
//

import CoreData
import UIKit

protocol EventServiceProtocol {
  func perform(_ action: EventService.EventAction, data: EventService.EventInputData)
  func getEvent(_ id: NSManagedObjectID) -> Event?
  func getEvents() -> [Event]
}

final class EventService: EventServiceProtocol {
  
  struct EventInputData {
    let name: String
    let date: Date
    let image: UIImage
  }
  
  enum EventAction {
    case add
    case update(Event)
  }
  
  private let coreDataManager: CoreDataManager
  
  init(coreDataManager: CoreDataManager = .shared) {
    self.coreDataManager = coreDataManager
  }
  
  func perform(_ action: EventAction, data: EventInputData) {
    var event: Event
    
    switch action {
    case .add:
      event = Event(context: coreDataManager.moc)
    case .update(let eventToUpdate):
      event = eventToUpdate
    }
    
    event.setValue(data.name, forKey: "name")
    event.setValue(data.date, forKey: "date")
    
    let resizedImage = data.image.sameAspectRatio(newHeight: 250)
    let imageData = resizedImage.jpegData(compressionQuality: 0.5)
    
    event.setValue(imageData, forKey: "image")
    
    coreDataManager.save()
  }
  
  func getEvent(_ id: NSManagedObjectID) -> Event? {
    return coreDataManager.get(id)
  }
  
  func getEvents() -> [Event] {
    return coreDataManager.fetchAll()
  }
  
}
