//
//  ViewController.swift
//  时钟
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

// 一秒钟秒针转6°
let perSecondA:CGFloat = 6

// 一分钟分针转6°
let  perMinuteA:CGFloat = 6


// 一小时时针转30°
let perHourA:CGFloat = 30

// 每分钟时针转多少度
let perMinuteHourA:CGFloat = 0.5

class ViewController: UIViewController {

    @IBOutlet weak var timeView: UIImageView!
    
    var clockWH: CGFloat = 0
    var secondPinLayer: CALayer!
    var minutePinLayer: CALayer!
    var hourPinLayer: CALayer!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockWH = timeView.bounds.size.width
     
        
        
        addHourPin()
        
        addMinutePin()
        
        addSecondPin()
        
        // 添加定时器
       timer =  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeChange", userInfo: nil, repeats: true)
        
        timeChange()
        
    }
    
    deinit{
        timer.invalidate()
        timer = nil
    }
    
       //添加秒针
    func addSecondPin(){
        secondPinLayer = CALayer()
        
        secondPinLayer.backgroundColor = UIColor.redColor().CGColor
        // 设置锚点
        secondPinLayer.anchorPoint = CGPointMake(0.5, 1);
        
        secondPinLayer.position = CGPointMake(clockWH * 0.5, clockWH * 0.5);
        
        secondPinLayer.bounds = CGRectMake(0, 0, 1, clockWH * 0.5 - 20);
        
        timeView.layer.addSublayer(secondPinLayer)
        
    }
    
    //添加分针
    func addMinutePin(){
        
        minutePinLayer = CALayer()
        
        minutePinLayer.backgroundColor = UIColor.blackColor().CGColor
        
        // 设置锚点
        minutePinLayer.anchorPoint = CGPointMake(0.5, 1);
        
        minutePinLayer.position = CGPointMake(clockWH * 0.5, clockWH * 0.5);
        
        minutePinLayer.bounds = CGRectMake(0, 0, 4, clockWH * 0.5 - 20);
        
        minutePinLayer.cornerRadius = 4;
        
        
        timeView.layer.addSublayer(minutePinLayer)
        
    }
    
    //添加时针
    func addHourPin(){
        hourPinLayer = CALayer()
        
        hourPinLayer.backgroundColor = UIColor.blackColor().CGColor
        
        // 设置锚点
        hourPinLayer.anchorPoint = CGPointMake(0.5, 1);
        
        hourPinLayer.position = CGPointMake(clockWH * 0.5, clockWH * 0.5);
        
        hourPinLayer.bounds = CGRectMake(0, 0, 4, clockWH * 0.5 - 40);
        
        hourPinLayer.cornerRadius = 4;
        
        
       timeView.layer.addSublayer(hourPinLayer)
    }
    
    func timeChange(){
        // 获取当前的系统的时间
        
        // 获取当前日历对象
        let calendar = NSCalendar.currentCalendar()
        
        // 获取日期的组件：年月日小时分秒
        // components:需要获取的日期组件
        // fromDate：获取哪个日期的组件
        // 经验：以后枚举中有移位运算符，通常一般可以使用并运算（|）
        let  hourComponents = calendar.components(.Hour, fromDate: NSDate())
        let  minuteComponents = calendar.components(.Minute, fromDate: NSDate())
        let  secondComponents = calendar.components(.Second, fromDate: NSDate())
        
                       // 获取秒
        let second:CGFloat = CGFloat(secondComponents.second)
        
        // 获取分
        let minute = CGFloat(minuteComponents.minute)
        
        // 获取小时
        let hour = CGFloat(hourComponents.hour)
        
        // 计算秒针转多少度
        let secondA = second * perSecondA;
        
        // 计算分针转多少度
        let minuteA = minute * perMinuteA;
        
        // 计算时针转多少度
        let hourA = hour * perHourA + minute * perMinuteHourA;
        
        // 旋转秒针
        secondPinLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
        
        // 旋转分针
        minutePinLayer.transform = CATransform3DMakeRotation(angle2radion(minuteA), 0, 0, 1);
        
        // 旋转小时
        hourPinLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);

    }
    
    func angle2radion(angle: CGFloat) -> CGFloat{
        return angle / 180 * CGFloat(M_PI)
    }

}

