//
//  DetailViewControllerTests.swift
//  TDD-TodoListTests
//
//  Created by Ivan Garcia on 27/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TDD_TodoList

class DetailViewControllerTests: XCTestCase {
  
  var sut: DetailViewController!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
      _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut.itemInfo?.0.removeAll()
        super.tearDown()
    }
  
  func test_HasTitleLabel() {
    XCTAssertNotNil(sut.titleLabel)
  }
  
  func test_HasLocationLabel() {
    XCTAssertNotNil(sut.locationLabel)
  }
  
  func test_HasDateLabel() {
    XCTAssertNotNil(sut.dateLabel)
  }
  
  func test_HasDescriptionLabel() {
    XCTAssertNotNil(sut.descriptionLabel)
  }
  
  func test_HasMapView() {
    XCTAssertNotNil(sut.mapView)
  }
  
  func test_SettingItemInfo_SetsTextsToLabels() {
    let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
    let location = Location(name: "Foo", coordinate: coordinate)
    let item = ToDoItem(title: "Bar",
                        itemDescription: "Baz",
                        timestamp: 1456150025,
                        location: location)
    let itemManager = ItemManager()
    itemManager.add(item)
    
    sut.itemInfo = (itemManager, 0)
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    
    XCTAssertEqual(sut.titleLabel.text, "Bar")
    XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
    XCTAssertEqual(sut.locationLabel.text, "Foo")
    XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
  }
  
  func test_CheckItem_ChecksItemInItemManager() {
    let itemManager = ItemManager()
    itemManager.add(ToDoItem(title: "Foo"))
    
    sut.itemInfo = (itemManager, 0)
    sut.checkItem()
    
    XCTAssertEqual(itemManager.todoCount, 0)
    XCTAssertEqual(itemManager.doneCount, 1)
  }
  
  
}
