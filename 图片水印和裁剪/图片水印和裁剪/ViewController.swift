//
//  ViewController.swift
//  图片水印和裁剪
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "小黄人")
//        imageView.image = addWater(image!)
        
//        let image = UIImage(named: "阿狸头像")
//        imageView.image = clipImage(image!)
        
        let image = UIImage(named: "阿狸头像")
        imageView.image = clipImageWithBoard(image!, boardColor: UIColor.redColor(), borderWidth: 3)
       
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
          clipScreenAndSave()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //给图片添加水印
    func addWater(image: UIImage) -> UIImage{
        //开启上下文
        /**
        <#T##opaque: Bool##Bool#> ：是否是不透明  true表示不透明， false表示透明
        scal: 缩放比例，0表示不缩放
        */
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
        image.drawInRect(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let waterString: NSString = "@我是水印啊"
        waterString.drawInRect(CGRect(x: 0, y: 0, width: 80, height: 20), withAttributes: nil)
        //获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
         UIGraphicsEndImageContext()
        
        return newImage
    }
    
    //剪裁图片
    func clipImage(image: UIImage) -> UIImage{
        
        UIGraphicsBeginImageContext(image.size)
        //剪裁路径
        let clipPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), cornerRadius: image.size.width / 2)
        //添加剪裁路径
        clipPath.addClip()
        
        image.drawAtPoint(CGPoint.zero)
        //获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return newImage

    }
    
    //剪裁图片（带边框）
    func clipImageWithBoard(image: UIImage , boardColor: UIColor ,borderWidth: CGFloat) -> UIImage{
        // 图片的宽度和高度
        let imageWH = image.size.width;
        
        // 设置圆环的宽度
        let border = borderWidth;
        
        // 圆形的宽度和高度
        let ovalWH = imageWH + 2 * border;
        
        // 1.开启上下文  是否不透明要设置为false
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), false, 0);
        
        // 2.画大圆
        let boardPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, ovalWH, ovalWH))
        
        boardColor.set()
        
        boardPath.fill()
        
        // 3.设置裁剪区域
        let clipPath = UIBezierPath(ovalInRect: CGRectMake(border, border, imageWH, imageWH))
        clipPath.addClip()
        
        // 4.绘制图片
        image.drawAtPoint(CGPointMake(border, border))
        
        // 5.获取图片
        let clipImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6.关闭上下文
        UIGraphicsEndImageContext();
        
        return clipImage;
        
    }
    
    //截屏并保存在桌面
    func clipScreenAndSave(){
        // 开启位图上下文
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0);
        
        // 获取上下文
        let ctx = UIGraphicsGetCurrentContext();
        
        // 把控件上的图层渲染到上下文,layer只能渲染
        view.layer.renderInContext(ctx!)
        
        // 生成一张图片
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        // image转data
        // compressionQuality： 图片质量 1:最高质量
        
        let data = UIImageJPEGRepresentation(image,1);
        
        data?.writeToFile("/Users/liangchuanfei/Desktop/view.png", atomically: true)
        

    }
    
    
    

    
    

}

