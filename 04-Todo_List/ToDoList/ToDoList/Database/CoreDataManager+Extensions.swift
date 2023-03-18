//
//  CoreDataManager+Extensions.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 19.4.21.
//

import Foundation
import CoreData

// MARK: -Extension-
extension CoreDataManager {
  func saveFolder(name: String) {
    let todoFolder = TodoFolder(context: managedObjectContext)
    todoFolder.title = name
    saveContext()
  }
  
  func saveTodo(folder: String, item: String) {
    let todoItem = TodoItem(context: managedObjectContext)
    todoItem.folder = folder
    todoItem.title = item
    saveContext()
  }
}
