//
//  TransactionCell.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
  
  // MARK: - Properties -
  static var identifier = String(describing: TransactionCell.self)
  
  // MARK: - Metrics -
  enum Metrics {
    static let imageSize = CGSize(width: 40, height: 40)
    static let minSpacing = CGFloat(5)
    static let maxSpacing = CGFloat(10)
  }
  
  // MARK: - UI -
  fileprivate lazy var iconImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect(origin: .zero, size: Metrics.imageSize))
    imageView.layer.masksToBounds = false
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var amountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .caption1, weight: .semibold)
    label.numberOfLines = 1
    label.textAlignment = .right
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var lineItemsLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .caption2)
    return label
  }()
  
  fileprivate lazy var titleAndSubtitleStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stack.alignment = .leading
    stack.distribution = .fill
    stack.axis = .vertical
    stack.spacing = Metrics.minSpacing
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  fileprivate lazy var iconCellStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [iconImageView, titleAndSubtitleStackView, amountLabel])
    stack.alignment = .top
    stack.axis = .horizontal
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.spacing = Metrics.maxSpacing
    return stack
  }()
  
  fileprivate lazy var mainStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [iconCellStackView, lineItemsLabel])
    stack.alignment = .leading
    stack.distribution = .fill
    stack.axis = .vertical
    stack.spacing = Metrics.minSpacing
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  // MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .systemBackground
    setSubviewsAndLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods -
  func configureCell(with transaction: TransactionResponse.Transaction) {
    
    let comingInArrowImage = UIImage.arrowDownBackwardCircle
    let goingOutArrowImage = UIImage.arrowUpForwardCircle
    let zeroImage = UIImage.zeroCircle
    
    titleLabel.text = transaction.title
    iconImageView.image = Int(truncating: transaction.amount.decimalValue) > 0 ? comingInArrowImage :
                          Int(truncating: transaction.amount.decimalValue) < 0 ? goingOutArrowImage : zeroImage
    
    amountLabel.textColor = Int(truncating: transaction.amount.decimalValue) > 0 ? .systemGreen :
                            Int(truncating: transaction.amount.decimalValue) < 0 ? .systemRed : .systemBlue
    
    amountLabel.text = String(describing: "\(LocalizedString.Currency.euro) \(transaction.amount.decimalValue)")
    subtitleLabel.text = transaction.subtitle
    lineItemsLabel.text = transaction.additionalTexts.lineItems.joined(separator: ", ")
  }
}

// MARK: - Subviews and Layout -
extension TransactionCell {
  
  private func setSubviewsAndLayout() {
    contentView.addSubview(mainStackView)
    
    NSLayoutConstraint.activate([
      iconImageView.heightAnchor.constraint(equalToConstant: Metrics.imageSize.height),
      iconImageView.widthAnchor.constraint(equalToConstant: Metrics.imageSize.width),
      amountLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -8),
      amountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22),
      mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
    ])

  }
}
