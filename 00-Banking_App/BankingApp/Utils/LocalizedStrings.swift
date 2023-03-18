//
//  LocalizedStrings.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

enum LocalizedString {
  
  enum TabBarItem {
    static let transactions = NSLocalizedString("Transactions",
                                                comment: "First TabBarItem title")
    static let more = NSLocalizedString("More",
                                        comment: "Second TabBarItem title")
  }
  
  enum ViewControllerState {
    static let loading = NSLocalizedString("Loading...",
                                           comment: "Loading view controller label text")
    static let retry = NSLocalizedString("Retry",
                                         comment: "Retry view controller button text")
    static let emptyTransactionList = NSLocalizedString("Your transaction list is empty.",
                                                        comment: "Empty view controller label text")
  }
  
  enum Onboarding {
    static let page1Image = NSLocalizedString("arrow.left.arrow.right.circle",
                                           comment: "First page image title in onboarding view controller")
    static let page2Image = NSLocalizedString("arrow.down.backward.circle",
                                           comment: "Second page image title in onboarding view controller")
    static let page3Image = NSLocalizedString("arrow.up.forward.circle",
                                           comment: "Third page image title in onboarding view controller")
    
    static let page1Title = NSLocalizedString("Best App to keep track of your transactions!",
                                           comment: "First page title in onboarding view controller")
    static let page2Title = NSLocalizedString("Transactions that are coming into your account.",
                                           comment: "Second page title in onboarding view controller")
    static let page3Title = NSLocalizedString("Transactions that are going out of your account.",
                                           comment: "Third page title in onboarding view controller")
  }
  
  enum BarButtonItem {
    static let more = NSLocalizedString("More",
                                        comment: "Bar Button Item title")
    static let more3Screen = NSLocalizedString("More3Screen",
                                               comment: "Bar Button Item title")
  }
  
  enum TransactionList {
    static let title = NSLocalizedString("Transactions",
                                                comment: "TransactionViewController title")
  }
  
  enum TransactionDetail {
    static let title = NSLocalizedString("Detail",
                                                comment: "TransactionDetailViewController title")
    static let transactionTitle = NSLocalizedString("Transaction Title",
                                                comment: "TransactionDetailViewController label title")
    static let transactionSubtitle = NSLocalizedString("Transaction Subtitle",
                                                comment: "TransactionDetailViewController label title")
    static let transactionAmount = NSLocalizedString("Transaction Amount",
                                                comment: "TransactionDetailViewController label title")
  }
  
  enum Words {
    static let close = NSLocalizedString("Close",
                                         comment: "Close word")
  }
  
  enum Currency {
    static let euro = NSLocalizedString("€",
                                        comment: "Euro Symbol")
  }
  
  enum Nib {
    static let headerNib = NSLocalizedString("TransactionHeaderView",
                                             comment: "Header Nib identifier")
  }
}
