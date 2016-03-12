//
//  ViewController.swift
//  UIScrollerView悬停Demo
//
//  Created by 梁传飞 on 16/3/11.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIScrollViewDelegate {
   

    @IBOutlet weak var scrollerView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redView: UIView!
    
    var imageViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollerView.contentSize = CGSizeMake(0,CGRectGetMaxY(self.blueView.frame))
        scrollerView.delegate = self
           }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageViewHeight = imageView.bounds.size.height
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
       
        if scrollerView.contentOffset.y >= imageViewHeight{
            var rect = redView.frame
            rect.origin.y = 0
            redView.frame = rect
            view.addSubview(redView)
            print("----停住")
        }else{
            var rect = redView.frame
            rect.origin.y = imageViewHeight
            scrollView.addSubview(redView)
            redView.frame = rect
            print("----下来")

        }
        
//        if scrollerView.contentOffset.y < 0{
//            let scal = 1 - scrollerView.contentOffset.y / 60
//            imageView.transform = CGAffineTransformMakeScale(scal, scal)
//        }
        
        var scal = 1 - scrollerView.contentOffset.y / 60
        if scal < 1{
            scal = 1
        }
            imageView.transform = CGAffineTransformMakeScale(scal, scal)
        
    }


}

