//
//  CAGradientLayer+ListStyle.swift
//  Today
//
//  Created by Kevin on 24.09.22.
//

import UIKit

extension CAGradientLayer {
  
  static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
    let layer = Self()
    layer.colors = color(for: style)
    layer.frame = frame
    return layer
  }
  
  private static func color(for style: ReminderListStyle) -> [CGColor] {
    let beginColor: UIColor
    let endColor: UIColor
    
    switch style {
      case .today:
        beginColor = .todayGradientTodayBegin
        endColor = .todayGradientTodayEnd
      case .future:
        beginColor = .todayGradientFutureBegin
        endColor = .todayGradientFutureEnd
      case .all:
        beginColor = .todayGradientAllBegin
        endColor = .todayGradientAllEnd
    }
    
    return [beginColor.cgColor, endColor.cgColor]
  }
}
