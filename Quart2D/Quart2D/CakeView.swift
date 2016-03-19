//
//  CakeView.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//  饼状图

import UIKit

class CakeView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        print("---\(rect)")
        let array = [24 , 36 ,40]
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        var startAngle: CGFloat = 0
        var angle: CGFloat = 0
        var endAngle:CGFloat = 0
        let radius = rect.size.width < rect.size.height ? rect.size.width / 2 : rect.size.height/2
       for proportion in array {
            startAngle = endAngle
            angle = CGFloat(proportion) / 100 * CGFloat(M_PI) * 2
            endAngle = startAngle + angle
            let path = UIBezierPath(arcCenter: center, radius: radius - 50, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLineToPoint(center)
            UIColor.randomColor().set()
            path.fill()
       }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        setNeedsDisplay()
    }
    

}
