//
//  InboxViewController.swift
//  NetmeraSample
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import Netmera

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageSizeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var segmentControl: UISegmentedControl!
        
    var inbox: NetmeraInbox?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(InboxTableViewCell.self, forCellReuseIdentifier: String(describing: InboxTableViewCell.self))

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        self.tableView.dataSource = self
        
        stepper.value = 2
        segmentControl.selectedSegmentIndex = 3
        pageSizeLabel.text = "\(Int(stepper.value))"
        
        refreshFetchData()
        
        self.title = "Inbox"
        tableView.separatorStyle = .none
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
        fetchData(pageSize: Int(stepper.value), status: status)
    }
    
    func fetchData(pageSize: Int, status: NetmeraInboxStatus) {
        let filter = NetmeraInboxFilter()
        filter.status = status
        filter.pageSize = Int32(pageSize)
        filter.shouldIncludeExpiredObjects = true
        
        Netmera.fetchInbox(using: filter, completion: {( netmeraInbox: NetmeraInbox, netmeraError: Error?) -> Void in
            if netmeraError != nil {
                print("error")
            }
            self.inbox = netmeraInbox
            self.tableView.reloadData()
        })
    }
    
    @IBAction func fetchNextPage(_ sender: Any) {
        if self.inbox?.hasNextPage ?? false {
            self.inbox?.fetchNextPage(completionBlock: { (error) in
                self.tableView.reloadData()
            })
        }
    }
}

extension InboxViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inbox?.objects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InboxTableViewCell.self), for: indexPath) as! InboxTableViewCell
        if let objects = inbox?.objects as? [NetmeraPushObject] {
            cell.configure(item: objects[indexPath.row])
        }
        return cell
    }
}
extension InboxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let object = inbox?.objects[indexPath.row] as? NetmeraPushObject {
                inbox?.update(NetmeraInboxStatus.deleted, for: [object], completion: { (error) in
                    if error != nil {
                        print("error \(error.localizedDescription)")
                    }
                    self.refreshFetchData()
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
}

extension InboxViewController: InboxTableViewCellDelegate {
    func touchedCheckButton(_ cell: InboxTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
            let object = inbox?.objects[indexPath.row] as? NetmeraPushObject {
            inbox?.update(NetmeraInboxStatus.read, for: [object], completion: { (error) in
                if error != nil {
                    print("error \(error.localizedDescription)")
                }
                self.refreshFetchData()
            })
        }
        
    }
}









