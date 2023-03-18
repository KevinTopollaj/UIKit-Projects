//
//  FullScreenLockController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

// MARK: - Config -
private struct Config {
  public static let fadeDuration = 0.3
}

class FullscreenLockViewController: UIViewController {
  
  // MARK: - Properties -
  let loadingViewController = LoadingViewController()
  let retryViewController = RetryViewController()
  let emptyViewController = EmptyViewController()
  
  // MARK: - Initializers -
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    buildSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods -
  private func buildSubviews() {
    addLockingView(viewController: retryViewController)
    addLockingView(viewController: loadingViewController)
    addLockingView(viewController: emptyViewController)
    
    loadingViewController.view.alpha = 0
    retryViewController.view.alpha = 0
    emptyViewController.view.alpha = 0
  }
  
  func setToRetryState(with error: String) {
    view.bringSubviewToFront(retryViewController.view)
    UIView.animate(withDuration: Config.fadeDuration) {
      self.loadingViewController.view.alpha = 0
    }
    retryViewController.errorLabel.text = error
    retryViewController.view.alpha = 1
  }
  
  func setToLoadingState() {
    view.bringSubviewToFront(loadingViewController.view)
    retryViewController.view.alpha = 0
    loadingViewController.view.alpha = 1
  }
  
  func doneLoading() {
    UIView.animate(withDuration: Config.fadeDuration) {
      self.retryViewController.view.alpha = 0
      self.loadingViewController.view.alpha = 0
    }
  }
  
  func setToEmptyState() {
    view.bringSubviewToFront(emptyViewController.view)
    retryViewController.view.alpha = 0
    loadingViewController.view.alpha = 0
    emptyViewController.view.alpha = 1
  }
  
  func addLockingView(viewController: UIViewController) {
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParent: self)
    
    NSLayoutConstraint.activate([
      viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
