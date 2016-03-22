//
//  ViewController.swift
//  图片折叠
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 一张图片必须要通过两个控件展示，旋转的时候，只旋转上部分控件
    // 如何让一张完整的图片通过两个控件显示
    // 通过layer控制图片的显示内容
    // 如果快速把两个控件拼接成一个完整图片

    @IBOutlet weak var topView: UIImageView!
    @IBOutlet weak var bottomView: UIImageView!
    
    @IBOutlet weak var dragView: UIView!
    
    var gradientL: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
        topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
        topView.layer.anchorPoint = CGPointMake(0.5, 1);
        
        bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
        bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
        
        // 添加手势
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        dragView.userInteractionEnabled = true
        dragView.addGestureRecognizer(pan)
        
        // 渐变图层
        gradientL = CAGradientLayer()
        
        // 注意图层需要设置尺寸
        gradientL.frame = bottomView.bounds;
        
        gradientL.opacity = 0
        gradientL.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor];

        // 设置渐变颜色
        //    gradientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor];
        
        // 设置渐变定位点
        //    gradientL.locations = @[@0.1,@0.4,@0.5];
        
        // 设置渐变开始点，取值0~1
        //    gradientL.startPoint = CGPointMake(0, 1);
        
        bottomView.layer.addSublayer(gradientL)
       
    }

    
    func pan(pan: UIPanGestureRecognizer){
        // 获取偏移量
        let transP = pan.translationInView(dragView)
        
        // 旋转角度,往下逆时针旋转
        let angle = -transP.y / 200 * CGFloat(M_PI)
        
        var layerTransfrom = CATransform3DIdentity;
        
        
        // 增加旋转的立体感，近大远小,d：距离图层的距离
        layerTransfrom.m34 = -1 / 500.0;
        
        layerTransfrom = CATransform3DRotate(layerTransfrom, angle, 1, 0, 0);
        
        topView.layer.transform = layerTransfrom;
        
        // 设置阴影效果
        gradientL.opacity = Float(transP.y) / Float(200);
        
        if (pan.state == .Ended) { // 反弹
            
            // 弹簧效果的动画
            // SpringWithDamping:弹性系数,越小，弹簧效果越明显
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .TransitionCurlDown, animations: { [weak self]() -> Void in
                self?.topView.layer.transform = CATransform3DIdentity;
                }, completion: nil)
        }
        
    }

}
