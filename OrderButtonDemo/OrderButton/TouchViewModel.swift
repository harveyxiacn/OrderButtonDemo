//
//  TouchViewModel.swift
//  PageMenuTest
//
//  Created by HarveyXia on 15/6/26.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import Foundation

class TouchViewModel: NSObject, NSCoding {
    /** touch view model的title*/
    var title: NSString = NSString()
    /** touch view model的链接字符串*/
    var urlString: NSString = NSString()
    /** 初始化并编码*/
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.urlString, forKey: "urlString")
    }
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.title = aDecoder.decodeObjectForKey("title") as! NSString
        self.urlString = aDecoder.decodeObjectForKey("urlString") as! NSString
    }
    /** 用title和链接字符串初始化*/
    init(title: NSString, urlString: NSString) {
        super.init()
        self.title = title
        self.urlString = urlString
    }
}