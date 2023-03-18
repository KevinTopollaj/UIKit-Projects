//
//  TransactionDetailViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController, TransactionBaseCoordinated {
  
  // MARK: - UI -
  fileprivate lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView(frame: .zero)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentInsetAdjustmentBehavior = .automatic
    scrollView.isScrollEnabled = true
    return scrollView
  }()
  
  fileprivate lazy var containerView: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    return container
  }()
  
  fileprivate lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage.arrowLeftArrowRightCircle
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  fileprivate lazy var transactionStaticTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .headline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = LocalizedString.TransactionDetail.transactionTitle
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.text = viewModel.transaction.title
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionTitleStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [transactionStaticTitleLabel, transactionTitleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .leading
    return stackView
  }()
  
  fileprivate lazy var transactionStaticSubitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .headline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = LocalizedString.TransactionDetail.transactionSubtitle
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionSubitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.text = viewModel.transaction.subtitle
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionSubtitleStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [transactionStaticSubitleLabel, transactionSubitleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .leading
    return stackView
  }()
  
  fileprivate lazy var transactionStaticAmountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .headline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = LocalizedString.TransactionDetail.transactionAmount
    label.textColor = .systemBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionAmountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.text = String(describing: "\(LocalizedString.Currency.euro) \(viewModel.transaction.amount.decimalValue)")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate lazy var transactionAmountStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [transactionStaticAmountLabel, transactionAmountLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .leading
    return stackView
  }()
  
  fileprivate lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [transactionTitleStackView, transactionSubtitleStackView, transactionAmountStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.alignment = .leading
    return stackView
  }()
  
  // MARK: - Properties -
  weak var coordinator: TransactionBaseCoordinator?
  var viewModel: TransactionDetailViewModel
  
  // MARK: - Initializers -
  init(coordinator: TransactionBaseCoordinator, viewModel: TransactionDetailViewModel) {
    self.coordinator = coordinator
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    navigationItem.title = LocalizedString.TransactionDetail.title
    setSubviewsAndLayout()
  }

}

// MARK: - Subviews and Layout -
extension TransactionDetailViewController {
  
  func setSubviewsAndLayout() {
    view.addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    scrollView.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
    ])
    
    containerView.addSubview(mainStackView)
    containerView.addSubview(iconImageView)
    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20),
      iconImageView.heightAnchor.constraint(equalToConstant: 150),
      iconImageView.widthAnchor.constraint(equalToConstant: 150),
      iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      
      mainStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
      mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
  }
}
