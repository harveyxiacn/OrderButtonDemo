//
//  OrderViewController.swift
//  PageMenuTest
//
//  Created by HarveyXia on 15/6/26.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: UIViewController {
    /** 储存已订阅频道的Touch View Model数组*/
    var _modelArr1: NSArray = NSArray()
    /** 已订阅频道touch view数组*/
    var _viewArr1: NSMutableArray = NSMutableArray()
    /** 更多频道touch view数组*/
    var _viewArr2: NSMutableArray = NSMutableArray()
    /** 分类Label1，订阅频道*/
    var _titleLabel: UILabel = UILabel()
    /** 分类Label2，更多频道*/
    var _titleLabel2: UILabel = UILabel()
    /** 频道名称数组*/
    var titleArr: NSArray = NSArray()
    /** 频道对应链接数组*/
    var urlStringArr: NSArray = NSArray()
    /** 返回按键*/
    var backButton: UIButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // custom initializtion
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var string: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as! String
        var filePath: String = string.stringByAppendingString("/modelArray0.swh")
        var filePath1: String = string.stringByAppendingString("/modelArray1.swh")
        
        if !NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            //频道名称
            var channelListArr: NSArray = self.titleArr
            //频道链接
            var channelUrlStringListArr: NSArray = self.urlStringArr
            //储存touch view model数组
            var mutArr: NSMutableArray = NSMutableArray()
            // 根据给每个频道名称创建Touch View Model
            for var i = 0; i < channelListArr.count; i++ {
                var title: NSString = channelListArr.objectAtIndex(i) as! NSString
                var urlString: NSString = channelUrlStringListArr.objectAtIndex(i) as! NSString
                var touchViewModel: TouchViewModel = TouchViewModel(title: title, urlString: urlString)
                mutArr.addObject(touchViewModel)
                if (i == KDefaultCountOfUpsideList - 1) {// 已达到默认频道数量，写入文件
                    var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(mutArr)
                    data.writeToFile(filePath, atomically: true)
                    mutArr.removeAllObjects()
                }
                else if(i == channelListArr.count - 1){// 除了默认频道，剩下的频道名称数组已经读完，并创建touch view model，写入文件1
                    var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(mutArr)
                    data.writeToFile(filePath1, atomically: true)
                }
                
            }
        }
        
        // 已订阅频道数组
        _modelArr1 = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! NSArray
        // 更多频道数组
        var modelArr2: NSArray = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath1) as! NSArray
        // 已订阅频道touch view数组
        _viewArr1 = NSMutableArray()
        // 更多频道touch view数组
        _viewArr2 = NSMutableArray()
        // 定义订阅频道的label并添加到view中
        //_titleLabel = UILabel(frame: CGRectMake(110, 25, 100, 40))
        _titleLabel = UILabel(frame: CGRectMake(self.view.frame.width/2 - 50, 25, 100, 40))
        _titleLabel.text = "我的订阅";
        _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor(red: 187/255.0, green: 1/255.0, blue: 1/255.0, alpha: 1.0)
        //_titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(_titleLabel)
        // 定义更多频道的label并添加到view中
        //_titleLabel2 = UILabel(frame: CGRectMake(110, KTableStartPointY + KButtonHeight * (self.array2StartY() - 1) + KMoreChannelDeltaHeight, 100, 20))
        _titleLabel2 = UILabel(frame: CGRectMake(self.view.frame.width/2 - 50, KTableStartPointY + KButtonHeight * (self.array2StartY() - 1) + KMoreChannelDeltaHeight, 100, 20))
        _titleLabel2.text = "更多频道"
        _titleLabel2.font = UIFont.systemFontOfSize(10)
        _titleLabel2.textAlignment = NSTextAlignment.Center
        _titleLabel2.textColor = UIColor.grayColor()
        //_titleLabel2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(_titleLabel2)
        // 创建并插入订阅频道的touchview
        for (var i = 0; i < _modelArr1.count; i++) {
            var column = i%5
            var row = i/5
            //var touchView: TouchView = TouchView(frame: CGRectMake(KTableStartPointX + KButtonWidth * (CGFloat(column)), KTableStartPointY + KButtonHeight * (CGFloat(row)), KButtonWidth, KButtonHeight))
            var touchView: TouchView = TouchView(frame: CGRectMake((self.view.frame.width -  5 * KButtonWidth) / 2 + KButtonWidth * (CGFloat(column)), KTableStartPointY + KButtonHeight * (CGFloat(row)), KButtonWidth, KButtonHeight))
            touchView.backgroundColor = UIColor(red: 210/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1.0)
            
            _viewArr1.addObject(touchView)
            touchView._array = _viewArr1
            
            if (i == 0) {
                touchView.label.textColor = UIColor(red: 187/255.0, green: 1/255.0, blue: 1/255.0, alpha: 1.0)
            }
            else{
                touchView.label.textColor = UIColor(red:99/255.0, green:99/255.0, blue:99/255.0, alpha:1.0)
            }
            touchView.label.text = _modelArr1.objectAtIndex(i).title
            touchView.label.textAlignment = NSTextAlignment.Center
            touchView.moreChannelsLabel = _titleLabel2
            touchView._viewArr11 = _viewArr1
            touchView._viewArr22 = _viewArr2
            touchView.touchViewModel = _modelArr1.objectAtIndex(i) as? TouchViewModel
            
            self.view.addSubview(touchView)
        }
        // 创建并插入更多频道的touchview
        for (var i = 0; i < modelArr2.count; i++) {
            var column = i%5
            var row = i/5
            //var touchView: TouchView = TouchView(frame: CGRectMake(KTableStartPointX + KButtonWidth * (CGFloat(column)), KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight + KButtonHeight * (CGFloat(row))  , KButtonWidth, KButtonHeight))
            var touchView: TouchView = TouchView(frame: CGRectMake((self.view.frame.width -  5 * KButtonWidth) / 2 + KButtonWidth * (CGFloat(column)), KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight + KButtonHeight * (CGFloat(row))  , KButtonWidth, KButtonHeight))
            
            touchView.backgroundColor = UIColor(red:210/255.0, green:210/255.0, blue:210/255.0, alpha:1.0)
            
            _viewArr2.addObject(touchView)
            touchView._array = _viewArr2
            
            touchView.label.text = modelArr2.objectAtIndex(i).title
            touchView.label.textColor = UIColor(red:99/255.0, green:99/255.0, blue:99/255.0, alpha:1.0)
            touchView.label.textAlignment = NSTextAlignment.Center
            touchView.moreChannelsLabel = _titleLabel2
            touchView._viewArr11 = _viewArr1
            touchView._viewArr22 = _viewArr2
            touchView.touchViewModel = modelArr2.objectAtIndex(i) as? TouchViewModel
            
            self.view.addSubview(touchView)
            
        }
        
        self.backButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        self.backButton.frame = CGRectMake(self.view.bounds.size.width - 56, self.view.bounds.size.height - 44, 56, 44)
        self.backButton.setImage(UIImage(named: "order_back"), forState: UIControlState.Normal)
        self.backButton.setImage(UIImage(named: "order_back_select"), forState: UIControlState.Normal)
        self.view.addSubview(self.backButton)
    }
    
    func array2StartY() -> CGFloat {
        var y: CGFloat = 0
        
        y = CGFloat(_modelArr1.count / 5 + 2)
        if _modelArr1.count % 5 == 0 {
            y -= 1
        }
        return y
    }
}