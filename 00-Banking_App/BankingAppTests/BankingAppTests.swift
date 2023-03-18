//
//  BankingAppTests.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import XCTest
@testable import BankingApp

class BankingAppTests: XCTestCase {
  
  var transactionCoordinator: TransactionCoordinator!
  var transactionNavigationController: UINavigationController!
  var transactionViewController: TransactionViewController!
  var testAmount: TransactionResponse.Transaction.Amount!
  
  var mockService: MockTransactionsService!
  var transactionViewModel: TransactionsViewModel!
  
  override func setUp() {
    super.setUp()
    transactionCoordinator = TransactionCoordinator()
    transactionNavigationController = transactionCoordinator.start() as? UINavigationController
    transactionViewController = transactionNavigationController.viewControllers.first as? TransactionViewController
    
    testAmount = TransactionResponse.Transaction.Amount(decimalValue: 27.8987, currency: "Euro")
    
    mockService = MockTransactionsService()
    transactionViewModel = TransactionsViewModel(service: mockService)
  }
  
  // test that transactionViewController is not nil
  func testTransactionViewControllerIsNotNil() {
    XCTAssertNotNil(transactionViewController)
  }
  
  // test that transactionViewModel is not nil so it is injected int the transactionViewController
  func testDependencyInjection() {
    XCTAssertNotNil(transactionViewController.viewModel)
  }
  
  // test that each appConfiguration case is created correctly
  func testAppConfiguration() {
    switch appConfiguration {
    case .live:
      XCTAssert(transactionViewController.viewModel.service is TransactionsService)
    case .mock:
      XCTAssert(transactionViewController.viewModel.service is MockTransactionsService)
    }
  }
  
  func testViewModelFetchTransaction() {
    transactionViewModel.fetchTransactions()
    
    // test that viewModel.fetchTransactions() is called only once
    XCTAssertEqual(mockService.getTransactionCounter, 1)
    
    // test the right number of elements
    XCTAssertEqual(transactionViewModel.transactions.value.count, 1)
  }
  
  // test viewModel calculateBalanceTotal() calculation
  func testViewModelTotalBalance() {
    transactionViewModel.fetchTransactions()
    
    XCTAssertEqual(transactionViewModel.totalBalance(), 100)
  }
  
  // test Amount decimalValue
  func testAmountDecimalValue() {
    XCTAssertEqual(testAmount.decimalValue, 27.9)
  }
  
  // test NSDecimalNumber integerValueWithPrecision2 computed property
  func testNSDecimalNumberExtension() {
    XCTAssertEqual(testAmount.decimalValue.integerValueWithPrecision2, 2790)
  }
  
}
