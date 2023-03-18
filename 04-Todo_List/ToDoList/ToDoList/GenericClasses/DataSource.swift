//
//  DataSource.swift
//  ToDoList
//
//  Created by Kevin Topollaj on 19.4.21.
//

import CoreData
import UIKit

final class DataSource<Cell: UITableViewCell, Model: NSManagedObject>: NSObject, UITableViewDataSource {
  
  // MARK: - Properties -
  var cellID: String
  var dataProvider: DataProvider<Model>
  var tableView: UITableView?
  var configCell: (Cell, Model) -> Void
  
  // MARK: - Initializer -
  init(cellID: String, dataProvider: DataProvider<Model>, configCell: @escaping (Cell, Model) -> Void) {
    self.cellID = cellID
    self.dataProvider = dataProvider
    self.configCell = configCell
    
    super.init()
    
    self.dataProvider.delegate = self
  }
  
  // MARK: - UITableViewDataSource -
  func numberOfSections(in tableView: UITableView) -> Int {
    dataProvider.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataProvider.rowsInSection(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? Cell else {
      return UITableViewCell()
    }
    let model = dataProvider.objectAtIndex(indexPath: indexPath)
    configCell(cell, model)
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      dataProvider.deleteItem(at: indexPath)
    }
  }
  
}

// MARK: - DataProviderDelegate -
extension DataSource: DataProviderDelegate {
  func didInsertItem(at indexPath: IndexPath) {
    tableView?.insertRows(at: [indexPath], with: .automatic)
  }
  
  func didDeleteItem(at indexPath: IndexPath) {
    tableView?.deleteRows(at: [indexPath], with: .automatic)
  }
}



