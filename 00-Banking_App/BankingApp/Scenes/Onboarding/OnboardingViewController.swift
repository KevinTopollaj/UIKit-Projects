//
//  OnboardingViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  // MARK: - UI Elements -
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  // MARK: - Properties -
  let imageName: String
  let titleText: String
  
  // MARK: - Initializers -
  init(imageName: String, titleText: String) {
    self.imageName = imageName
    self.titleText = titleText
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Livecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    style()
    layout()
  }
}

// MARK: - Style and Layout -
extension OnboardingViewController {
  
  func style() {
    view.backgroundColor = .systemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: imageName,
                              withConfiguration: UIImage.SymbolConfiguration(weight: .light))
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.preferredFont(for: .title3, weight: .semibold)
    label.adjustsFontForContentSizeCategory = true
    label.textColor = .systemBlue
    label.numberOfLines = 0
    label.text = titleText
  }
  
  func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
      
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
    ])
  }
  
}
