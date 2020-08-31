//
//  InboxViewController.swift
//  iNeo
//
//  Created by inomera on 30.07.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class InboxViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var pageSizeLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!

  var inbox: NetmeraInbox?

  var categoryNames: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerReusableCell(type: InboxTableViewCell.self)
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.dataSource = self
    tableView.delegate = self
    
    stepper.value = 2
    segmentControl.selectedSegmentIndex = 3
    pageSizeLabel.text = "\(Int(stepper.value))"
    
    refreshFetchData()
    
    if let categories = self.categoryNames {
      self.categoryLabel.text = "Categories: \(categories.joined(separator: ","))"
    } else {
      self.categoryLabel.text = nil
    }
    
  }
  
  @IBAction func valueChangedStepper(_ sender: Any) {
    pageSizeLabel.text = "\(Int(stepper.value))"
  }
  
  @IBAction func valueChangedSegment(_ sender: Any) {
    
  }
  
  @IBAction func touchedFilterButton(_ sender: Any) {
    refreshFetchData()
  }
  
  @IBAction func touchedReadAllButton(_ sender: Any) {
    self.setInboxStatus(status: .read)
  }
  
  @IBAction func touchedDeleteAllButton(_ sender: Any) {
    self.setInboxStatus(status: .deleted)
  }
  
  @IBAction func touchedUnReadAllButton(_ sender: Any) {
    self.setInboxStatus(status: .unread)
  }
  
  func setInboxStatus(status: NetmeraInboxStatus) {
    if let categories = self.categoryNames {
      Netmera.update(status, byCategories: categories, completion: { (error) in
//        if error != nil {
//          self.showAlert(title: "Hata", message: error.localizedDescription)
//        }
        self.refreshFetchData()
//        self.tableView.reloadData()
//        self.updateStatusCount()
      })
    } else {
      Netmera.update(status, forAllWithCompletion: { (error) in
//        if error != nil {
//          self.showAlert(title: "Hata", message: error.localizedDescription)
//        }
        self.refreshFetchData()
//        self.tableView.reloadData()
//        self.updateStatusCount()
      })
    }
  }
 
  func updateStatusCount() {
    statusLabel.text = "Read: \(String(describing: self.inbox?.count(for: NetmeraInboxStatus.read) ?? 0)) Unread: \(String(describing: self.inbox?.count(for: NetmeraInboxStatus.unread) ?? 0)) deleted: \(String(describing: self.inbox?.count(for: NetmeraInboxStatus.deleted) ?? 0))"
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
    fetchData(pageSize: Int(stepper.value), status: status)
  }
  
  func fetchData(pageSize: Int, status: NetmeraInboxStatus) {
    let filter = NetmeraInboxFilter()
    filter.status = status
    filter.pageSize = Int32(pageSize)
    filter.shouldIncludeExpiredObjects = true
    if self.categoryNames != nil {
      filter.categories = self.categoryNames
    }
    Netmera.fetchInbox(using: filter, completion: {( netmeraInbox: NetmeraInbox, netmeraError: Error?) -> Void in
      self.inbox = netmeraInbox
      self.tableView.reloadData()
      self.updateStatusCount()
    })
  }
  
  
  @IBAction func fetchNextPage(_ sender: Any) {
    if self.inbox?.hasNextPage ?? false {
      self.inbox?.fetchNextPage(completionBlock: { (error) in
        self.tableView.reloadData()
        self.updateStatusCount()
      })
    }
  }
  
}
@available(iOS 9.0, *)
extension InboxViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inbox?.objects.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: InboxTableViewCell = tableView.dequeueReusableCell(type: InboxTableViewCell.self, indexPath: indexPath)
    cell.config(inbox?.objects[indexPath.row] as? NetmeraPushObject)
    cell.delegate = self
    return cell
  }
}

@available(iOS 9.0, *)
extension InboxViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      if let object = inbox?.objects[indexPath.row] as? NetmeraPushObject {
        inbox?.update(NetmeraInboxStatus.deleted, for: [object], completion: { (error) in
          self.tableView.reloadData()
          self.updateStatusCount()
//          self.refreshFetchData()
        })
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let object = inbox?.objects[indexPath.row] as? NetmeraPushObject {
      Netmera.handle(object)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
//  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    if indexPath.row == (self.inbox?.objects.count ?? 0) - 1 {
//      if self.inbox?.hasNextPage ?? false {
//        self.inbox?.fetchNextPage(completionBlock: { (error) in
//          self.tableView.reloadData()
//        })
//      } else {
//        print("inbox category has not next page")
//      }
//    }
//  }
}
@available(iOS 9.0, *)
extension InboxViewController: InboxTableViewCellDelegate {
  func touchedCheckButton(_ cell: InboxTableViewCell) {
    if let indexPath = tableView.indexPath(for: cell),
      let object = inbox?.objects[indexPath.row] as? NetmeraPushObject {
      let status: NetmeraInboxStatus = object.inboxStatus == .read ? .unread : .read
      inbox?.update(status, for: [object], completion: { (error) in
        self.tableView.reloadData()
        self.updateStatusCount()
//        self.refreshFetchData()
      })
    }
    
  }
}

