//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import Foundation

extension ReminderViewController {
  
  // MARK: - Sections in editing mode -
  
  enum Section: Int, Hashable {
    case view
    case title
    case date
    case notes
    
    
    // MARK: - Heading Text for eache Section -
    var name: String {
      switch self {
        case .view: return ""
        case .title:
          return NSLocalizedString("Title", comment: "Title section name")
        case .date:
          return NSLocalizedString("Date", comment: "Date section name")
        case .notes:
          return NSLocalizedString("Notes", comment: "Notes section name")
      }
    }
    
  }
  
}
