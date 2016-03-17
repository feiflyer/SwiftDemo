//
//  ShapeView.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/17.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ShapeView: UIView {

    
    override func drawRect(rect: CGRect) {
        
        绘制矩形()
        
        绘制圆弧()
        
        绘制扇形()
        
    }
    
    //方法名使用中文是因为懒写注释
    func 绘制矩形(){
        //绘制形状图形一搬使用贝赛尔曲线即可  (此方法也可以绘制圆形，圆角半径为正方形的宽的一半就是圆)
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 100, height: 100), cornerRadius: 50)
        
        path.stroke()
        
        //填充图形（必须时封闭的路径才能填充）
        path.fill()

    }
    
    func 绘制圆弧(){
        
        /**
         clockwise  是否是顺时针
         角度值使用的是弧度制
        */
        let path = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 60, startAngle: 0, endAngle: CGFloat(M_PI_2) , clockwise: true)
        path.stroke()
    }
    
    func 绘制扇形(){
        //方法提示：先绘制圆弧，链接圆心，封闭路径
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 200, y: 400), radius: 60, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2) , clockwise: true)
        path.addLineToPoint(CGPoint(x: 200, y: 400))
        path.closePath()
        path.stroke()
    }

}
