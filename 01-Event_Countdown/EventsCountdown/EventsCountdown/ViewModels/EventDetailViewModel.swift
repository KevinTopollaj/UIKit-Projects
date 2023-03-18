//
//  EventDetailViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import UIKit
import CoreData

final class EventDetailViewModel {
  
  private let eventID: NSManagedObjectID
  private let eventService: EventServiceProtocol
  private var event: Event?
  private let date = Date()
  
  var onUpdate = {}
  var coordinator: EventDetailCoordinator?
  
  var image: UIImage? {
    guard let imageData = event?.image else { return nil }
    return UIImage(data: imageData)
  }
  
  var timeRemainingViewModel: TimeRemainingViewModel? {
    guard let eventDate = event?.date,
          let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {
      return nil
    }
    return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
  }
  
  init(eventID: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
    self.eventID = eventID
    self.eventService = eventService
  }
  
  func viewDidLoad() {
    reload()
  }
  
  func viewDidDisappear() {
    coordinator?.didFinish()
  }
  
  func reload() {
    event = eventService.getEvent(eventID)
    onUpdate()
  }
  
  @objc func editButtonTapped() {
    guard let event = event else { return }
    coordinator?.onEditEvent(event)
  }
}
