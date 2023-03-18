//
//  EventListViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

class EventListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var viewModel: EventListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
    
    setupNavigationController()
    
    viewModel.onUpdate = { [weak self] in
      self?.tableView.reloadData()
    }
    
    viewModel.viewDidLoad()
  }
  
  private func setupNavigationController() {
    let plusImage = UIImage(systemName: "plus.circle.fill")
    let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventBarButton))
    barButtonItem.tintColor = .primary
    navigationItem.rightBarButtonItem = barButtonItem
    navigationItem.title = viewModel.title
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func tappedAddEventBarButton() {
    viewModel.tappedAddEvent()
  }
  
}

extension EventListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch viewModel.cell(at: indexPath) {
    case .event(let eventCellViewModel):
      let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
      cell.update(with: eventCellViewModel)
      return cell
    }
  }
}

extension EventListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath)
  }
}
