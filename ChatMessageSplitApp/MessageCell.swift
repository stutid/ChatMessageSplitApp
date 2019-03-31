//
//  MessageCell.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var lblChat: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewChat.setCorners()
    }
    
    func setText(text: String) {
        lblChat.text = text
    }
}
