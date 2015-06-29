//
//  OrderButton.swift
//  PageMenuTest
//
//  Created by HarveyXia on 15/6/26.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import Foundation
import UIKit

class OrderButton: UIButton {
    /**  View Controller*/
    var vc: UIViewController = UIViewController()
    /** button title数组*/
    var titleArr: NSArray = NSArray()
    /** button对应url字符串数组*/
    var urlStringArr: NSArray = NSArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 创建order button并附带View Controller*/
    class func orderButtonWithViewController(vc: UIViewController, titleArr: NSArray, urlStringArr: NSArray) -> AnyObject {
        var orderButton: OrderButton = OrderButton.buttonWithType(UIButtonType.Custom) as! OrderButton
        orderButton.vc = vc
        orderButton.titleArr = titleArr
        orderButton.urlStringArr = urlStringArr
        orderButton.setImage(UIImage(named: KOrderButtonImage), forState: UIControlState.Normal)
        orderButton.setImage(UIImage(named: KOrderButtonImageSelected), forState: UIControlState.Highlighted)
        //orderButton.frame = CGRectMake(KOrderButtonFrameOriginX, KOrderButtonFrameOriginY, KOrderButtonFrameSizeX, KOrderButtonFrameSizeY)
        var orderButtonX = vc.view.frame.width - KOrderButtonFrameSizeX
        orderButton.frame = CGRectMake(orderButtonX, KOrderButtonFrameOriginY, KOrderButtonFrameSizeX, KOrderButtonFrameSizeY)
        return orderButton
    }
}