//
//  DragView.swift
//  事件处理
//
//  Created by 梁传飞 on 16/3/15.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class DragView: UIView {
    

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("-----touches\(touches.count)")

        //获取UITouch
        let uitouch = touches.first
        //获取上一个触摸点
        let previousPoint = uitouch!.precisePreviousLocationInView(self)
          print("-----previousPoint\(previousPoint)")
        //获取当前触摸点
        let currentPoint = uitouch!.locationInView(self)
         print("-----currentPoint\(currentPoint)")
        
      self.transform = CGAffineTransformTranslate(transform, currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y)
        print("-----move")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("---begean")
    }

}
