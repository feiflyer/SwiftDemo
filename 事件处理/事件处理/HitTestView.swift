//
//  HitTestView.swift
//  事件处理
//
//  Created by 梁传飞 on 16/3/15.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class HitTestView: UIView {

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        //在这里模拟hitTest的底层实现
        //判断当前控件能否接受事件
        if (!userInteractionEnabled || alpha <= 0.01 || hidden){
            return nil
        }
        
        //判断点在不在当前控件上
        if !pointInside(point, withEvent: event){
            return nil
        }
        
        //从后往前遍历子控件，查找更加适合的子控件
        
        let count = self.subviews.count
        
        for var i = count - 1 ; i >= 0 ; i-- {
            
          let childView = subviews[i]
            //把当前控件上的坐标转换成子控件上的坐标
          let childPoint = convertPoint(point, toView: childView)
            
            if let tagView = childView.hitTest(childPoint, withEvent: event){
                return tagView
            }
        }
        
        //没有比自己更合适的view
        return self
    }

}
