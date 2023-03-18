//
//  ShadowImageView.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 14.4.21.
//

import UIKit

final class ShadowImageView: UIView {
  
  // MARK: - Properties -
  var image: UIImage? {
    didSet {
      newsImageView.image = image
    }
  }
  
  // MARK: - UI -
  private lazy var newsImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var baseView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 5, height: 5)
    view.layer.shadowOpacity = 0.7
    view.layer.shadowRadius = 10.0
    return view
  }()
  
  // MARK: - Initializers -
  init() {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set up Views and Constraints -
  func setupView() {
    addSubview(baseView)
    baseView.addSubview(newsImageView)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    [baseView, newsImageView].forEach {
      NSLayoutConstraint.activate([
        $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
      ])
    }
  }
  
  // MARK: - Override -
  override func layoutSubviews() {
    super.layoutSubviews()
    
    baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
    baseView.layer.shouldRasterize = true
    baseView.layer.rasterizationScale = UIScreen.main.scale
  }
}
