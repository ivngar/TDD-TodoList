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
      sut.itemManager.removeAll()
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
  
  func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
    let target = sut.navigationItem.rightBarButtonItem?.target
    XCTAssertEqual(target as? UIViewController, sut)
  }
  
  func test_AddItem_PresentsAddItemViewController() {
    XCTAssertNil(sut.presentedViewController)
    
    guard let inputViewController = presentInputViewController() else { XCTFail(); return }
    XCTAssertNotNil(inputViewController.titleTextField)
  }
  
  func test_ItemListVC_SharesItemManagerWithInputVC() {
    guard let inputViewController = presentInputViewController() else { XCTFail(); return }
    XCTAssertTrue(sut.itemManager === inputViewController.itemManager)
    }
  
  func presentInputViewController() -> InputViewController? {
    guard let addButton = sut.navigationItem.rightBarButtonItem else { XCTFail(); return nil}
    guard let action = addButton.action else { XCTFail(); return nil }
    
    UIApplication.shared.keyWindow?.rootViewController = sut
    
    sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
    
    guard let inputViewController = sut.presentedViewController as? InputViewController else { XCTFail(); return nil}
    return inputViewController
  }
  
  func test_ViewDidLoad_SetsItemManagerToDataProvider() {
    XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
  }
  
  func test_ReloadTableView_WhenViewWillAppear() {
    let mockItemTableView = MockItemTableView()
    sut.tableView = mockItemTableView
    
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    
    XCTAssertTrue(mockItemTableView.reloadedTableView)
  }
  

  
}

class MockItemTableView: UITableView {
  var reloadedTableView = false
  
  override func reloadData() {
    self.reloadedTableView = true
  }
}
