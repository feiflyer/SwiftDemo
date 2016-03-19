//
//  DrawView.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class DrawView: UIView {

    override func drawRect(rect: CGRect) {
      
      drawImage(rect)
        
    }
    
   func drawText(){
    //绘制文字
    let str = "angangkakamhka啊嘎嘎噶这事很差很长的文字。。。。。。。让你看看" as NSString
    
    var textDict = [String: AnyObject]()
    // 设置文字颜色
    textDict[NSForegroundColorAttributeName] = UIColor.redColor()
    
    // 设置文字字体
    textDict[NSFontAttributeName] = UIFont.systemFontOfSize(30)
    
    // 设置文字的空心颜色和宽度
    
    textDict[NSStrokeWidthAttributeName] = 3
    
    textDict[NSStrokeColorAttributeName] = UIColor.yellowColor()
    
    // 创建阴影对象
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.grayColor()
    shadow.shadowOffset = CGSizeMake(4, 4);
    shadow.shadowBlurRadius = 3;
    textDict[NSShadowAttributeName] = shadow;
    //drawAtPoint不会自动换行
    // str.drawAtPoint(CGPoint.zero, withAttributes: textDict)
    str.drawInRect(CGRect(x: 10, y: 10, width: 100, height: 100), withAttributes: textDict)
    
    
    }
    
    //绘制图片
    func drawImage(rect: CGRect){
        
    let image = UIImage(named: "CTO")
        //平铺绘制
   // image?.drawAsPatternInRect(rect)
        image?.drawInRect(rect)
        
    }
    
}
