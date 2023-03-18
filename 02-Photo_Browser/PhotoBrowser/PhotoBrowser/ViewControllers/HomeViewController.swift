//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Properties -
  lazy var photoListView: PhotoListView = {
    let photoListView = PhotoListView()
    photoListView.translatesAutoresizingMaskIntoConstraints = false
    photoListView.delegate = self
    return photoListView
  }()
  
  // MARK: - Life cycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupView()
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    view.addSubview(photoListView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      photoListView.topAnchor.constraint(equalTo: view.topAnchor),
      photoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      photoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - PhotoListViewDelegate -
extension HomeViewController: PhotoListViewDelegate {
  func selectedPhoto(sender: PhotoListView, photo: Photo) {
    let detailViewController = DetailViewController()
    detailViewController.detailView.photo = photo
    present(detailViewController, animated: true)
  }
}

