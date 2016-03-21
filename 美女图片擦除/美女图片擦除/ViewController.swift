//
//  ViewController.swift
//  美女图片擦除
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hideImageView: UIImageView!
    @IBOutlet weak var topImageView: UIImageView!
    var curP = CGPoint.zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        view.addGestureRecognizer(pan)
        
    }
    
    func pan(pan: UIPanGestureRecognizer){
        if pan.state == .Began{
            // 获取当前点
             curP = pan.locationInView(view)
        }else if(pan.state == .Changed){
            let endP =  pan.locationInView(view)
            let rect = CGRect(x: curP.x, y: curP.y, width: endP.x - curP.x, height: endP.y - curP.y)
            
            // 开启上下文
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0);
            
            let ctx = UIGraphicsGetCurrentContext();
            
            // 控件的layer渲染上去
            topImageView.layer.renderInContext(ctx!)
            
            // 擦除图片
            CGContextClearRect(ctx, rect);
            
            // 生成一张图片
            let image = UIGraphicsGetImageFromCurrentImageContext();
            
            topImageView.image = image;
            
            // 关闭上下文
            UIGraphicsEndImageContext();
            
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

