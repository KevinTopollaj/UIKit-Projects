//
//  HeaderView.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 14.4.21.
//

import UIKit

final class HeaderView: UIView {
  
  // MARK: - Properties -
  private var fontSize: CGFloat
  
  // MARK: - UI -
  private lazy var headingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "News"
    label.font = UIFont.systemFont(ofSize: fontSize)
    return label
  }()
  
  private lazy var circleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
    imageView.image = UIImage(systemName: "largecircle.fill.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
    return imageView
  }()
  
  private lazy var plusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
    imageView.image = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
    return imageView
  }()
  
  private lazy var subheadlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(fontSize)
    label.text = "Top Headlines"
    label.textColor = .gray
    return label
  }()
  
  private lazy var headerStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [circleImageView, headingLabel, plusImageView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()
  
  // MARK: - Initializers -
  init(fontSize: CGFloat) {
    self.fontSize = fontSize
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set up Views and Constraints -
  func setupView() {
    addSubview(headerStackView)
    addSubview(subheadlineLabel)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerStackView.topAnchor.constraint(equalTo: topAnchor),
      
      subheadlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subheadlineLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
      subheadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

