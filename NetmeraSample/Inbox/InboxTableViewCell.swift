//
//  InboxTableViewCell.swift
//  NetmeraSample
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import Netmera

protocol InboxTableViewCellDelegate: class {
    func touchedCheckButton(_ cell: InboxTableViewCell)
}

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    weak var delegate: InboxTableViewCellDelegate?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func configure(item: NetmeraPushObject){
        titleLabel.text = item.alert.title
        subtitleLabel.text = item.alert.subtitle
        bodyLabel.text = item.alert.body
        checkButton.isSelected = item.inboxStatus == NetmeraInboxStatus.read
    }
    
    @IBAction func touchedCheckButton(_ sender: Any) {
        delegate?.touchedCheckButton(self)
    }
}
