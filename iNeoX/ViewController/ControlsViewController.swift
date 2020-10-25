//
//  ControlsViewController.swift
//  iNeo
//
//  Created by inomera on 5.03.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import SafariServices
import os.log

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
    
    let path: String? = Bundle.main.path(forResource: "Icon-App2@2x", ofType: "png")
    print(path ?? "")
    
    var filePath = Bundle.main.url(forResource: "Icon-App2@2x", withExtension: "png")

    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
      let fileURL = documentsDirectory.appendingPathComponent("Icon-App2@2x.png")
      do {
        if try fileURL.checkResourceIsReachable() {
          print("file exist")
        } else {
          print("file doesnt exist")
          do {
            try Data().write(to: fileURL)
          } catch {
            print("an error happened while creating the file")
          }
        }
      } catch {
        print("an error happened while checking for the file")
      }
    }
    
  }
  
  func saveIcon() {

  }
  
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            if let data = image.pngData() {
              let filename = self!.getDocumentsDirectory().appendingPathComponent("copy.png")
              try? data.write(to: filename)
            }
          }
        }
      }
    }
  }
  
  func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
  }
  
  @objc func touchedView(_ sender: Any) {
    print("touchedView")
    
    let event = MyCustomEvent()
    event.testNumber = NSNumber(value: 10)
    Netmera.send(event)
  }
  
  @IBAction func touchedButton(_ sender: Any) {
    self.view.endEditing(true)
    self.changeIcon(to: "Icon-App2")
  }
  
  func changeIcon(to iconName: String?) {
    // 1
    if #available(iOS 10.3, *) {
      print(UIApplication.shared.alternateIconName ?? "Primary")

      guard UIApplication.shared.supportsAlternateIcons else {
        return
      }
      // 2
      UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
        // 3
        if let error = error {
          print("App icon failed to change due to \(error.localizedDescription)")
        } else {
          print("App icon changed successfully")
        }
      })
    } else {
      // Fallback on earlier versions
    }
    
   
  }
    
  @IBAction func touchedSecondButton(_ sender: Any) {
    self.view.endEditing(true)
    self.changeIcon(to: "Icon-App3")
  }
  
  @IBAction func valueChangedSwitched(_ sender: Any) {
    let redirectUrl = URL(string: "http://track.sdpaas.com/adjust/")!
    let safariViewController = SFSafariViewController(url: redirectUrl)
    safariViewController.delegate = self
//        safariViewController.modalPresentationStyle = .overCurrentContext
    safariViewController.view.alpha = 1.05
     
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        self.present(UINavigationController(rootViewController: safariViewController), animated: false, completion: nil)
    }
  }
  
  @IBAction func valueChangedSegment(_ sender: Any) {
    self.changeIcon(to: nil)
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

extension ControlsViewController: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        let storage = HTTPCookieStorage.shared
        print(storage.cookies)
//     controller.dismiss(animated: false, completion: nil)
    }
   
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//     controller.dismiss(animated: false, completion: nil)
    }
}
