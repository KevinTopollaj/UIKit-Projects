//
//  UIView+PinnedSubView.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import UIKit

extension UIView {
  
  func addPinnedSubview(_ subview: UIView,
                        height: CGFloat? = nil,
                        insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                            left: 8,
                                                            bottom: 0,
                                                            right: 8)) {
    
    addSubview(subview)
    
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
    subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
    subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
    subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true
    
    if let height = height {
      subview.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
  }
}
