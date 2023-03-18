//
//  DetailViewController.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: - Properties -
  lazy var detailView: DetailView = {
    let detailView = DetailView()
    detailView.translatesAutoresizingMaskIntoConstraints = false
    detailView.delegate = self
    return detailView
  }()
  
  // MARK: - Life cycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    detailView.displayImage()
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    view.addSubview(detailView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailView.topAnchor.constraint(equalTo: view.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
}

// MARK: - DetailViewDelegate -
extension DetailViewController: DetailViewDelegate {
  func didTapCloseButton(sender: DetailView) {
    self.dismiss(animated: true)
  }
}
