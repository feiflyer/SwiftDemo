//
//  ViewController.swift
//  抽屉效果
//
//  Created by 梁传飞 on 16/3/15.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

/**
*假设滑动菜单规则：
* x轴最多偏移屏幕宽度的4/3
  y轴最多偏移屏幕高度的10／1
*/

import UIKit

 let screenH = UIScreen.mainScreen().bounds.size.height
 let screenW = UIScreen.mainScreen().bounds.width
 let MAX_OFFSET_X = screenW * 3 / 5
 let MAX_OFFSET_Y = screenH / 10

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(leftView)
        view.addSubview(rightVew)
        view.addSubview(mainView)
        
        addGesture()
        
        //利用kvo监听mainView的frame值的变化
        //这里使用kvo主要是为了学习kvo的知识点，使用kvo会消耗一定的性能，本例有可以不使用kvo的更好方法
        
        mainView.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    
    func addGesture(){
        let gesture = UIPanGestureRecognizer(target: self, action: "panChange:")
        view.addGestureRecognizer(gesture)
    }
    
    //selector
    func panChange(gesture: UIPanGestureRecognizer){
        // 获取手势的移动的位置
        let transP = gesture.translationInView(view)
        
        // 获取X轴的偏移量
        let offsetX = transP.x;
          // 修改mainV的Frame
        mainView.frame = getFrame(offsetX)
        // 复位
        gesture.setTranslation(CGPoint.zero, inView: view)
        
        //手势结束时定位
        if (gesture.state == .Ended){
            
            var target:CGFloat = 0;
            // 1.判断下main.x > screenW * 0.5,定位到右边
            if (mainView.frame.origin.x > screenW * 0.5) {
                // 定位到右边
                target = MAX_OFFSET_X;
            }else if (CGRectGetMaxX(mainView.frame) < screenW * 0.5){
                // 2.判断下max(main.x) < screenW * 0.5
                target = -MAX_OFFSET_X+70;
            }
            
            // 获取x轴偏移量
            let lockOffsetX = target - mainView.frame.origin.x;
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                 self.mainView.frame = target == 0 ? self.view.bounds: self.getFrame(lockOffsetX)
            })
        }
    }
    
    //根据x方向的位移计算出新的frame
    func getFrame(offSetX: CGFloat) -> CGRect{
        // 获取上一次的frame
        var frame = mainView.frame;
    
        
        // X轴每平移一点，Y轴需要移动
        let offsetY = offSetX * MAX_OFFSET_Y / screenW;
        
        // 获取上一次的高度
        let preH = frame.size.height;
        
        // 获取上一次的宽度
        let preW = frame.size.width;
        
        // 获取当前的高度
        var curH = preH - 2 * offsetY;
        if (frame.origin.x < 0) { // 往左移动
            curH = preH + 2 * offsetY;
        }
        
        // 获取尺寸的缩放比例
        let scale = curH / preH;
        
        // 获取当前的宽度
        let curW = preW * scale;
        
        // 更改frame
        
        // 获取当前X
        frame.origin.x += offSetX;
        
        // 获取当前Y
        let y = (screenH - curH) / 2;
        
        frame.origin.y = y;
        
        frame.size.height = curH;
        
        frame.size.width = curW;
        
        return frame;

    }
    
    //只要监听的属性改变，便会调用该方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            //往左边滑则隐藏leftView
            if mainView.frame.origin.x < 0{
                leftView.hidden = true
                rightVew.hidden = false
            }else{
                //往右边滑则隐藏rightView
                rightVew.hidden = true
                leftView.hidden = false
            }
        }
    }
    
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }

   // # mark 懒加载
    
    private  lazy var leftView: UIView = {
       let left = UIView(frame: self.view.bounds)
        left.backgroundColor = UIColor.yellowColor()
        return left
    }()
    
    private lazy var rightVew: UIView = {
    let right = UIView(frame: self.view.bounds)
    right.backgroundColor = UIColor.blueColor()
    return right
    }()
    
    private lazy var mainView: UIView = {
        let main = UIView(frame: self.view.bounds)
        main.backgroundColor = UIColor.redColor()
        return main
    }()
    

}

