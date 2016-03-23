//
//  ViewController.swift
//  RunLoop
//
//  Created by 梁传飞 on 16/3/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    func runLoopModel(){
        //这种方式创建的定时器会自动调用方法，并且默认的运行模式是NSDefaultRunLoopMode
        //当UIScrollerView在滚动的时候主线程的RunLoop会切换到UITrackingRunLoopMode模式，所以定时器的任务会停止执行
        //        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "run", userInfo: nil, repeats: true)
        
        let timer = NSTimer(timeInterval: 1, target: self, selector: "run", userInfo: nil, repeats: true)
        
        let loop = NSRunLoop.currentRunLoop()
        //把timer添加到RunLoop中去，否则不会自动调用方法
        //  loop.addTimer(timer, forMode: NSDefaultRunLoopMode)
        //NSRunLoopCommonModes  表示timer可以运行在标记为NSRunLoopCommonModes 的模式下
        //标记为NSRunLoopCommonModes的模式有：UITrackingRunLoopMode和kCFRunLoopDefaultMode
        loop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    
    func run(){
        print("-----我在执行")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

