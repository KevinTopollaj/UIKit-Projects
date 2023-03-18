//
//  TransactionHeaderView.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class TransactionHeaderView: UIView {
  
  // MARK: - @IBOutlet -
  @IBOutlet var contentView: UIView!
  @IBOutlet var transactionTotalLabel: UILabel!
  
  // MARK: - Initializers -
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  // MARK: - Overrides -
  override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: 105)
  }
  
  // MARK: - Helper Methods -
  
  func configure(with viewModel: TransactionsViewModel) {
    let total = viewModel.totalBalance()
    transactionTotalLabel.text = "\(LocalizedString.Currency.euro) \(total)"
  }
  
  // load the nib and add contentView constraints
  private func commonInit() {
    let bundle = Bundle(for: TransactionHeaderView.self)
    bundle.loadNibNamed(LocalizedString.Nib.headerNib, owner: self, options: nil)
    addSubview(contentView)
    
    contentView.backgroundColor = .systemBackground
    contentView.translatesAutoresizingMaskIntoConstraints = false
    transactionTotalLabel.font = UIFont.preferredFont(for: .title2,
                                                      weight: .bold)
        
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
}
