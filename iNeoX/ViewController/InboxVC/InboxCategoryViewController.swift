//
//  InboxCategoryViewController.swift
//  iNeo
//
//  Created by inomera on 20.02.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class InboxCategoryViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var pageSizeLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  var inboxCategory: NetmeraInboxCategory?
  var selectedCategories: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerReusableCell(type: InboxCategoryTableViewCell.self)
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.dataSource = self
    tableView.delegate = self
    
    stepper.value = 2
    segmentControl.selectedSegmentIndex = 3
    pageSizeLabel.text = "\(Int(stepper.value))"
    
    let rightBarButton = UIBarButtonItem(title: "inbox", style: .done, target: self, action: #selector(touchedInboxButton))
    self.navigationItem.rightBarButtonItem = rightBarButton
    
    refreshFetchData()
  }
  
  @objc func touchedInboxButton() {
    let inboxVC = InboxViewController(nibName: "InboxViewController", bundle: nil)
    inboxVC.categoryNames = self.selectedCategories
    self.navigationController?.pushViewController(inboxVC, animated: true)
  }
  
  @IBAction func valueChangedStepper(_ sender: Any) {
    pageSizeLabel.text = "\(Int(stepper.value))"
  }
  
  @IBAction func valueChangedSegment(_ sender: Any) {
    
  }
  
  @IBAction func touchedFilterButton(_ sender: Any) {
    refreshFetchData()
  }
  
  func refreshFetchData() {
    var status: NetmeraInboxStatus = .all
    if segmentControl.selectedSegmentIndex == 0 {
      status = .read
    } else if segmentControl.selectedSegmentIndex == 1 {
      status = .unread
    } else if segmentControl.selectedSegmentIndex == 2 {
      status = .deleted
    }
    fetchCategory(pageSize: Int(stepper.value), status: status)
  }
  
  func fetchCategory(pageSize: Int, status: NetmeraInboxStatus) {
    let filter = NetmeraInboxCategoryFilter()
    filter.status = status
    filter.pageSize = Int32(pageSize)
    filter.shouldIncludeExpiredObjects = true
    
    Netmera.fetchInboxCategory(using: filter) { (inbox, error) in
      print("fetchCategory: \(inbox)")
      self.inboxCategory = inbox
      self.tableView.reloadData()
    }
  }
  
  @IBAction func fetchNextPage(_ sender: Any) {
    if self.inboxCategory?.hasNextPage ?? false {
      self.inboxCategory?.fetchNextPage(completionBlock: { (error) in
        self.tableView.reloadData()
      })
    }
  }
}

@available(iOS 9.0, *)
extension InboxCategoryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inboxCategory?.objects.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: InboxCategoryTableViewCell = tableView.dequeueReusableCell(type: InboxCategoryTableViewCell.self, indexPath: indexPath)
    if let inboxCategoryObject = inboxCategory?.objects[indexPath.row] as? NetmeraInboxCategoryObject {
      
      cell.config(inboxCategoryObject)
      if self.selectedCategories.contains(inboxCategoryObject.categoryName) {
        cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
      } else {
        cell.backgroundColor = .white
      }
    }

    return cell
  }

}

@available(iOS 9.0, *)
extension InboxCategoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let object = (inboxCategory?.objects[indexPath.row] as? NetmeraInboxCategoryObject)?.lastMessage {
      Netmera.handle(object)
    }
    tableView.deselectRow(at: indexPath, animated: true)
    
    if let inboxCategoryObject = inboxCategory?.objects[indexPath.row] as? NetmeraInboxCategoryObject {
      if self.selectedCategories.contains(inboxCategoryObject.categoryName) {
        if let index = self.selectedCategories.firstIndex(of: inboxCategoryObject.categoryName) {
          self.selectedCategories.remove(at: index)
        }
      } else {
        self.selectedCategories.append(inboxCategoryObject.categoryName)
      }
    }
    self.tableView.reloadData()
    
  }
  
}

