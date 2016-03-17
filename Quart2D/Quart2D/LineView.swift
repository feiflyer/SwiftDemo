//
//  LineView.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/16.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class LineView: UIView {


    override func drawRect(rect: CGRect) {
      
        drawBase()
        
        drawSimple()
        
       drawBezierPath()
        
        绘制曲线()
    }
    
    
    //绘制的基本步骤（底层原理）
    func drawBase(){
        // 1、获取上下文
        let context = UIGraphicsGetCurrentContext()
        // 2、描述路径
        let path = CGPathCreateMutable()
        //设置路径起点
        CGPathMoveToPoint(path, nil, 0, 10)
        CGPathAddLineToPoint(path, nil, 200, 200)
         CGPathAddLineToPoint(path, nil, 350, 400)
        //设置颜色
        UIColor.redColor().setStroke()
        //设置线宽
        CGContextSetLineWidth(context, 10)
        //设置链接样式
        CGContextSetLineJoin(context, .Round)
        //设置首末短样式
        CGContextSetLineCap(context, .Round)
        // 3、把路径添加到上下文
        CGContextAddPath(context, path)
        // 4、渲染
        CGContextStrokePath(context)
    }
    
    //简化的绘制（使用CGContext内部封装好的路径）
    //其实使用这中方法绘制，系统内部时通过drawBase（）中的步骤实现的
    func drawSimple(){
        let context = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, 60, 60)
        CGContextAddLineToPoint(context, 300, 300)
        //设置颜色
        UIColor.yellowColor().setStroke()
        CGContextStrokePath(context)
    }
    
    //使用贝赛尔路径（底层也是使用了drawBase()中的步骤）
    func drawBezierPath(){
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 80))
        //设置颜色
        UIColor.blueColor().setStroke()
        path.addLineToPoint(CGPoint(x: 400, y: 400))
        //绘制路径
        path.stroke()
    }
    
    //绘制曲线
    func 绘制曲线() {
        let context = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, 30, 30)
        CGContextAddQuadCurveToPoint(context, 100, 300, 200, 400)
        CGContextStrokePath(context)
    }


}
