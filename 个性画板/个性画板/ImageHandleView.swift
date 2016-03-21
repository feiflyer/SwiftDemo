//
//  ImageHandleView.swift
//  个性画板
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ImageHandleView: UIView , UIGestureRecognizerDelegate{

    var image:UIImage?{
        didSet{
            imageView.image = image
        }
    }
    
    var callBack: ((image: UIImage) -> Void)?
    
    private lazy var imageView: UIImageView = {
       let tempView = UIImageView(frame: self.bounds)
        tempView.userInteractionEnabled = true
        return tempView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addControlGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加手势
    func addControlGestureRecognizer(){
        // 添加拖动手势给ImageHandleView
        let panHandle = UIPanGestureRecognizer(target: self, action: "panHandle:")
        self.addGestureRecognizer(panHandle)
        
        // 平移
        let imagePan = UIPanGestureRecognizer(target: self, action: "imagePan:")
        imageView.addGestureRecognizer(imagePan)
        
        // 旋转
        let rotation = UIRotationGestureRecognizer(target: self, action: "rotation:")
        rotation.delegate = self;
        imageView.addGestureRecognizer(rotation)
        
        // 缩放
        let pinch = UIPinchGestureRecognizer(target: self, action: "pinch:")
        pinch.delegate = self;
        imageView.addGestureRecognizer(pinch)

        
        // 长按
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        imageView.addGestureRecognizer(longPress)

    }
    
    func panHandle(pan: UIPinchGestureRecognizer){
        
    }
    
    func imagePan(pan: UIPanGestureRecognizer){
        // 获取手指的偏移量
        let transP = pan.translationInView(imageView)
        
        // 设置UIImageView的形变
        imageView.transform = CGAffineTransformTranslate(imageView.transform, transP.x, transP.y);
        
        // 复位：只要想要相对于上一次就必须复位
        pan.setTranslation(CGPoint.zero, inView: imageView)
    }
    
    func rotation(rotation: UIRotationGestureRecognizer){
        imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
        rotation.rotation = 0;
    }
    
    func pinch(pinch: UIPinchGestureRecognizer){
        imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
        
        pinch.scale = 1;
    }
    
    func longPress(longPress: UILongPressGestureRecognizer){
        if (longPress.state == .Began) {
            // 图片处理完毕
            
            // 高亮的效果
           UIView.animateWithDuration(0.25, animations: { [unowned self]() -> Void in
              self.imageView.alpha = 0;
            }, completion: { (_) -> Void in
                UIView.animateWithDuration(0.25, animations: { [weak self] () -> Void in
                     self!.imageView.alpha = 1;
                    }, completion: { (_) -> Void in
                        
                        // 高亮完成的时候
                        
                        // 把处理的图片生成一张新的图片，截屏
                        
                        // 开启位图上下文
                        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0);
                        
                        // 获取位图上下文
                        let ctx = UIGraphicsGetCurrentContext();
                        
                        // 把控件的图层渲染到上下文
                        self.layer.renderInContext(ctx!)
                        
                        // 获取图片
                        let layerImage = UIGraphicsGetImageFromCurrentImageContext();
                        
                        // 关闭上下文
                        UIGraphicsEndImageContext();
                        
                        // 调用Block
                        if (self.callBack != nil) {
                           self.callBack!(image: layerImage)
                        }
                        
                        // 移除父控件
                       self.removeFromSuperview()

                })
           })
        }
    }
    
    
    //UIGestureRecognizerDelegate
    // 是否同时支持多个手势
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
