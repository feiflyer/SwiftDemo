//
//  ViewController.swift
//  RunLoop
//
//  Created by 梁传飞 on 16/3/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var foreverThread: NSThread?
    //gcd定时器要保持强引用
    var timer: dispatch_source_t?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foreverThread =  NSThread(target: self, selector: "foreverThreadTest", object: nil)
        foreverThread?.start()
        
        gcdTimer()
        
       // runLoopObserver()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       // updateUI()
        performSelector("test", onThread: foreverThread!, withObject: nil, waitUntilDone: false)

    }
    
    func runLoopTimerModel(){
        //这种方式创建的定时器会自动调用方法（默认添加到当前RunLoop去），并且默认的运行模式是NSDefaultRunLoopMode
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
    
    
    func runLoopObserver(){
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.AllActivities.rawValue, true, 0) { (_, _) -> Void in
            print("----observer回调")
        }
        
        let sleepObserver = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.BeforeWaiting.rawValue, true, 0) { (_, _) -> Void in
            print("----准备睡眠")
        }
        
        // 添加观察者：监听RunLoop的状态
         CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, NSRunLoopCommonModes);
         CFRunLoopAddObserver(CFRunLoopGetCurrent(), sleepObserver, kCFRunLoopDefaultMode);
        
        // 释放Observer
       //CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, NSRunLoopCommonModes)
       // CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), sleepObserver, kCFRunLoopDefaultMode)
    }
    
    
    func run(){
        print("-----我在执行")
    }
    
    //使用特定模式更新ui
   func updateUI(){
    //在RunLoop特定模式下设定图片
    imageView.performSelector("setImage:", withObject: UIImage(named: "minion"), afterDelay: 3, inModes:
        [kCFRunLoopDefaultMode as String])
    }
    
    //使用RunLoop使线程不死
    func foreverThreadTest(){
       
        //如果要做到让一条线程不死，一定要有两步，第一望线程的RunLoop的model中添加东西，启动线程的RunLoop
        //如果RunLoop要启动，则已定要往Loop里面的模式添加东西，不然无法启动
        let runLoop =  NSRunLoop.currentRunLoop()
        runLoop.addPort(NSPort(), forMode: NSDefaultRunLoopMode)
        print("------不死线程启动啦")
        runLoop.run()
        
        //不推荐这种，比较消耗性能
//        while(true){
//            runLoop.run()
//        }
        
    }
    
    
    func test(){
        print("----test----")
    }
    
    //gcd定时器
    func gcdTimer(){
        
        // 2 秒
//        let when = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(2) * NSEC_PER_SEC));
//        
//            dispatch_after(when, dispatch_get_main_queue()) { () -> Void in
//            print("------gcd定时器")
//        }
        
        // 获得队列
        //    let queue = dispatch_get_global_queue(0, 0);
        let queue = dispatch_get_main_queue();
        
        // 创建一个定时器(dispatch_source_t本质还是个OC对象)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
        // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
        // 何时开始执行第一个任务
        // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
        let startTimer = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC));
        let interval = (UInt64)(1 * NSEC_PER_SEC);
        dispatch_source_set_timer(timer!, startTimer, interval, 0);
        
        // 设置回调
        dispatch_source_set_event_handler(timer!) { () -> Void in
             print("------gcd定时器")
        }
        // 启动定时器
        dispatch_resume(timer!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

