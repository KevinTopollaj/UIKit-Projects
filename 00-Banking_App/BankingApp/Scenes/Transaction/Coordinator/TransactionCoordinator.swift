//
//  HomeCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

class TransactionCoordinator: TransactionBaseCoordinator {
  
  // MARK: - Properties -
  var parentCoordinator: MainBaseCoordinator?
  lazy var rootViewController: UIViewController = UIViewController()
  
  // MARK: - Methods -
  /// Create the ViewController and return it to the creator with the coordinator embedded.
  func start() -> UIViewController {
    
    let transactionsService: TransactionsServicing
    
    switch appConfiguration {
    case .live:
      transactionsService = TransactionsService()
    case .mock:
      transactionsService = MockTransactionsService()
    }
    
    let transactionsViewModel = TransactionsViewModel(service: transactionsService)
    let transactionViewController = TransactionViewController(coordinator: self, viewModel: transactionsViewModel)
    let navigationController = UINavigationController(rootViewController: transactionViewController)
    rootViewController = navigationController
    return rootViewController
  }
  
  func goToTransactionDetailScreen(with transaction: TransactionResponse.Transaction) {
    let transactionDetailViewModel = TransactionDetailViewModel(transaction: transaction)
    let transactionDetailViewController = TransactionDetailViewController(coordinator: self, viewModel: transactionDetailViewModel)
    navigationRootViewController?.pushViewController(transactionDetailViewController, animated: true)
  }
  
  func goToDeepViewInMoreTab() {
    parentCoordinator?.moveTo(flow: .More)
    
    parentCoordinator?.moreCoordinator
      .resetToRoot()
      .goToMoreScreen2(animated: false)
      .goToMoreScreen3(animated: false)
    
  }
  
  func goToMoreFlow() {
    parentCoordinator?.moveTo(flow: .More)
  }
  
}
