//
//  AddEventViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

class AddEventViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var viewModel: AddEventViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    
    viewModel.onUpdate = { [weak self] in
      self?.tableView.reloadData()
    }
    
    viewModel.viewDidLoad()
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel.viewDidDisappear()
  }
  
  @objc func tappedDone() {
    viewModel.tappedDone()
  }
  
  private func setupViews() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
    tableView.tableFooterView = UIView()
    
    navigationItem.title = viewModel.title
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    navigationController?.navigationBar.tintColor = .systemBlue
    
    // to force large titles
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
  }
  
}

extension AddEventViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = viewModel.cell(for: indexPath)
    
    switch cellViewModel {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubtitleCell", for: indexPath) as! TitleSubtitleCell
      cell.update(with: titleSubtitleCellViewModel)
      cell.subtitleTextField.delegate = self
      return cell
    }
  }
}

extension AddEventViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: false)
  }
}

extension AddEventViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let currentText = textField.text else { return false }
    let text = currentText + string
    
    let point = textField.convert(textField.bounds.origin, to: tableView)
    if let indexPath = tableView.indexPathForRow(at: point) {
      viewModel.updateCell(indexPath: indexPath, subtitle: text)
    }
    
    return true
  }
}
