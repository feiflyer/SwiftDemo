//
//  ProgressView.swift
//  圆形下载进度条
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var progress: CGFloat = 0 {
        didSet{
            
            //drawRect(self.bounds)
            // 重绘，系统会先创建与view相关联的上下文，然后再调用drawRect
            setNeedsDisplay()
        }
    }
    
    //这个方法不能手动调用，只能有系统调用 ，因为手动调用该方法无法创建图形上下文
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        let radius = rect.size.width < rect.size.height ? rect.size.width / 2 : rect.size.height / 2
        let angle = CGFloat(-M_PI_2) + progress * CGFloat(M_PI) * 2;

        let path = UIBezierPath(arcCenter: center, radius: radius - 2, startAngle: CGFloat(-M_PI_2), endAngle: angle, clockwise: true)
        path.stroke()
        
    }
}
