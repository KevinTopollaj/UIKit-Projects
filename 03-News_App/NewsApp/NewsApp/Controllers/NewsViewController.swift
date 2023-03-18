//
//  ViewController.swift
//  NewsApp
//
//  Created by Kevin Topollaj on 13.4.21.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
  
  // MARK: - Properties -
  var listViewModel = NewsListViewModel()
  
  // MARK: - UI -
  private lazy var headerView: HeaderView = {
    let headerView = HeaderView(fontSize: 32)
    return headerView
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableFooterView = UIView()
    tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()

  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    fetchNews()
  }
  
  // MARK: - Set up Views and Constraints -
  func setupView() {
    view.backgroundColor = .white
    view.addSubview(headerView)
    view.addSubview(tableView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // MARK: - Helper Methods -
  func fetchNews() {
    listViewModel.getNews { [weak self] _ in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }

}

// MARK: - UITableViewDataSource -
extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    listViewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell
    let news = listViewModel.getNewsViewModel(for: indexPath)
    cell.newsViewModel = news
    return cell
  }
}

// MARK: - UITableViewDelegate -
extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let news = listViewModel.getNewsViewModel(for: indexPath)
    guard let url = URL(string: news.url) else { return }
    
    let config = SFSafariViewController.Configuration()
    let safariViewController = SFSafariViewController(url: url, configuration: config)
    safariViewController.modalPresentationStyle = .fullScreen
    present(safariViewController, animated: true)
  }
}

