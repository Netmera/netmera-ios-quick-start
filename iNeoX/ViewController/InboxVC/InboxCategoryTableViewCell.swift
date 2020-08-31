//
//  InboxCategoryTableViewCell.swift
//  iNeo
//
//  Created by inomera on 20.02.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit

class InboxCategoryTableViewCell: UITableViewCell, CellProtocol{

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var captionLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func config(_ data: NetmeraInboxCategoryObject?) {
    titleLabel.text = data?.categoryName
    subtitleLabel.text = data?.lastMessage.alert.title
    captionLabel.text = data?.lastMessage.alert.subtitle
    let dateformatter = DateFormatter()
    dateformatter.dateStyle = .full
    dateformatter.timeStyle = .full
    dateLabel.text = dateformatter.string(from: data?.creationDate ?? Date())
    var statusText: String = ""
    if let item = data?.status {
      statusText.append("Read: \(item.readCount) Unread: \(item.unreadCount) deleted: \(item.deletedCount)")
    }
    bodyLabel.text = statusText
  }
  
}
