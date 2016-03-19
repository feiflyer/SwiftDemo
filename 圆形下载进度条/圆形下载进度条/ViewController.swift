//
//  ViewController.swift
//  圆形下载进度条
//
//  Created by 梁传飞 on 16/3/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressView: ProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressLabel.text = "0.00%"
        
    }

    @IBAction func progressChange(sender: UISlider) {
        progressView.progress = CGFloat(sender.value)
        progressLabel.text = NSString(format: "%.2f%%", sender.value * 100) as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

