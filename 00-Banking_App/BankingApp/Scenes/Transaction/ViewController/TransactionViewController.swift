//
//  MyViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class TransactionViewController: FullscreenLockViewController, TransactionBaseCoordinated {
  
  // MARK: - UI -
  fileprivate lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.tableFooterView = UIView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  fileprivate lazy var moreBarButton: UIBarButtonItem = {
    let barButton = UIBarButtonItem(title: LocalizedString.BarButtonItem.more,
                                    style: .plain,
                                    target: self,
                                    action: #selector(goToMoreFlowAction))
    return barButton
  }()
  
  fileprivate lazy var moreThirdScreenBarButton: UIBarButtonItem = {
    let barButton = UIBarButtonItem(title: LocalizedString.BarButtonItem.more3Screen,
                                    style: .plain,
                                    target: self,
                                    action: #selector(goToMoreScreen3Action))
    return barButton
  }()
  
  fileprivate let transactionHeader = TransactionHeaderView(frame: .zero)
  fileprivate let refreshControl = UIRefreshControl()
  
  // MARK: - Properties -
  weak var coordinator: TransactionBaseCoordinator?
  var viewModel: TransactionsViewModel
  
  // MARK: - Initializers -
  init(coordinator: TransactionBaseCoordinator, viewModel: TransactionsViewModel) {
    self.coordinator = coordinator
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycle -
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setToLoadingState()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchTransactions()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setup()
  }
  
  // MARK: - Helper Methods -
  fileprivate func setup() {
    setupNavigationBar()
    setupTableView()
    setupTableHeaderView()
    setupRefreshControl()
  }
  
  fileprivate func setupNavigationBar() {
    navigationItem.title = LocalizedString.TransactionList.title
    navigationItem.leftBarButtonItem = moreBarButton
    navigationItem.rightBarButtonItem = moreThirdScreenBarButton
  }
  
  fileprivate func setupTableView() {
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  fileprivate func setupTableHeaderView() {
    var size = transactionHeader.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    size.width = UIScreen.main.bounds.width
    transactionHeader.frame.size = size    
    tableView.tableHeaderView = transactionHeader
  }
  
  fileprivate func setupRefreshControl() {
    refreshControl.tintColor = .systemBlue
    refreshControl.addTarget(self, action: #selector(refreshTransactions), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  fileprivate func fetchTransactions() {
    viewModel.transactions.onUpdate = { [weak self] _ in
      guard let self = self else { return }
      self.tableView.reloadData()
      self.transactionHeader.configure(with: self.viewModel)
      self.tableView.refreshControl?.endRefreshing()
    }
    
    viewModel.fetchTransactions()
  }
  
  fileprivate func loadingDataFailed(with error: String) {
    self.doneLoading()
    self.setToRetryState(with: error)
  }

  // MARK: - Actions -
  @objc func goToMoreFlowAction() {
    coordinator?.goToMoreFlow()
  }
  
  @objc func goToMoreScreen3Action() {
    coordinator?.goToDeepViewInMoreTab()
  }
  
  @objc func refreshTransactions() {
    setToLoadingState()
    fetchTransactions()
  }
}

// MARK: - UITableViewDataSource -
extension TransactionViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.transactions.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as! TransactionCell
    let transaction = viewModel.transactions.value[indexPath.row]
    cell.configureCell(with: transaction)
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

// MARK: - UITableViewDelegate -
extension TransactionViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let transaction = viewModel.transactions.value[indexPath.row]
    coordinator?.goToTransactionDetailScreen(with: transaction)
  }
}

// MARK: - TransactionsViewModelDelegate -
extension TransactionViewController: TransactionsViewModelDelegate {
  func didSucceed(_ viewModel: TransactionsViewModel) {
    doneLoading()
  }
  
  func didSucceedWithEmptyTransactions(_ viewModel: TransactionsViewModel) {
    setToEmptyState()
  }
  
  func didFail(_ viewModel: TransactionsViewModel, error: String) {
    loadingDataFailed(with: error)
  }
}

// MARK: - FailableView -
extension TransactionViewController: FailableView {
    func retry() {
      setToLoadingState()
      fetchTransactions()
    }
}
