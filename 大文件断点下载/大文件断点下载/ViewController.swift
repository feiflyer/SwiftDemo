//
//  ViewController.swift
//  大文件断点下载
//
//  Created by 梁传飞 on 16/3/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

let RESUME_DATA_FILE = "resumeData.tmp"

class ViewController: UIViewController {

    //懒加载
    lazy var session: NSURLSession = {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue())
        return session
    }()
    
    var task: NSURLSessionDownloadTask?
    
    lazy var resumeData: NSData? = {
       let resumeData = NSData(contentsOfFile: self.resumeDataPath as String)
        return resumeData
    }()
    
    lazy var resumeDataPath: NSString = {
        var path: NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        path = path.stringByAppendingPathComponent(RESUME_DATA_FILE)
        return path
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   
    @IBAction func start(sender: UIButton) {
            if let tempData = resumeData {
                // 获得上次的下载任务
            task = self.session .downloadTaskWithResumeData(tempData)
                // 将上次的临时文件放到tmp中
            } else {
        // 获得下载任务
        task = session.downloadTaskWithURL(NSURL(string: "http://120.25.226.186:32812/resources/videos/minion_01.mp4")!)
         }
        // 启动任务
        task!.resume()

    }

    @IBAction func pause(sender: UIButton) {
        // 一旦这个task被取消了，就无法再恢复
        task?.cancelByProducingResumeData(){
            [weak self] (data) -> Void in
            self?.resumeData = data
            // 可以将resumeData写入沙盒，保存起来
            // 下次进入程序，就可以将resumeData读取进来，继续下载
            self?.resumeData?.writeToFile(self?.resumeDataPath as! String, atomically: true)
        }
    }
    
    @IBAction func resume(sender: UIButton) {
        task = session.downloadTaskWithResumeData(resumeData!)
        task!.resume()
    }
    
}

extension ViewController : NSURLSessionDownloadDelegate{
    
    //下载完成后一定会调用这个方法
     func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        // 文件将来存放的真实路径
        var file: NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        file = file.stringByAppendingPathComponent(downloadTask.response!.suggestedFilename!)
        
        // 剪切location的临时文件到真实路径
        let mgr = NSFileManager.defaultManager()
        do{
            try  mgr.moveItemAtURL(location, toURL: NSURL(string: file as String)!)
        }catch{
            
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSLog("didCompleteWithError");
        // 保存恢复数据
       // resumeData = error!.userInfo[NSURLSessionDownloadTaskResumeData];
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
         NSLog("\(fileOffset)");
    }
    
    /**
     * 每当写入数据到临时文件时，就会调用一次这个方法
     * totalBytesExpectedToWrite:总大小
     * totalBytesWritten: 已经写入的大小
     * bytesWritten: 这次写入多少
     */

    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
}