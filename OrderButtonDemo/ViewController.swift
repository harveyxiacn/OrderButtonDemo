//
//  ViewController.swift
//  OrderButtonDemo
//
//  Created by HarveyXia on 15/6/29.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var orderButton: OrderButton = OrderButton.orderButtonWithViewController(self, titleArr: NSArray(array: KChannelList), urlStringArr: NSArray(array: KChannelUrlStringList)) as! OrderButton
        self.view.addSubview(orderButton)
        orderButton.addTarget(self, action: "orderViewOut:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func orderViewOut(sender: AnyObject) {
        var orderButton: OrderButton = sender as! OrderButton
        if orderButton.vc.view.subviews.count > 1 {
            //        [[[orderButton.vc.view subviews]objectAtIndex:1] removeFromSuperview];
            println("\(orderButton.vc.view.subviews)")
        }
        var orderVC: OrderViewController = OrderViewController()
        orderVC.titleArr = orderButton.titleArr;
        orderVC.urlStringArr = orderButton.urlStringArr;
        var orderView: UIView = orderVC.view
        orderView.frame = CGRectMake(0, 0 - (orderButton.vc.view.bounds.size.height), orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)
        orderView.backgroundColor = UIColor(red:239/255.0, green:239/255.0, blue:239/255.0, alpha:1.0)
        orderVC.backButton.addTarget(self, action:"backAction:", forControlEvents:UIControlEvents.TouchUpInside)
        
        self.view.addSubview(orderView)
        self.addChildViewController(orderVC)
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
            orderView.frame = CGRectMake(0, 0, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)
            }, completion: { (Bool) in
        })
    }
    
    func backAction(sender: AnyObject) {
        var orderVC: OrderViewController = self.childViewControllers.first as! OrderViewController
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
            orderVC.view.frame = CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)
            }, completion: { (Bool) in
                var string: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as! String
                var filePath: String = string.stringByAppendingString("/modelArray0.swh")
                var filePath1: String = string.stringByAppendingString("/modelArray1.swh")
                var modelArr: NSMutableArray = NSMutableArray()
                var touchView: TouchView?
                for touchView in orderVC._viewArr1 {
                    modelArr.addObject((touchView as! TouchView).touchViewModel!)
                }
                var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(modelArr)
                data.writeToFile(filePath, atomically: true)
                modelArr.removeAllObjects()
                
                for touchView in orderVC._viewArr2 {
                    modelArr.addObject((touchView as! TouchView).touchViewModel!)
                }
                
                data = NSKeyedArchiver.archivedDataWithRootObject(modelArr)
                data.writeToFile(filePath1, atomically: true)
                (self.childViewControllers.first as! OrderViewController).view.removeFromSuperview()
                orderVC.removeFromParentViewController()
        })
        
    }

}

