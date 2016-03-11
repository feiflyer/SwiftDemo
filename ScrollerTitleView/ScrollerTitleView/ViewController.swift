//
//  ViewController.swift
//  ScrollerNavigation
//
//  Created by 梁传飞 on 16/3/9.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit



let CHILD_COUNT = 10
let START_TAG = 12345;

class ViewController: UIViewController {

    
    @IBOutlet weak var contentScrollerView: UIScrollView!
    @IBOutlet weak var titleScrollerView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
    //    automaticallyAdjustsScrollViewInsets = false
        
        setUpTitle()
        setChildViewController()
        
        //默认显示第0个控制器
        contentScrollerView.delegate?.scrollViewDidEndScrollingAnimation!(contentScrollerView)
        
    }

    //添加标题
    func setUpTitle(){
        titleScrollerView.backgroundColor = UIColor.redColor()
        for var i = 0 ; i < CHILD_COUNT ; i++ {
            let label = CustomLabel(frame: CGRectMake(CGFloat(i * 100) , 0, 100, titleScrollerView.bounds.size.height))
            label.text = "头条\(i)"
            label.tag = i + START_TAG
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "itemOnclick:"))
            titleScrollerView.addSubview(label)
        }
    //设置scrollerView滚动范围
    titleScrollerView.contentSize = CGSize(width: CHILD_COUNT * 100, height: 0)
    contentScrollerView.contentSize = CGSize(width: CGFloat(CHILD_COUNT) * UIScreen.mainScreen().bounds.size.width, height: 0)
        //设置分页
    contentScrollerView.pagingEnabled = true
        
    contentScrollerView.delegate = self
        
    }
    
    //设置子控制器
    func setChildViewController(){
        for var i = 0 ; i < CHILD_COUNT ; i++ {
            let vc = TableViewController()
            vc.titleString = "这是第\(i)栏"
            addChildViewController(vc)
        }
    }
    
    func itemOnclick(tap: UITapGestureRecognizer){
        print("----\(tap.view)")
        let tag = tap.view?.tag
        var offset = contentScrollerView.contentOffset
        offset.x = CGFloat(tag! - START_TAG) * contentScrollerView.bounds.size.width
        //让动画执行之后才加载内容，节省内存
        contentScrollerView.setContentOffset(offset, animated: true);
    }

}

//MARK

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
       let width = scrollView.bounds.size.width
        //新控制器的索引
        let index = Int(scrollView.contentOffset.x / width)
        //取出要显示的vc
        let vc = childViewControllers[index]
        //如果已经加载过了就不重复加载了,两种方法
//        if vc.isViewLoaded() {
//            return
//        }
        
        //如果已经加载过了就不重复加载了
        if (vc.view.superview == nil) {
            vc.view.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: width, height: scrollView.bounds.size.height)
            scrollView.addSubview(vc.view)
        }
            
        
        //让对应的标题居中显示
        let titleLabel = titleScrollerView.viewWithTag(index + START_TAG)
        var titleOffset = titleScrollerView.contentOffset
        titleOffset.x = (titleLabel?.center.x)! - width * 0.5
        
        //左边超出处理
        if titleOffset.x < 0 {
            titleOffset.x = 0
        }
        //右边超出处理
        let maxOffset = titleScrollerView.contentSize.width - width
        if titleOffset.x > maxOffset {
            titleOffset.x = maxOffset
        }
        
        titleScrollerView.setContentOffset(titleOffset, animated: true)
        
    }
    
    //认为拖动scrollerView松开手指虎会触发这个方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    //只要scrollerView在动就回调用这个方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
       
        
        //获取需要操作Label的索引
        let width = scrollView.bounds.size.width
        let scal = scrollView.contentOffset.x / width
        if (scal < 0 || scal > CGFloat(CHILD_COUNT - 1)) {
           return;
        }
        
        let leftIndex  = Int(scal)
        
        let rightIndex = leftIndex + 1
        
        if (leftIndex < 0 || rightIndex > CHILD_COUNT - 1){
            return
        }
        
        //右边的比例
        
        let rightScal = scal - CGFloat(leftIndex)
        //左边的比例
        let leftScal = 1 - rightScal
        print("---leftscal:\(leftScal)")
        print("---rightScal:\(rightScal)")
        print("-----leftIndex\(leftIndex)")
      
        let leftLabel = titleScrollerView.viewWithTag(leftIndex + START_TAG) as! CustomLabel
        leftLabel.scal = leftScal
        let rightLabel = titleScrollerView.viewWithTag(rightIndex + START_TAG) as! CustomLabel
        rightLabel.scal = rightScal
    }
    
    
}

