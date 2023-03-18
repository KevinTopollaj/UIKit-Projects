//
//  AddEventViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import Foundation

final class AddEventViewModel {
  
  let title = "Add"
  var onUpdate: () -> Void = {}
  
  enum Cell {
    case titleSubtitle(TitleSubtitleCellViewModel)
  }
  
  private(set) var cells: [AddEventViewModel.Cell] = []
  weak var coordinator: AddEventCoordinator?
  
  private var nameCellViewModel: TitleSubtitleCellViewModel?
  private var dateCellViewModel: TitleSubtitleCellViewModel?
  private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
 
  private let eventCellBuilder: EventCellBuilder
  private let eventService: EventServiceProtocol
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyy"
    return dateFormatter
  }()
  
  init(eventCellBuilder: EventCellBuilder, eventService: EventServiceProtocol = EventService()) {
    self.eventCellBuilder = eventCellBuilder
    self.eventService = eventService
  }
  
  func viewDidLoad() {
    setupCells()
    onUpdate()
  }
  
  func viewDidDisappear() {
    coordinator?.didFinish()
  }
  
  func numberOfRows() -> Int {
    return cells.count
  }
  
  func cell(for indexPath: IndexPath) -> Cell {
    return cells[indexPath.row]
  }
  
  func tappedDone() {
    // extract info from cell view models and save in core data
    guard let name = nameCellViewModel?.subtitle,
          let dateString = dateCellViewModel?.subtitle,
          let image = backgroundImageCellViewModel?.image,
          let date = dateFormatter.date(from: dateString) else { return }
    
    eventService.perform(.add, data: EventService.EventInputData(name: name, date: date, image: image))
    
    // tell the coordinator to dismiss
    coordinator?.didFinishSaveEvent()
  }
  
  func updateCell(indexPath: IndexPath, subtitle: String) {
    switch cells[indexPath.row] {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      titleSubtitleCellViewModel.update(subtitle)
    }
  }
  
  func didSelectRow(at indexPath: IndexPath) {
    switch cells[indexPath.row] {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      guard titleSubtitleCellViewModel.type == .image else {
        return
      }
      
      coordinator?.showImagePicker { image in
        titleSubtitleCellViewModel.update(image)
      }
    }
  }
}

private extension AddEventViewModel {
  func setupCells() {
    nameCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.text)
    
    dateCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.date, onCellUpdate: { [weak self] in
      self?.onUpdate()
    })
    
    backgroundImageCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.image, onCellUpdate: { [weak self] in
      self?.onUpdate()
    })
    
    guard let nameCellViewModel = nameCellViewModel,
          let dateCellViewModel = dateCellViewModel,
          let backgroundImageCellViewModel = backgroundImageCellViewModel else { return}
    
    cells = [
      .titleSubtitle(nameCellViewModel),
      .titleSubtitle(dateCellViewModel),
      .titleSubtitle(backgroundImageCellViewModel)
    ]
  }
}
