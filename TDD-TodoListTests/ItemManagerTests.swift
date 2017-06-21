//
//  ItemManagerTests.swift
//  TDD-TodoListTests
//
//  Created by Ivan Garcia on 21/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest
@testable import TDD_TodoList

class ItemManagerTests: XCTestCase {
  
  var sut: ItemManager!
    override func setUp() {
        super.setUp()
        sut = ItemManager()
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func test_TodoCount_Initially_IsZero() {
    XCTAssertEqual(sut.todoCount, 0)
  }
  
  func test_doneCount_Initially_isZero() {
    XCTAssertEqual(sut.doneCount, 0)
  }
  
  func test_addItem_IncreasesCountToOne() {
    sut.add(ToDoItem(title: ""))
    
    XCTAssertEqual(sut.todoCount, 1)
  }
  
  func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
    let item = ToDoItem(title: "Foo")
    sut.add(item)
    let returnedItem = sut.item(at: 0)
    
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  func test_CheckItemAt_ChangesCounts() {
    sut.add(ToDoItem(title: ""))
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.todoCount, 0)
    XCTAssertEqual(sut.doneCount, 1)
  }
  
  func test_DoneItemAt_ReturnsCheckedItem() {
    let item = ToDoItem(title: "Foo")
    sut.add(item)
    sut.checkItem(at: 0)
    let returnedItem = sut.doneItem(at: 0)
    
    XCTAssertEqual(returnedItem.title, item.title)
  }
  
  func test_CheckItemAt_RemovesItFromToDoItems() {
    let first = ToDoItem(title: "First")
    let second = ToDoItem(title: "Second")
    sut.add(first)
    sut.add(second)
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.item(at: 0).title, "Second")
  }
  
  func test_RemoveAll_ResultsInCountsBeZero() {
    sut.add(ToDoItem(title: "Foo"))
    sut.add(ToDoItem(title: "Bar"))
    sut.checkItem(at: 0)
    
    XCTAssertEqual(sut.todoCount, 1)
    XCTAssertEqual(sut.doneCount, 1)
    
    sut.removeAll()
    
    XCTAssertEqual(sut.todoCount, 0)
    XCTAssertEqual(sut.doneCount, 0)
  }
  
  func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
    sut.add(ToDoItem(title: "Foo"))
    sut.add(ToDoItem(title: "Foo"))
    
    XCTAssertEqual(sut.todoCount, 1)
  }
}
