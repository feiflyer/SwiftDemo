//
//  ViewController.swift
//  NSURLSession
//
//  Created by 梁传飞 on 16/3/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        get()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    func get(){
        // 获得NSURLSession对象
        let session = NSURLSession.sharedSession()
        //代理
      //  session.delegate = NSURLSessionDataDelegate()
        // 创建任务
        let task = session.dataTaskWithRequest(NSURLRequest(URL:  NSURL(string: "http://120.25.226.186:32812/login?username=123&pwd=4324")!)) { (data, respond, error) -> Void in
        
            do{
              let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                print("---json\(json)")
            }catch{
                
            }
            
        }
        
        // 启动任务
        task.resume()
    }
    
    func get2(){
        // 获得NSURLSession对象
        let session = NSURLSession.sharedSession()
        
        // 创建任务
        let task = session.dataTaskWithURL(NSURL(string: "http://120.25.226.186:32812/login?username=123&pwd=4324")!) { (data, response, error) -> Void in
            
            do{
                try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            }catch{
                
            }
        }
        // 启动任务
        task.resume()
    }
    
    
    func download(){
        // 获得NSURLSession对象
        let session = NSURLSession.sharedSession()
        
        // 获得下载任务
         let task = session.downloadTaskWithURL(NSURL(string: "http://120.25.226.186:32812/resources/videos/minion_01.mp4")!) { (location, respond, error) -> Void in
            // 文件将来存放的真实路径
            let file: NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
            print("---\(location)")
          let filePath = file.stringByAppendingPathComponent(respond!.suggestedFilename!)
            // 剪切location的临时文件到真实路径
            do{
                let fileManager = NSFileManager.defaultManager()
               try fileManager.moveItemAtURL(location!, toURL: NSURL(string: filePath)!)
            }catch{
                
            }
        }
        // 启动任务
       task.resume()

    }
    
    
    func post(){
        // 获得NSURLSession对象
        let session = NSURLSession.sharedSession()
        
        // 创建请求
        let request = NSMutableURLRequest(URL: NSURL(string: "http://120.25.226.186:32812/login")!)
            request.HTTPMethod = "POST"; // 请求方法
            // 请求体
            request.HTTPBody = "username=520it&pwd=520it".dataUsingEncoding(NSUTF8StringEncoding)
        
        // 创建任务
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do{
                try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            }catch{
                
            }
        }
        // 启动任务
        task.resume()

    }

}
