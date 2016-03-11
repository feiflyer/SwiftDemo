//
//  CustomLabel.swift
//  ScrollerNavigation
//
//  Created by 梁传飞 on 16/3/10.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    var scal: CGFloat = 0{
        didSet{
            transform = CGAffineTransformMakeScale(1 + scal * 0.3, 1 + scal * 0.3)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        font = UIFont.systemFontOfSize(15)
        textColor = UIColor.yellowColor()
        userInteractionEnabled = true
        textAlignment = .Center

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
