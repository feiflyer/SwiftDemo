//
//  ViewController.swift
//  抽屉效果
//
//  Created by 梁传飞 on 16/3/15.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(leftView)
        view.addSubview(rightVew)
        view.addSubview(mainView)
        
        addGesture()
        
        //利用kvo监听mainView的frame值的变化
        
        mainView.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    
    func addGesture(){
        let gesture = UIPanGestureRecognizer(target: self, action: "panChange:")
        view.addGestureRecognizer(gesture)
    }
    
    func panChange(gesture: UIPanGestureRecognizer){
        // 获取手势的移动的位置
        let transP = gesture.translationInView(view)
        
        // 获取X轴的偏移量
        let offsetX = transP.x;
          // 修改mainV的Frame
        var originFrame = mainView.frame
        originFrame.origin.x += offsetX
        mainView.frame = originFrame
        // 复位
        gesture.setTranslation(CGPoint.zero, inView: view)
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

