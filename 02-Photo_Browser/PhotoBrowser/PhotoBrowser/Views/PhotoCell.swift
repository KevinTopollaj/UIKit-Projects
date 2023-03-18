//
//  PhotoCell.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class PhotoCell: UITableViewCell {
  
  // MARK: - Properties -
  static let reuseIdentifier = String(describing: PhotoCell.self)
  var onReuse: () -> Void = {}
  
  // MARK: - UI -
  
  lazy var photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var photographerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.textColor = .white
    return label
  }()
  
  lazy var photographerTagLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(14)
    label.textColor = .white
    return label
  }()
  
  private lazy var blurEffectView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    return blurView
  }()
  
  // MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    contentView.addSubview(photoImageView)
    contentView.addSubview(blurEffectView)
    
    blurEffectView.contentView.addSubview(photographerLabel)
    blurEffectView.contentView.addSubview(photographerTagLabel)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      blurEffectView.heightAnchor.constraint(equalToConstant: 50),
      
      photographerLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 2),
      photographerLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -2),
      photographerLabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 2),
      
      photographerTagLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 2),
      photographerTagLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -2),
      photographerTagLabel.topAnchor.constraint(equalTo: photographerLabel.bottomAnchor, constant: 2),
      photographerTagLabel.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -2)
    ])
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    onReuse()
    photoImageView.image = nil
  }
}
