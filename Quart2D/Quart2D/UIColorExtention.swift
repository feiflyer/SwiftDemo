//
//  UIColorExtention.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit
extension UIColor{
    
    //随机颜色
    class func randomColor() -> UIColor{
        // 0 ~ 255 / 255
        let r = CGFloat(arc4random_uniform(256)) / 255
        let g = CGFloat(arc4random_uniform(256)) / 255
        let b = CGFloat(arc4random_uniform(256)) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
   
}
