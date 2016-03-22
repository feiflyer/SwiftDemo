//
//  ViewController.swift
//  CALayer
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.layer.shadowColor = UIColor.yellowColor().CGColor
        redView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        // 创建图层
        let layer = CALayer()
        
        layer.frame = CGRectMake(50, 50, 200, 200);
        
        layer.backgroundColor = UIColor.yellowColor().CGColor;
        
        // 设置图层内容
        layer.contents = UIImage(named: "阿狸头像")?.CGImage
        
        view.layer.addSublayer(layer)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 图层形变
        
        // 缩放
        UIView.animateWithDuration(1) { () -> Void in
            
//                    self.redView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1, 1, 0);
            
                   self.redView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
            
            // 快速进行图层缩放,KVC
            // x,y同时缩放0.5
            //注意一定是用forKeyPath 而不是forKey
            
            self.redView.layer.setValue(0.5, forKeyPath: "transform.scale")
            self.redView.layer.setValue(M_PI, forKeyPath: "transform.rotation")
        }
    }
    
}

