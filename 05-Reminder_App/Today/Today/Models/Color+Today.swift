//
//  Color+Today.swift
//  Today
//
//  Created by Kevin on 13.09.22.
//

import UIKit

extension UIColor {
  
  static var todayDetailCellTint: UIColor {
      UIColor(named: "TodayDetailCellTint") ?? .tintColor
  }
  
  static var todayListCellBackground: UIColor {
      UIColor(named: "TodayListCellBackground") ?? .secondarySystemBackground
  }
  
  static var todayListCellDoneButtonTint: UIColor {
      UIColor(named: "TodayListCellDoneButtonTint") ?? .tintColor
  }
  
  static var todayGradientAllBegin: UIColor {
      UIColor(named: "TodayGradientAllBegin") ?? .systemFill
  }
  
  static var todayGradientAllEnd: UIColor {
      UIColor(named: "TodayGradientAllEnd") ?? .quaternarySystemFill
  }
  
  static var todayGradientFutureBegin: UIColor {
          UIColor(named: "TodayGradientFutureBegin") ?? .systemFill
  }
  
  static var todayGradientFutureEnd: UIColor {
          UIColor(named: "TodayGradientFutureEnd") ?? .quaternarySystemFill
  }
  
  static var todayGradientTodayBegin: UIColor {
          UIColor(named: "TodayGradientTodayBegin") ?? .systemFill
  }
  
  static var todayGradientTodayEnd: UIColor {
          UIColor(named: "TodayGradientTodayEnd") ?? .quaternarySystemFill
  }
  
  static var todayNavigationBackground: UIColor {
      UIColor(named: "TodayNavigationBackground") ?? .secondarySystemBackground
  }
  
  static var todayPrimaryTint: UIColor {
      UIColor(named: "TodayPrimaryTint") ?? .tintColor
  }
  
  static var todayProgressLowerBackground: UIColor {
      UIColor(named: "TodayProgressLowerBackground") ?? .systemGray
  }
  
  static var todayProgressUpperBackground: UIColor {
      UIColor(named: "TodayProgressUpperBackground") ?? .systemGray6
  }
  
}
