//
//  ViewController.swift
//  图片截取
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageVIew: UIImageView!
    var startPoint: CGPoint?
    //懒加载
    private lazy var clipView: UIView = {
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.blackColor()
        alphaView.alpha = 0.5
        return alphaView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "火影")
        imageVIew.image = image
        
        let gesture = UIPanGestureRecognizer(target: self, action: "pan:")
        imageVIew.userInteractionEnabled = true
        imageVIew.addGestureRecognizer(gesture)
    }
    
    func pan(gesture: UIPanGestureRecognizer){
        
        var endP = CGPoint.zero
        
        if gesture.state == .Began{
            //开始触摸的时候
            startPoint = gesture.locationInView(imageVIew)
            clipView.frame = CGRect.zero
            view.addSubview(clipView)
        }else if(gesture.state == .Changed){
            //一直拖动的时候
            // 获取结束点
            endP = gesture.locationInView(imageVIew)
            
            let w = endP.x - startPoint!.x;
            let h = endP.y - startPoint!.y;
            
            // 获取截取范围
            let clipRect = CGRectMake(startPoint!.x, startPoint!.y, w, h);

            // 生成截屏的view
            self.clipView.frame = clipRect;

        }else if(gesture.state == .Ended){
            // 图片裁剪，生成一张新的图片
            
            // 开启上下文
            // 如果不透明，默认超出裁剪区域会变成黑色，通常都是透明
            UIGraphicsBeginImageContextWithOptions(imageVIew.bounds.size, false, 0);
            
            // 设置裁剪区域
            let path = UIBezierPath(rect: clipView.frame);
            
            path.addClip()
            
            // 获取上下文
            let ctx = UIGraphicsGetCurrentContext();
            
            // 把控件上的内容渲染到上下文
            imageVIew.layer.renderInContext(ctx!)
            
            
            // 生成一张新的图片
            imageVIew.image = UIGraphicsGetImageFromCurrentImageContext();
            
            
            // 关闭上下文
            UIGraphicsEndImageContext();
            
            
            // 先移除
            clipView.removeFromSuperview()
            // 截取的view设置为nil
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

