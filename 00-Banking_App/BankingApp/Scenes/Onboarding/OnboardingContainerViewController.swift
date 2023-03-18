//
//  OnboardingContainerViewController.swift
//
//  Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
  func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
  
  // MARK: - UI Elements -
  let pageViewController: UIPageViewController
  var closeButton = UIButton(type: .system)
  
  // MARK: - Properties -
  var pages = [UIViewController]()
  var currentViewController: UIViewController
  
  weak var delegate: OnboardingContainerViewControllerDelegate?
  
  // MARK: - Initializers -
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    
    self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                   navigationOrientation: .horizontal,
                                                   options: nil)
    
    let page1 = OnboardingViewController(imageName: LocalizedString.Onboarding.page1Image,
                                         titleText: LocalizedString.Onboarding.page1Title)
    let page2 = OnboardingViewController(imageName: LocalizedString.Onboarding.page2Image,
                                         titleText: LocalizedString.Onboarding.page2Title)
    let page3 = OnboardingViewController(imageName: LocalizedString.Onboarding.page3Image,
                                         titleText: LocalizedString.Onboarding.page3Title)
    
    pages.append(page1)
    pages.append(page2)
    pages.append(page3)
    
    currentViewController = pages.first!
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Livecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    style()
    layout()
  }
  
  // MARK: - Helper Methods -
  private func setup() {
    
    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
    
    pageViewController.dataSource = self
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    setPageControlAppearance()
    
    pageViewController.setViewControllers([pages.first!],
                                          direction: .forward,
                                          animated: false,
                                          completion: nil)
    
    currentViewController = pages.first!
  }
}

// MARK: - Style and Layout -
extension OnboardingContainerViewController {
  
  private func setPageControlAppearance() {
    let pageControlAppearance = UIPageControl.appearance()
    pageControlAppearance.pageIndicatorTintColor = UIColor.systemBackground.withAlphaComponent(0.3)
    pageControlAppearance.currentPageIndicatorTintColor = UIColor.systemBackground
  }
  
  private func style() {
    view.backgroundColor = .systemBlue
    
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.setTitle(LocalizedString.Words.close, for: [])
    closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
  }
  
  private func layout() {
    
    view.addSubview(closeButton)
    
    // PageViewController
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
      view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
      view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
    ])
    
    // Close button
    NSLayoutConstraint.activate([
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 2),
      closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
    ])
  }
}

// MARK: - Actions -
extension OnboardingContainerViewController {
  
  @objc func closeTapped(_ sender: UIButton) {
    delegate?.didFinishOnboarding()
  }
}

// MARK: - UIPageViewControllerDataSource -
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    getPreviousViewController(from: viewController)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    getNextViewController(from: viewController)
  }
  
  private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
    
    guard let index = pages.firstIndex(of: viewController),
          index - 1 >= 0 else { return nil }
    
    currentViewController = pages[index - 1]
    
    return pages[index - 1]
  }
  
  private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
    
    guard let index = pages.firstIndex(of: viewController),
          index + 1 < pages.count else { return nil }
    
    currentViewController = pages[index + 1]
    
    return pages[index + 1]
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    pages.firstIndex(of: self.currentViewController) ?? 0
  }
  
}
