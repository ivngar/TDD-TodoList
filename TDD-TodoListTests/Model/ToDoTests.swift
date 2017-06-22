//
//  ToDoTests.swift
//  TDD-TodoListTests
//
//  Created by Ivan Garcia on 20/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest
@testable import TDD_TodoList

class ToDoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func test_Init_TakesTitle() {
    let item = ToDoItem(title: "Foo")
    
    XCTAssertEqual(item.title, "Foo", "should set title")
  }
  
  func test_init_takesTitleAndDescription() {
    let item = ToDoItem(title: "Foo", itemDescription: "Bar")
    
    XCTAssertEqual(item.itemDescription, "Bar", "should set description")
  }
  
  func test_Init_WhenGivenTimestamp_SetsTimestamp() {
    let item = ToDoItem(title: "", timestamp: 0.0)
    
    XCTAssertEqual(item.timestamp, 0.0, "should set timestamp")
  }
  
  func test_Init_WhenGivenLocation_SetsLocation() {
    let location = Location(name: "Foo")
    let item = ToDoItem(title: "", location: location)
    
    XCTAssertEqual(item.location?.name, location.name, "should set location")
  }
  
  func test_EqualItems_AreEqual() {
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Foo")
    
    XCTAssertEqual(first, second)
  }
  
  func test_Items_WhenLocationDiffers_AreNotEqual() {
    let first = ToDoItem(title: "", location: Location(name: "Foo"))
    let second = ToDoItem(title: "", location: Location(name: "Bar"))
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenOneLocationIsNilAndTheOtherIsnt_AreNotEqual() {
    var first = ToDoItem(title: "", location: Location(name: "Foo"))
    var second = ToDoItem(title: "", location: nil)
    
    first = ToDoItem(title: "", location: nil)
    second = ToDoItem(title: "", location: Location(name: "Foo"))
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Items_WhenTimestampDiffer_AreNotEqual() {
    let first = ToDoItem(title: "Foo", timestamp: 1.0)
    let second = ToDoItem(title: "Foo", timestamp: 0.0)
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Item_WhenDescriptionsDiffer_AreNotEqual() {
    let first = ToDoItem(title: "Foo", itemDescription: "Bar")
    let second = ToDoItem(title: "Foo", itemDescription: "Baz")
    
    XCTAssertNotEqual(first, second)
  }
  
  func test_Item_WhenTitleDiffers_AreNotEqual() {
    let first = ToDoItem(title: "Foo")
    let second = ToDoItem(title: "Bar")
    
    XCTAssertNotEqual(first, second)
  }
  
  
  
}
