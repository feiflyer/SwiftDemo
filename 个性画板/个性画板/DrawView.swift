//
//  DrawView.swift
//  个性画板
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lineWidh: CGFloat = 3
    var lineColor: UIColor = UIColor.blackColor()
    
    var pathArray = [DrawParh]()
    var currentPath: DrawParh?
    
    var image: UIImage? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if(image != nil){
            image?.drawInRect(rect)
        }
        
        for path in pathArray{
            path.lineColor.set()
            path.stroke()
        }
    }
    
    override func awakeFromNib() {
        //添加手势
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        addGestureRecognizer(pan)
    }
    
    func pan(pan: UIPanGestureRecognizer){
        // 获取当前手指触摸点
        let curP = pan.locationInView(self)
        
        // 获取开始点
        if (pan.state == .Began) {
            // 创建贝瑟尔路径
           currentPath = DrawParh()
            
            // 设置线宽
            currentPath!.lineWidth = lineWidh
            
            // 给路径设置颜色
            currentPath?.lineColor = lineColor;
            
            // 设置路径的起点
            currentPath! .moveToPoint(curP)
            
            // 保存描述好的路径
           pathArray.append(currentPath!)
            
        }
        
        // 手指一直在拖动
        // 添加线到当前触摸点
        currentPath?.addLineToPoint(curP)
        
        // 重绘
       setNeedsDisplay()

    }
    
    
    func save(){
        // 截屏
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0);
        
        // 获取上下文
        let ctx = UIGraphicsGetCurrentContext();
        
        // 渲染图层
        layer.renderInContext(ctx!)
        
        // 获取上下文中的图片
        let layerImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        
        // 保存画板的内容放入相册
        // image:写入的图片
        // completionTarget图片保存监听者
        // 注意：以后写入相册方法中，想要监听图片有没有保存完成，保存完成的方法不能随意乱写
        UIImageWriteToSavedPhotosAlbum(layerImage, self, "image:didFinishSavingWithError:contextInfo:", nil)

    }
    
     // 图片保存成功后回调的方法
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject){
    if error != nil{
       print("---保存失败")
    }else{
        print("---保存成功")
    }
  }


    func clear(){
        image = nil
        pathArray.removeAll()
        setNeedsDisplay()
    }
    
    func giveUp(){
        pathArray.removeLast()
        setNeedsDisplay()
    }
    
    func brush(){
        lineColor = self.backgroundColor!
    }
    

    
}
