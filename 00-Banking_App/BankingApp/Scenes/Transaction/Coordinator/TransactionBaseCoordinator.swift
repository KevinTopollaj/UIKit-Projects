//
//  HomeBaseCoordinator.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

protocol TransactionBaseCoordinator: Coordinator {
  func goToTransactionDetailScreen(with transaction: TransactionResponse.Transaction) 
  func goToMoreFlow()
  func goToDeepViewInMoreTab()
}
