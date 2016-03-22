//
//  ReversesView.swift
//  倒影
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ReversesView: UIView {

    
    // 重写该方法，设置控件主层的类型
    override class func layerClass() -> AnyClass{
        return CAReplicatorLayer.self
    }

}
