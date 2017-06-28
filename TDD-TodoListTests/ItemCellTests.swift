//
//  ItemCellTests.swift
//  TDD-TodoListTests
//
//  Created by Ivan Garcia on 23/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest
@testable import TDD_TodoList
class ItemCellTests: XCTestCase {
  
  var tableView: UITableView!
  let dataSource = FakeDataSource()
  var cell: ItemCell!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
      _ = controller.view
      
      tableView = controller.tableView
      tableView?.dataSource = dataSource
      
     cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func test_HasNameLabel() {
    XCTAssertNotNil(cell.titleLabel)
  }
  
  func test_HasLocationLabel() {
    XCTAssertNotNil(cell.locationLabel)
  }
  
  func test_HasDateLabel() {
    XCTAssertNotNil(cell.dateLabel)
  }
  
  func test_ConfigCell_SetsLabelTexts() {
    let location = Location(name: "Bar")
    let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
    cell.configCell(with: item)
    
    XCTAssertEqual(cell.titleLabel.text, "Foo")
    XCTAssertEqual(cell.locationLabel.text, "Bar")
    XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
  }
  
  func test_Title_WhenItemIsChecked_IsStrokeThrough() {
    let location = Location(name: "Bar")
    let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
    cell.configCell(with: item, checked: true)
    
    let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
    
    XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    XCTAssertNil(cell.locationLabel.text)
    XCTAssertNil(cell.dateLabel.text)
    
  }
}

class FakeDataSource: NSObject, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}