//
//  ViewController.swift
//  活动指示器
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let repL = CAReplicatorLayer()
        
        repL.frame = contenView.bounds;
        
        contenView.layer.addSublayer(repL)
        
        
        let layer = CALayer()
        
        layer.transform = CATransform3DMakeScale(0, 0, 0)
        
        layer.position = CGPointMake(contenView.bounds.size.width / 2, 20);
        
        layer.bounds = CGRectMake(0, 0, 10, 10)
        
        layer.backgroundColor = UIColor.greenColor().CGColor;
        
        
        repL.addSublayer(layer)
        
        // 设置缩放动画
        let anim = CABasicAnimation()
        
        anim.keyPath = "transform.scale"
        
        anim.fromValue = 1;
        
        anim.toValue = 0;
        
        anim.repeatCount = MAXFLOAT;
        
        anim.duration = 1;
        
        layer.addAnimation(anim, forKey: nil)
        
        
        let count = 20;
        
        let angle = CGFloat(M_PI) * 2 / CGFloat(count)
        
        // 设置子层总数
        repL.instanceCount = count
        
        repL.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
        
        repL.instanceDelay = 0.1
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



