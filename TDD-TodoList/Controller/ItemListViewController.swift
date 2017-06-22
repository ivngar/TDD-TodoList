//
//  ItemListViewController.swift
//  TDD-TodoList
//
//  Created by Ivan Garcia on 22/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
  
  override func viewDidLoad() {
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
  }

}
