//
//  ViewController.swift
//  音量震动（图层复制）
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // CAReplicatorLayer复制图层，可以把图层里面所有子层复制
        // 创建复制图层
        let repL = CAReplicatorLayer()
        
        repL.frame = contentView.bounds;
        
        contentView.layer.addSublayer(repL)
        
        let layer = CALayer()
        
        layer.anchorPoint = CGPointMake(0.5, 1);
        layer.position = CGPointMake(15, contentView.bounds.size.height);
        layer.bounds = CGRectMake(0, 0, 30, 150);
        
        layer.backgroundColor = UIColor.whiteColor().CGColor
        
        repL.addSublayer(layer)
        
        let anim = CABasicAnimation()
        
        anim.keyPath = "transform.scale.y"
        
        anim.toValue = 0.1;
        
        anim.duration = 0.5;
        
        anim.repeatCount = MAXFLOAT;
        
        // 设置动画反转
        anim.autoreverses = true;
        
        
        layer.addAnimation(anim, forKey: nil)
        
        
        // 复制层中子层总数
        // instanceCount：表示复制层里面有多少个子层，包括原始层
        repL.instanceCount = 6;
        
        // 设置复制子层偏移量，不包括原始层,相对于原始层x偏移
        repL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
        
        // 设置复制层动画延迟时间
        repL.instanceDelay = 0.1;
        
        // 如果设置了原始层背景色，就不需要设置这个属性
        repL.instanceColor = UIColor.greenColor().CGColor
        
        //颜色渐变
        repL.instanceGreenOffset = -0.3;

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

