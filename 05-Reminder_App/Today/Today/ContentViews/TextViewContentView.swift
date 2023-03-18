//
//  TextViewContentView.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import UIKit

class TextViewContentView: UIView, UIContentView {
  
  // MARK: -5 Configuration Object -
  struct Configuration: UIContentConfiguration {
    
    // MARK: - Properties -
    var text: String? = ""
    var onChange: (String) -> Void = { _ in }
    
    func makeContentView() -> UIView & UIContentView {
      return TextViewContentView(self)
    }
  }
  
  // MARK: -1 Properties -
  let textView = UITextView()
  
  var configuration: UIContentConfiguration {
    didSet {
      configure(configuration: configuration)
    }
  }
  
  // MARK: -2 Override -
  override var intrinsicContentSize: CGSize {
    CGSize(width: 0, height: 44)
  }
  
  // MARK: -3 Initializer -
  init(_ configuration: UIContentConfiguration) {
    self.configuration = configuration
    
    super.init(frame: .zero)
    
    addPinnedSubview(textView, height: 200)
    textView.backgroundColor = nil
    textView.font = UIFont.preferredFont(forTextStyle: .body)
    textView.delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: -4 Helper Methods -
  
  func configure(configuration: UIContentConfiguration) {
    guard let configuration = configuration as? Configuration else { return }
    textView.text = configuration.text
  }
}


// MARK: -6 Extensions -
extension UICollectionViewListCell {
  
  func textViewConfiguration() -> TextViewContentView.Configuration {
    TextViewContentView.Configuration()
  }
}

extension TextViewContentView: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    guard let configuration = configuration as? TextViewContentView.Configuration else { return }
    configuration.onChange(textView.text)
  }
}
