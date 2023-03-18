//
//  TextFieldContentView.swift
//  Today
//
//  Created by Kevin on 17.09.22.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
  
  // MARK: - Configuration Object -
  struct Configuration: UIContentConfiguration {
    
    // MARK: - Properties -
    var text: String? = ""
    var onChange: (String) -> Void = { _ in }
    
    // Will create the ContentView based on the configuration
    func makeContentView() -> UIView & UIContentView {
      return TextFieldContentView(self)
    }
  }
  
  // MARK: - Properties -
  let textField = UITextField()
  
  // when the configuration changes you will update the UI to reflect the current state
  var configuration: UIContentConfiguration {
    didSet {
      configure(configuration: configuration)
    }
  }
  
  // MARK: - Override -
  override var intrinsicContentSize: CGSize {
    CGSize(width: 0, height: 44)
  }
  
  // MARK: - Initializer -
  init(_ configuration: UIContentConfiguration) {
    self.configuration = configuration
    super.init(frame: .zero)
    addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    
    textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
    textField.clearButtonMode = .whileEditing
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Function -
  
  // Will configure the element based on the configuration
  func configure(configuration: UIContentConfiguration) {
    guard let configuration = configuration as? Configuration else { return }
    textField.text = configuration.text
  }
  
  // MARK: - Action -
  @objc private func didChange(_ sender: UITextField) {
    guard let configuration = configuration as? TextFieldContentView.Configuration else { return }
    configuration.onChange(textField.text ?? "")
  }
  
}


// MARK: - UICollectionViewListCell Extension -

extension UICollectionViewListCell {
  
  // Create a new custom Configuration for the TextField
  func textFieldConfiguration() -> TextFieldContentView.Configuration {
    TextFieldContentView.Configuration()
  }
}
