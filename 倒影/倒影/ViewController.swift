//
//  ViewController.swift
//  倒影
//
//  Created by 梁传飞 on 16/3/22.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var reversesView: ReversesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layer: CAReplicatorLayer =  reversesView.layer as! CAReplicatorLayer
        
        layer.instanceCount = 2;
        
        
        var transform = CATransform3DMakeTranslation(0, reversesView.bounds.size.height, 0);
        // 绕着X轴旋转
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 1, 0, 0);
        
        
        // 往下面平移控件的高度
        layer.instanceTransform = transform;
        
        layer.instanceAlphaOffset = -0.1;
        layer.instanceBlueOffset = -0.1;
        layer.instanceGreenOffset = -0.1;
        layer.instanceRedOffset = -0.1;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

