//
//  UIImage+Extensions.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import UIKit

extension UIImage {
  func sameAspectRatio(newHeight: CGFloat) -> UIImage {
    let scale = newHeight / size.height
    let newWidth = size.width * scale
    let newSize = CGSize(width: newWidth, height: newHeight)
    return UIGraphicsImageRenderer(size: newSize).image { _ in
      self.draw(in: .init(origin: .zero, size: newSize))
    }
  }
}
