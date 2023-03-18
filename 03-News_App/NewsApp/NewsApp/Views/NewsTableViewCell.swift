//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 14.4.21.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
  
  // MARK: - Properties -
  static let reuseIdentifier = String(describing: NewsTableViewCell.self)
  
  var newsViewModel: NewsViewModel? {
    didSet {
      if let newsViewModel = newsViewModel {
        titleLabel.text = newsViewModel.title
        NetworkManager.shared.getImage(urlString: newsViewModel.urlToImage) { [weak self] result in
          guard let self = self else { return }
          switch result {
          case .success(let data):
            DispatchQueue.main.async {
              self.newsImageView.image = UIImage(data: data)
            }
          case .failure(let error):
            print(error)
          }
        }
      }
    }
  }
  
  var newsImageData: Data?  {
    didSet {
      if let data = newsImageData {
        newsImageView.image = UIImage(data: data)
      }
    }
  }
  
  // MARK: - UI -
  private lazy var newsImageView: ShadowImageView = {
    let imageView = ShadowImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  // MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set up Views and Constraints -
  func setupView() {
    contentView.addSubview(newsImageView)
    contentView.addSubview(titleLabel)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      newsImageView.heightAnchor.constraint(equalToConstant: 200),
      
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}
