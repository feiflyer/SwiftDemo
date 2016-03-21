//
//  ViewController.swift
//  个性画板
//
//  Created by 梁传飞 on 16/3/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func save(sender: AnyObject) {
        drawView.save()
    }

    @IBAction func photo(sender: AnyObject) {
        //弹出系统相册
        if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)){
            
        let imagePick = UIImagePickerController()
        imagePick.allowsEditing = false
        imagePick.delegate = self
        presentViewController(imagePick, animated: true, completion: nil)

        }else{
            print("相册不可用")
        }
        
    }
    

    @IBAction func brush(sender: AnyObject) {
        drawView.brush()
    }

    @IBAction func clear(sender: AnyObject) {
        drawView.clear()
    }
    
    @IBAction func giveUp(sender: AnyObject) {
        drawView.giveUp()
    }

    @IBAction func selectBlack(sender: AnyObject) {
        drawView.lineColor = UIColor.blackColor()
    }
    
    
    @IBAction func selectYellow(sender: AnyObject) {
        drawView.lineColor = UIColor.yellowColor()

    }
    
    @IBAction func selectBlue(sender: AnyObject) {
        drawView.lineColor = UIColor.blueColor()

    }
    
    @IBAction func widthChange(sender: UISlider){
        drawView.lineWidh = CGFloat(sender.value * 10) + CGFloat(3)
    }
}

extension ViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
     func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        // 获取选中的照片
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage;
        
        // 创建一个图片处理的View
        let imageHandleV = ImageHandleView(frame: drawView.bounds)
        imageHandleV.callBack = { (image) -> Void in
            self.drawView.image = image;
        }
        
        self.drawView.addSubview(imageHandleV)
        
        // 把选中的照片画到画板上
//        if let image = selectedImage {
//            drawView.image = image;
//        }
        
        if let image = selectedImage {
            imageHandleV.image = image
        }
        
        // dismiss
        dismissViewControllerAnimated(true, completion: nil)
    }

}
