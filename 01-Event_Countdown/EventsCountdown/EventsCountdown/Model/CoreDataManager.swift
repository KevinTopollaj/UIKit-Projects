//
//  CoreDataManager.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import CoreData
import UIKit

final class CoreDataManager {
  
  static let shared = CoreDataManager()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: "EventsCountdown")
    persistentContainer.loadPersistentStores { (_, error) in
      print(error?.localizedDescription ?? "")
    }
    return persistentContainer
  }()
  
  var moc: NSManagedObjectContext {
    persistentContainer.viewContext
  }
    
  func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
    do {
      return try moc.existingObject(with: id) as? T
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  func fetchAll<T: NSManagedObject>() -> [T] {
    do {
      let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
      return try moc.fetch(fetchRequest)
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func save() {
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}
