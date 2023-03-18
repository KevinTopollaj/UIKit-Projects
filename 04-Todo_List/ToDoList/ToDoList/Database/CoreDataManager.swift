//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 19.4.21.
//

import Foundation
import CoreData

final class CoreDataManager {
  
  // MARK: - Properties -
  static let shared = CoreDataManager()
  
  var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  private lazy var presistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ToDoList")
    container.loadPersistentStores { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  // MARK: - Initializer -
  private init() {
    self.managedObjectContext = self.presistentContainer.viewContext
  }
  
  // MARK: - Helper Methods -
  internal func saveContext() {
    if managedObjectContext.hasChanges {
      do {
        try managedObjectContext.save()
      } catch let error {
        fatalError("Unable to save: \(error), \(error.localizedDescription)")
      }
    }
  }
  
}
