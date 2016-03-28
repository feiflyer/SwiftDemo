//
//  ChatTableCell.swift
//  聊天布局
//
//  Created by 梁传飞 on 16/3/28.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ChatTableCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var fromHeader: UIImageView!

    @IBOutlet weak var fromMessage: UIButton!
    
    var msg: ChatData?{
    didSet{
      time.text = msg?.time
      fromMessage.setTitle(msg?.text, forState: .Normal)
     }
    }
}
