//
//  PhotoListView.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

// MARK: - PhotoListViewDelegate -
protocol PhotoListViewDelegate: class {
  func selectedPhoto(sender: PhotoListView, photo: Photo)
}

class PhotoListView: UIView {
  // MARK: - Properties -
  weak var delegate: PhotoListViewDelegate?
  
  lazy var viewModel: PhotoListViewModel = {
    let viewModel = PhotoListViewModel()
    viewModel.delegate = self
    return viewModel
  }()
  
  // MARK: - UI -
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.reuseIdentifier)
    return tableView
  }()
  
  // MARK: - Initializers -
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    addSubview(tableView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
    ])
  }
}

// MARK: - PhotoListViewModelDelegate -
extension PhotoListView: PhotoListViewModelDelegate {
  func photosLoaded(sender: PhotoListViewModel) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource -
extension PhotoListView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
    let photo = viewModel.getPhoto(at: indexPath)
    cell.photographerLabel.text = photo.photographer
    cell.photographerTagLabel.text = photo.photographer_tag
    
    if let url = URL(string: photo.src.landscape) {
      let uuid = viewModel.loadImage(url: url) { [weak cell] result in

        guard let cell = cell else { return }
        
        switch result {
        case .success(let imageData):
          let image = UIImage(data: imageData)
          DispatchQueue.main.async {
            cell.photoImageView.image = image
          }
        case .failure(let error):
          print(error)
        }
      }
      
      cell.onReuse = {
        if let uuid = uuid {
          self.viewModel.cancel(uuid: uuid)
        }
      }
      
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate -
extension PhotoListView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    200
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let photo = viewModel.getPhoto(at: indexPath)
    delegate?.selectedPhoto(sender: self, photo: photo)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.count - 10 {
      viewModel.loadPhotos()
    }
  }
}

