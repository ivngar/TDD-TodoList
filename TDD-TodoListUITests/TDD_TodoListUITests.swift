//
//  TDD_TodoListUITests.swift
//  TDD-TodoListUITests
//
//  Created by Ivan Garcia on 30/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import XCTest

class TDD_TodoListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      let app = XCUIApplication()
      app.navigationBars["TDD_TodoList.ItemListView"].buttons["Add"].tap()
      
      let titleTextField = app.textFields["Title"]
      titleTextField.tap()
      titleTextField.tap()
      titleTextField.typeText("Meeting")
      
      let dateTextField = app.textFields["date"]
      dateTextField.tap()
      dateTextField.tap()
      dateTextField.typeText("02/22/2016")
      
      let locationTextField = app.textFields["location"]
      locationTextField.tap()
      locationTextField.tap()
      locationTextField.typeText("office")
      
      let addressTextField = app.textFields["address"]
      addressTextField.tap()
      addressTextField.tap()
      addressTextField.typeText("infinite loop 1, cupertino")
      
      let descriptionTextField = app.textFields["description"]
      descriptionTextField.tap()
      descriptionTextField.tap()
      descriptionTextField.typeText("bring ipad")
      
      let saveButton = app.buttons["Save"]
      saveButton.tap()
      
      XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
      XCTAssertTrue(app.tables.staticTexts["02/22/2016"].exists)
      XCTAssertTrue(app.tables.staticTexts["office"].exists)
      
    }
    
}
