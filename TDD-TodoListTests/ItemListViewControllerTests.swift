//
//  ItemListViewControllerTests.swift
//  TDD-TodoListTests
//
//  Created by Ivan Garcia on 22/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest
@testable import TDD_TodoList

class ItemListViewControllerTests: XCTestCase {
  
  var sut: ItemListViewController!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
      sut = viewController as! ItemListViewController
      _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func test_TableViewIsNotNilAfterViewDidLoad() {
    XCTAssertNotNil(sut.tableView)
  }
  
  func test_LoadingView_SetsTableViewDataSource() {
    XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
  }
  
  func test_LoadingView_SetsTableViewDelegate() {
    XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
  }
  
  func test_LoadingView_SetsDataSourceAndDelegateToSameObject() {
    XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
  }
}
