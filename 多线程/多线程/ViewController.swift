//
//  ViewController.swift
//  多线程
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gcd()
    }
    
    func gcd(){
        
        //并发队列
        let queque = dispatch_queue_create("队列名称", DISPATCH_QUEUE_CONCURRENT)
        //串行队列DISPATCH_QUEUE_SERIAL
        //let queque = dispatch_queue_create("队列名称", DISPATCH_QUEUE_CONCURRENT)
        dispatch_async(queque) { () -> Void in
            print("------在这里执行子线程代码")
            print(NSThread.currentThread())
        }
    }


}

