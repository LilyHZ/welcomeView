//
//  ViewController.swift
//  WelcomeVIewByScrollView
//
//  Created by xly on 15/9/13.
//  Copyright (c) 2015年 Lily. All rights reserved.
//

import UIKit

/**
思路：scrollView.contentSize里容纳有x个屏幕宽的View
*/
class ViewController: UIViewController ,UIScrollViewDelegate{

    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    var btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加pageControl
        pageControl.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 30)
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
//        pageControl.addTarget(self, action: "", forControlEvents: UIControlEvents.ValueChanged)
        
        //添加scrollView
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSizeMake(4*self.view.frame.width, 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        //添加图片
        for i in 0...3{
            var imageView = UIImageView(frame: self.view.bounds)
            imageView.image = UIImage(named: "Welcome\(i+1)")
            
            var frame = imageView.frame
            frame.origin.x = CGFloat(i) * self.view.frame.width
            imageView.frame = frame
            
            self.scrollView.addSubview(imageView)
//            self.view.addSubview(pageControl)
        }
        self.view.addSubview(pageControl)
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x/self.view.frame.width)
        pageControl.currentPage = index
        
        if index == 3{
            btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height, self.view.frame.width, 50)
            self.btn.setTitle("开启Swift之旅", forState: UIControlState.Normal)
            self.btn.titleLabel?.font = UIFont.systemFontOfSize(20)
            self.btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
            self.btn.backgroundColor = UIColor.orangeColor()
            self.btn.alpha = 0
            self.btn.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            UIView.animateWithDuration(0.8, delay: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height-100, self.view.frame.width, 50)
                self.btn.alpha = 1
                //注意把按钮添加到scrollView上,不要添加到imageView上,会无法点击
                self.scrollView.addSubview(self.btn)
            }, completion: nil)
        }
    }
    
    //按钮点击事件
    func buttonClick(button:UIButton)
    {
        //界面的跳转
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = sb.instantiateViewControllerWithIdentifier("second") as! UIViewController
        self.presentViewController(secondVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

