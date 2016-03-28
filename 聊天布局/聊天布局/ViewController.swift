//
//  ViewController.swift
//  聊天布局
//
//  Created by 梁传飞 on 16/3/28.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var msgArray: [ChatData]={
        // 加载plist中的字典数组
        let path = NSBundle.mainBundle().pathForResource("messages.plist", ofType: nil)
        let dictArray = NSArray(contentsOfFile: path!) as? [Dictionary<String, AnyObject>]

       // 字典数组 -> 模型数组
       var messageArray = [ChatData]()
        
        for dict in dictArray!{
            messageArray.append(ChatData(dict: dict))
        }
    
            return messageArray;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      //  tableView.registerClass(ChatTableCell.self, forCellReuseIdentifier: "chatcell")
    }

}


extension ViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatcell") as? ChatTableCell
        cell?.msg = msgArray[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return msgArray.count
    }
}

