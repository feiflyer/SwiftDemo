//
//  ViewController.swift
//  核心动画
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func baseAnimation(){
        
        let animation = CABasicAnimation()
        //keyPath智能时layer的属性
      //  animation.keyPath = "position"
         animation.keyPath = "transform.scale"
        animation.duration = 1
        
        //如果想要动画执行完毕之后不恢复原状，一下两句必须同时编写
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        animation.repeatCount = MAXFLOAT
        
        //animation.toValue = NSValue(CGPoint: CGPoint(x: 300, y: 300))
         animation.toValue = 0.5
        //这里也可以传key，如果animation已经设置可keyPath属性则可以传nil
        animationView.layer.addAnimation(animation, forKey: nil)
        
    }
    
    func keyFrameAnimation(){
        
        let keyFrameAnimation = CAKeyframeAnimation()
        
       // keyFrameAnimation.keyPath = "transform.rotation";
          keyFrameAnimation.keyPath = "position";
        //帧动画还可以绕着路径做动画
        keyFrameAnimation.path = UIBezierPath(ovalInRect: CGRect(x: 100, y: 100, width: 100, height: 100)).CGPath
        
     //   keyFrameAnimation.values = [M_1_PI , M_2_PI];
        
        keyFrameAnimation.repeatCount = MAXFLOAT;
        
      animationView.layer.addAnimation(keyFrameAnimation, forKey: nil)
        
    }
    
    //转场动画
    func transitionAnimation(){
        animationView.backgroundColor = UIColor.redColor();
        let animation = CATransition()
        //推送类型
        animation.type = kCATransitionFade
       // animation.type = kCATransitionMoveIn
        //出现方向
        animation.subtype = kCATransitionFromBottom
        animationView.layer.addAnimation(animation, forKey: nil)
    }
    
    //动画组
    func animationGroup(){
        
        let animation1 = CABasicAnimation()
        animation1.keyPath = "transform.scale"
        animation1.duration = 1
        animation1.toValue = 0.5
        
        
        
        let animation2 = CAKeyframeAnimation()
        
         animation2.keyPath = "transform.rotation";
         animation2.values = [M_1_PI , M_2_PI];
        
        animation2.repeatCount = MAXFLOAT;
        
        let group = CAAnimationGroup()
        group.animations = [animation1 , animation2]
        
        animationView.layer.addAnimation(group, forKey: nil)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       // baseAnimation()
      //  keyFrameAnimation()
        
      //  transitionAnimation()
        
        animationGroup()
    }


}

