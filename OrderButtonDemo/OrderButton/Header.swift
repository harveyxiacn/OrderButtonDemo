//
//  Header.swift
//  PageMenuTest
//
//  Created by HarveyXia on 15/6/26.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import Foundation
import UIKit

/** OrderButton的frame值位置X*/
let KOrderButtonFrameOriginX: CGFloat = 257
/** OrderButton的frame值位置Y*/
let KOrderButtonFrameOriginY: CGFloat = 20
/** OrderButton的frame值宽*/
let KOrderButtonFrameSizeX: CGFloat = 63
/** OrderButton的frame值高*/
let KOrderButtonFrameSizeY: CGFloat = 45
/** OrderButton的背景图片*/
let KOrderButtonImage: String = "topnav_orderbutton"
/** OrderButton被选择时的背景图片*/
let KOrderButtonImageSelected:String = "topnav_orderbutton_selected_unselected"
/** 默认订阅频道数*/
let KDefaultCountOfUpsideList: Int = 10
/** 已订阅按钮的起始位置X*/
let KTableStartPointX: CGFloat = 50
/** 已订阅按钮的起始位置Y*/
let KTableStartPointY: CGFloat = 60
/** 按钮宽*/
let KButtonWidth: CGFloat = 54
/** 按钮高*/
let KButtonHeight: CGFloat = 40
/** 更多频道下面按钮的起始位置向下偏移*/
let KDeltaHeight: CGFloat = 40
/** 更多频道起始Y坐标向下偏移*/
let KMoreChannelDeltaHeight: CGFloat = 62
/** 频道列表数组*/
let KChannelList: [String] = ["头条","娱乐","健康","星座","社会","佛教","时事","时尚","军事","旅游","房产","汽车","港澳","教育","历史","文化","财经","读书","台湾","体育","科技","评论"]
/** 频道对应wordpress目录名*/
let KChannelUrlStringList: [String] = ["http://api.3g.ifeng.com/iosNews?id=aid=SYLB10&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=YL53&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=JK36&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=XZ09&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=SH133&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=FJ31&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=XW23&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=SS78&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=JS83&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=LY67&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=FC81&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=QC45&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=GA18&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=JY90&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=LS153&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=WH25&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=CJ33&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=DS57&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=TW73&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=TY43,FOCUSTY43&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=KJ123&imgwidth=100&type=list&pagesize=20","http://api.3g.ifeng.com/iosNews?id=aid=PL40&imgwidth=100&type=list&pagesize=20"]