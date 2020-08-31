//
//  InboxTableViewCell.swift
//  iNeo
//
//  Created by inomera on 30.07.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

import UIKit

protocol InboxTableViewCellDelegate: class {
  @available(iOS 9.0, *)
  func touchedCheckButton(_ cell: InboxTableViewCell)
}

@available(iOS 9.0, *)
class InboxTableViewCell: UITableViewCell, CellProtocol {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var checkbutton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var actionStackView: UIStackView!

  weak var pushObject: NetmeraPushObject?
  
  weak var delegate: InboxTableViewCellDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func config(_ data: NetmeraPushObject?) {
    titleLabel.text = data?.alert.title
    subtitleLabel.text = data?.alert.subtitle
    bodyLabel.text = data?.alert.body
    checkbutton.isSelected = data?.inboxStatus == NetmeraInboxStatus.read
    
    actionStackView.arrangedSubviews.forEach { (item) in
      item.removeFromSuperview()
      actionStackView.removeArrangedSubview(item)
    }
    self.pushObject = data
    data?.interactiveActions?.enumerated().forEach({ (index, item) in
      let button = UIButton(type: .custom)
      button.setTitle(item.interactiveAction.title, for: .normal)
      button.layer.borderWidth = 1
      button.layer.borderColor = UIColor.red.cgColor
      button.setTitleColor(.red, for: .normal)
      button.backgroundColor = .white
      button.layer.cornerRadius = 16
      button.addTarget(self, action: #selector(touchedInteractiveButton(_:)), for: .touchUpInside)
      button.tag = index
      actionStackView.addArrangedSubview(button)
      
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    })
  }
  
  @IBAction func touchedCheckButton(_ sender: Any) {
    delegate?.touchedCheckButton(self)
  }
  
  @objc func touchedInteractiveButton(_ sender: Any) {
    let index = (sender as! UIButton).tag
    if let action = pushObject?.interactiveActions?[index], let pushObject = self.pushObject {
      Netmera.handleInteractiveAction(action, for: pushObject)
    }
  }
    
}
