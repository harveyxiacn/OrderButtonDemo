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
let KChannelList: [String] = ["全部", "新闻", "生意", "时尚", "美发", "健康", "工作", "生活", " 运动", "旅游", "教育", "签证", "优惠", "房产", "汽车", "养生"]
/** 频道对应wordpress目录名*/
let KChannelUrlStringList: [String] = ["", "news", "business", "fashion", "hair", "health-fitness", "jobs", "life-love", "sports", "tourism", "education", "签证", "商家优惠", "房产", "Car", "养生"]