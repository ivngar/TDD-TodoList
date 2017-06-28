//
//  ItemListDataProvider.swift
//  TDD-TodoList
//
//  Created by Ivan Garcia on 22/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import UIKit

enum Section: Int {
  case todo
  case done
}

class ItemListDataProvider: NSObject {
  var itemManager: ItemManager?
}

extension ItemListDataProvider: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    guard let itemManager = itemManager else { return 0 }
    guard let itemSection = Section(rawValue: section) else {
      fatalError()
    }
    
    let numberOfRows: Int
    
    switch itemSection {
    case .todo:
      numberOfRows = itemManager.todoCount
    case .done:
      numberOfRows = itemManager.doneCount
    }
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    guard let itemManager = itemManager else { fatalError() }
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    let item: ToDoItem
    switch section {
    case .todo:
      item = itemManager.item(at: indexPath.row)
    case .done:
      item = itemManager.doneItem(at: indexPath.row)
    }
    cell.configCell(with: item)
    return cell
  }
}

extension ItemListDataProvider: UITableViewDelegate {
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    let buttonTitle: String
    switch section {
    case .todo:
      buttonTitle = "Check"
    case .done:
      buttonTitle = "Uncheck"
    }
    return buttonTitle
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard let itemManager = itemManager else { fatalError() }
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }
    
    switch section {
    case .todo:
      itemManager.checkItem(at: indexPath.row)
    case .done:
      itemManager.uncheckItem(at: indexPath.row)
    }
    tableView.reloadData()
  }
}
