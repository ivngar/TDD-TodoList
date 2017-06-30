//
//  ItemManager.swift
//  TDD-TodoList
//
//  Created by Ivan Garcia on 21/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
  var todoCount: Int { return todoItems.count }
  var doneCount: Int { return doneItems.count }
  private var todoItems: [ToDoItem] = []
  private var doneItems: [ToDoItem] = []
  
  var todoPathURL: URL {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard let documentURL = fileURL.first else {
      print("Something went wrong. Documents url could not be found")
      fatalError()
    }
    
    return documentURL.appendingPathComponent("todoItems.plist")
  }
  
  var donePathURL: URL {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard let documentURL = fileURL.first else {
      print("Something went wrong. Documents url could not be found")
      fatalError()
    }
    
    return documentURL.appendingPathComponent("doneItems.plist")
  }
  
  
  override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self, selector: #selector(save), name: .UIApplicationWillResignActive, object: nil)
    
    if let nsTodoItems = NSArray(contentsOf: todoPathURL) {
      for dict in nsTodoItems {
        if let todoItem = ToDoItem(dict: dict as! [String:Any]) {
          todoItems.append(todoItem)
        }
      }
    }
    
    if let nsDoneItems = NSArray(contentsOf: donePathURL) {
      for dict in nsDoneItems {
        if let todoItem = ToDoItem(dict: dict as! [String:Any]) {
          doneItems.append(todoItem)
        }
      }
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
    save()
  }
  
  func add(_ item: ToDoItem) {
    if !todoItems.contains(item) {
      todoItems.append(item)
    }
  }
  
  func item(at index: Int) -> ToDoItem {
    return todoItems[index]
  }
  
  func checkItem(at index: Int) {
    let item = todoItems.remove(at: index)
    doneItems.append(item)
  }
  
  func uncheckItem(at index: Int) {
    let item = doneItems.remove(at: index)
    todoItems.append(item)
  }
  
  func doneItem(at index: Int) -> ToDoItem {
    return doneItems[index]
  }
  
  func removeAll() {
    todoItems.removeAll()
    doneItems.removeAll()
  }
  
  @objc func save() {
    saveItems(todoItems, toURL: todoPathURL)
    saveItems(doneItems, toURL: donePathURL)
  }
  
  func saveItems(_ items: [ToDoItem], toURL: URL) {
    let nsTodoItems = items.map { $0.plistDict }
    guard nsTodoItems.count > 0 else {
      try? FileManager.default.removeItem(at: toURL)
      return
    }
    do {
      let plistData = try PropertyListSerialization.data(fromPropertyList: nsTodoItems, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions(0))
      try plistData.write(to: toURL, options: Data.WritingOptions.atomic)
    } catch {
      print("error")
    }
  }
}
