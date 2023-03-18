//
// AppDelegate
//
// Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties -
  var window: UIWindow?
  
  
  // MARK: - AppDelegate main method -
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    
    
    setMainScreen()
    customNavigationBarAppearance()
    customTabBarAppearance()
    
    return true
  }
  
  // MARK: - Helper Methods -
  fileprivate func setMainScreen() {
    if LocalState.hasOnboarded {
      setRootViewController(MainCoordinator().start())
    } else {
      let onboardingContainerViewController = OnboardingContainerViewController()
      onboardingContainerViewController.delegate = self
      setRootViewController(onboardingContainerViewController)
    }
  }
  
  fileprivate func customNavigationBarAppearance() {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithDefaultBackground()
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
  }
  
  fileprivate func customTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithDefaultBackground()
    
    if #available(iOS 15.0, *) {
      UITabBar.appearance().scrollEdgeAppearance = appearance
    } else {
      UITabBar.appearance().standardAppearance = appearance
    }
  }
}

// MARK: - OnboardingContainerViewControllerDelegate -
extension AppDelegate: OnboardingContainerViewControllerDelegate {
  
  func didFinishOnboarding() {
    LocalState.hasOnboarded = true
    setRootViewController(MainCoordinator().start())
  }
}

// MARK: - Set the RootViewController -
extension AppDelegate {
  
  func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
    
    guard animated, let window = self.window else {
      self.window?.rootViewController = vc
      self.window?.makeKeyAndVisible()
      return
    }
    
    window.rootViewController = vc
    window.makeKeyAndVisible()
    
    UIView.transition(with: window,
                      duration: 0.3,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}

