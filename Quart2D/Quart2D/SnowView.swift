//
//  SnowView.swift
//  Quart2D
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class SnowView: UIView {

    var snowY: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        // 修改雪花y值
        let image = UIImage(named: "雪花")
        
        image?.drawAtPoint(CGPointMake(50, snowY))
        
        snowY += 10;
        
        if (snowY > rect.size.height) {
            snowY = 0;
        }
    }
    
    //NSTimer很少用于绘图，因为调度优先级比较低，并不会准时调用
    override func awakeFromNib() {
        // 创建定时器
        //  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        // CADisplayLink:每次屏幕刷新的时候就会调用，屏幕一般一秒刷新60次
        let link = CADisplayLink(target: self, selector: "timeChange")
        // 添加主运行循环
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)

    }
    
    func timeChange(){
        //可以在这里编写调整雪花下落速度的代码
        setNeedsDisplay()
    }
    
}


