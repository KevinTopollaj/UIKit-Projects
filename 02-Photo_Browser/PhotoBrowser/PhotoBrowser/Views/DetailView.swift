//
//  DetailView.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 13.4.21.
//

import UIKit

// MARK: - DetailViewDelegate -
protocol DetailViewDelegate: class {
  func didTapCloseButton(sender: DetailView)
}

class DetailView: UIView {
  
  // MARK: - Properties -
  weak var delegate: DetailViewDelegate?
  var photo: Photo?
  
  lazy var viewModel: DetailViewModel = {
    let viewModel = DetailViewModel()
    return viewModel
  }()
  
  // MARK: - UI -
  private lazy var mainPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private lazy var closeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("X", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTapCloseButton(sender:)), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Initializers -
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Method -
  func displayImage() {
    guard let portraitImageURLString = photo?.src.portrait else { return }

    if let url = URL(string: portraitImageURLString) {
      _ = viewModel.loadImage(url: url) { [weak self] (result) in
        guard let self = self else { return }

        switch result {
        case .success(let imageData):
          let image = UIImage(data: imageData)
          DispatchQueue.main.async {
            self.mainPhotoImageView.image = image
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    addSubview(mainPhotoImageView)
    addSubview(closeButton)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      closeButton.widthAnchor.constraint(equalToConstant: 40),
      closeButton.heightAnchor.constraint(equalToConstant: 40),
      
      mainPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mainPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
      mainPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Actions -
  @objc func didTapCloseButton(sender: UIButton) {
    delegate?.didTapCloseButton(sender: self)
  }
}
