//
//  InputViewController.swift
//  TDD-TodoList
//
//  Created by Ivan Garcia on 27/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
  
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var dateTextField: UITextField!
  @IBOutlet var locationTextField: UITextField!
  @IBOutlet var addressTextField: UITextField!
  @IBOutlet var descriptionTextField: UITextField!
  @IBOutlet var saveButton: UIButton!
  
  lazy var geocoder = CLGeocoder()
  var itemManager: ItemManager?
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func save() {
    guard let titleString = titleTextField.text, titleString.characters.count > 0 else {
      return }
    let date: Date?
    if let dateText = self.dateTextField.text, dateText.characters.count > 0 {
      date = dateFormatter.date(from: dateText)
    } else {
      date = nil
    }
    let descriptionString = descriptionTextField.text
    if let locationName = locationTextField.text, locationName.characters.count > 0 {
      if let address = addressTextField.text, address.characters.count > 0 {
        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
          let placeMark = placemarks?.first
          let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
          self.itemManager?.add(item)
          self.dismiss(animated: true, completion: nil)
        })
      }
    } else {
      let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
      self.itemManager?.add(item)
      self.dismiss(animated: true, completion: nil)
    }
  }

}
