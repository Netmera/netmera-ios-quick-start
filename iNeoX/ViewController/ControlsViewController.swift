//
//  ControlsViewController.swift
//  iNeo
//
//  Created by inomera on 5.03.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit

class ControlsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {

  let textDelegate = ControlsDelegate()
  let noSelectorTextDelegate = ControlsDelegateNoSelector()
  let number: Int = 0
  let string: String = "ads"
  
  @IBOutlet weak var netButton: UIButton!
  @IBOutlet weak var netSwitch: UISwitch!
  @IBOutlet weak var netSegmentControl: UISegmentedControl!
  @IBOutlet weak var netPickerView: UIPickerView!
  @IBOutlet weak var netTabbar: UITabBar!
  @IBOutlet weak var netDatePicker: UIDatePicker!
  @IBOutlet weak var netSlider: UISlider!
  @IBOutlet weak var netStepper: UIStepper!
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var actionTextField: UITextField!
  @IBOutlet weak var delegateTextField: UITextField!
  @IBOutlet weak var missingSelectorDelegateTextField: UITextField!

  @IBOutlet weak var barbutton: UIBarButtonItem!
  @IBOutlet weak var tapView: UIView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var stepperLabel: UILabel!
  var userId: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.netPickerView.delegate = self;
    self.netPickerView.dataSource = self;
    
    self.textField.delegate = textDelegate;
    self.textView.delegate = self;
    self.delegateTextField.delegate = self
    self.missingSelectorDelegateTextField.delegate = noSelectorTextDelegate

    tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchedView(_:))))
    tapView.isUserInteractionEnabled = true
  }
  
  @objc func touchedView(_ sender: Any) {
    print("touchedView")
  }
  
  @IBAction func touchedButton(_ sender: Any) {
    self.view.endEditing(true)
  }
  
  @IBAction func touchedSecondButton(_ sender: Any) {
    self.view.endEditing(true)
  }
  
  @IBAction func valueChangedSwitched(_ sender: Any) {
    
  }
  
  @IBAction func valueChangedSegment(_ sender: Any) {
    
  }
  @IBAction func valueChangedSlider() {
    
  }
  
  @IBAction func valueChangedStepper(_ sender: Any) {
    stepperLabel.text = "\(netStepper.value)"
  }
  
  @IBAction func touchedBarButton(_ sender: Any) {
    
  }
  
  @IBAction func valueChangedDatePicker(_ sender: Any) {
    
  }

  @IBAction func valueChangedActionTextField(_ sender: Any) {
    
  }
  
  @IBAction func valueChangedFullTextField(_ sender: Any) {
    
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return 10
    } else {
      return 20
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return "\(component) - \(row)"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print("didSelectRow: \(row), component \(component)")
  }
  
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
     print("didBegin Editing")
   }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
}

class ControlsDelegate: NSObject, UITextFieldDelegate  {
  func textFieldDidEndEditing(_ textField: UITextField) {
     print("didBegin Editing")
   }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}


class ControlsDelegateNoSelector: NSObject, UITextFieldDelegate  {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}

