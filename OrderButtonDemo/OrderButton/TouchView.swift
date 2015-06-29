//
//  TouchView.swift
//  PageMenuTest
//
//  Created by HarveyXia on 15/6/26.
//  Copyright (c) 2015年 IDEA IT Solution Inc. All rights reserved.
//

import Foundation
import UIKit

class TouchView: UIImageView {
    /** 储存本view的位置*/
    var _point: CGPoint = CGPoint()
    /** 储存superview的位置*/
    var _point2: CGPoint = CGPoint()
    var _sign: NSInteger = NSInteger()
    /** 本view在的array，_viewArr11或者_viewArr22*/
    var _array: NSMutableArray = NSMutableArray()
    /** 订阅频道touch views数组*/
    var _viewArr11: NSMutableArray = NSMutableArray()
    /** 更多频道touch views数组*/
    var _viewArr22: NSMutableArray = NSMutableArray()
    var label: UILabel = UILabel()
    var moreChannelsLabel: UILabel = UILabel()
    var touchViewModel: TouchViewModel?
    /** 初始化*/
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.multipleTouchEnabled = true
        self.userInteractionEnabled = true
        var label = UILabel(frame: CGRectZero)
        self.label = label
        _sign = 0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 子View布局方法*/
    override func layoutSubviews() {
        self.label.frame = CGRectMake(1, 1, KButtonWidth-2, KButtonHeight-2)
        self.label.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
        self.addSubview(self.label)
    }
    /** Touch view被点击，开始转换*/
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch: UITouch = touches.first as! UITouch
        _point = touch.locationInView(self)
        _point2 = touch.locationInView(self.superview)
        // 将被点击的touch view交换在superview的位置
        var destinatedIndex = self.superview?.subviews.count
        destinatedIndex = destinatedIndex! - 1
        println("destinated index = \(destinatedIndex!)")
        self.superview?.exchangeSubviewAtIndex(indexOfSelfInSubviews(), withSubviewAtIndex: destinatedIndex!)
        //self.superview?.exchangeSubviewAtIndex(find(self.superview?.subviews, self), withSubviewAtIndex: (self.superview?.subviews.count))
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        
    }
    /** Touch view被点击结束，换好所在数组，储存到_array*/
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.label.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
        self.image = nil
        if _sign == 0 && !((self.label.text as String?) == "全部") {
            // 如果本view在订阅频道，则从订阅数组移除，并加入到更多数组并记录到_array
            if _array == _viewArr11 {
                _viewArr11.removeObject(self)
                _viewArr22.insertObject(self, atIndex: _viewArr22.count)
                _array = _viewArr22
            } else if _array == _viewArr22 {
                // 如果本view在更多频道，则从更多数组移除，并加入到订阅数组并记录到_array
                _viewArr22.removeObject(self)
                _viewArr11.insertObject(self, atIndex: _viewArr11.count)
                _array = _viewArr11
            }
        }
        self.animationAction()
        _sign = 0
    }
    /** Touch view被按着移动*/
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("\(self.frame.origin.x), \(self.frame.origin.y)")
        _sign = 1;
        var touch:UITouch = touches.first as! UITouch
        var point: CGPoint = touch.locationInView(self.superview)
        if !((self.label.text as String?) == "全部") {
            // 覆盖移动时的图片
            self.label.backgroundColor = UIColor.clearColor()
            self.image = UIImage(named: "order_drag_move_bg.png")
            self.frame = CGRectMake(point.x - self._point.x, point.y - self._point.y, self.frame.size.width, self.frame.size.height)
            // 计算新的位置
            var newX:CGFloat = point.x - _point.x + KButtonWidth/2
            var newY:CGFloat = point.y - _point.y + KButtonHeight/2
            // 如果新的位置不存在订阅频道
            if !CGRectContainsPoint(_viewArr11.objectAtIndex(0).frame, CGPointMake(newX, newY)) {
                // 如果本view在更多频道数组
                if _array == _viewArr22 {
                    // 如果本view被移动到订阅频道
                    if self.buttonInArrayArea1(_viewArr11, point: point) {
                        // 计算应该插入的位置
                        var index: Int = Int((newX - KTableStartPointX) / KButtonWidth + (CGFloat(5) * ((newY - KTableStartPointY) / KButtonHeight)))
                        _array.removeObject(self)
                        if index < _viewArr11.count - 1{
                            _viewArr11.insertObject(self, atIndex: index)
                        } else {
                            _viewArr11.addObject(self)
                        }
                        _array = _viewArr11
                        self.animationAction1a()
                        self.animationAction2()
                    } else if (newY < (KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight) && !self.buttonInArrayArea1(_viewArr11, point: point)) {
                        _array.removeObject(self)
                        //_viewArr11.insertObject(self, atIndex: _viewArr11.count)
                        _viewArr11.addObject(self)
                        _array = _viewArr11
                        self.animationAction2()
                    } else if (self.buttonInArrayArea2(_viewArr22, point: point)) {
                        var index: Int = Int((newX - KTableStartPointX) / KButtonWidth + CGFloat(5) * ((newY - self.array2StartY() * KButtonHeight - KTableStartPointY - KDeltaHeight) / KButtonHeight))
                        _array.removeObject(self)
                        if index < _viewArr22.count - 1{
                            _viewArr22.insertObject(self, atIndex: index)
                        } else {
                            _viewArr22.addObject(self)
                        }
                        //_viewArr22.insertObject(self, atIndex: index)
                        self.animationAction2a()
                    } else if (newY > (KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight) && !self.buttonInArrayArea2(_viewArr22, point: point)) {
                        _array.removeObject(self)
                        //_viewArr22.insertObject(self, atIndex: _viewArr22.count)
                        _viewArr22.addObject(self)
                        self.animationAction2a()
                    }
                } else if _array == _viewArr11 {
                    // 如果本view被移动到订阅频道
                    if self.buttonInArrayArea1(_viewArr11, point: point) {
                        // 计算应该插入的位置
                        var index: Int = Int((newX - KTableStartPointX) / KButtonWidth + (CGFloat(5) * ((newY - KTableStartPointY) / KButtonHeight)))
                        _array.removeObject(self)
                        //_viewArr11.insertObject(self, atIndex: index)
                        if index < _viewArr11.count - 1{
                            _viewArr11.insertObject(self, atIndex: index)
                        } else {
                            _viewArr11.addObject(self)
                        }
                        _array = _viewArr11
                        self.animationAction1a()
                        self.animationAction2()
                    } else if (newY < (KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight) && !self.buttonInArrayArea1(_viewArr11, point: point)) {
                        _array.removeObject(self)
                        //_viewArr11.insertObject(self, atIndex: _array.count)
                        _viewArr11.addObject(self)
                        self.animationAction1a()
                        self.animationAction2()
                    } else if (self.buttonInArrayArea2(_viewArr22, point: point)) {
                        var index: Int = Int((newX - KTableStartPointX) / KButtonWidth + CGFloat(5) * ((newY - self.array2StartY() * KButtonHeight - KTableStartPointY - KDeltaHeight) / KButtonHeight))
                        _array.removeObject(self)
                        //_viewArr22.insertObject(self, atIndex: index)
                        if index < _viewArr22.count - 1{
                            _viewArr22.insertObject(self, atIndex: index)
                        } else {
                            _viewArr22.addObject(self)
                        }
                        _array = _viewArr22
                        self.animationAction2a()
                    } else if (newY > (KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight) && !self.buttonInArrayArea2(_viewArr22, point: point)) {
                        _array.removeObject(self)
                        //_viewArr22.insertObject(self, atIndex: _viewArr22.count)
                        _viewArr22.addObject(self)
                        _array = _viewArr22
                        self.animationAction2a()
                    }
                }
            }
        }
    }
    
    func animationAction1() {
        for var i = 0; i < _viewArr11.count; i++ {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                var touchedView = self._viewArr11.objectAtIndex(i) as! TouchView
                var column = i%5
                var row = i/5
                touchedView.frame = self.makeTouchedViewFrameToArea1(column, row: row)
                }, completion: { (Bool) in
            })
        }
        animationActionMoreChannelsLabel()
    }
    
    func animationAction1a() {
        for var i = 0; i < _viewArr11.count; i++ {
            if _viewArr11.objectAtIndex(i) as! TouchView != self {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                    var touchedView = self._viewArr11.objectAtIndex(i) as! TouchView
                    var column = i%5
                    var row = i/5
                    touchedView.frame = self.makeTouchedViewFrameToArea1(column, row: row)
                    }, completion: { (Bool) in
                })
            }
        }
        animationActionMoreChannelsLabel()
    }
    
    func animationAction2() {
        for var i = 0; i < _viewArr22.count; i++ {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                var touchedView = self._viewArr22.objectAtIndex(i) as! TouchView
                var column = i%5
                var row = i/5
                touchedView.frame = self.makeTouchedViewFrameToArea2(column, row: row)
                }, completion: { (Bool) in
            })
        }
        animationActionMoreChannelsLabel()
    }
    
    func animationAction2a() {
        for var i = 0; i < _viewArr22.count; i++ {
            if _viewArr22.objectAtIndex(i) as! TouchView != self {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                    var touchedView = self._viewArr22.objectAtIndex(i) as! TouchView
                    var column = i%5
                    var row = i/5
                    touchedView.frame = self.makeTouchedViewFrameToArea2(column, row: row)
                    }, completion: { (Bool) in
                })
            }
        }
        animationActionMoreChannelsLabel()
    }
    
    func animationActionLabel() {
        
    }
    /** 移动频道按钮动画*/
    func animationAction() {
        // 移动在订阅频道Section的
        for var i = 0; i < self._viewArr11.count; i++ {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                var touchedView = self._viewArr11.objectAtIndex(i) as! TouchView
                var column = i%5
                var row = i/5
                touchedView.frame = self.makeTouchedViewFrameToArea1(column, row: row)
                }, completion: { (Bool) in
            })
        }
        // 移动在更多频道Section的
        for var i = 0; i < self._viewArr22.count; i++ {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
                var touchedView = self._viewArr22.objectAtIndex(i) as! TouchView
                var column = i%5
                var row = i/5
                touchedView.frame = self.makeTouchedViewFrameToArea2(column, row: row)
                }, completion: { (Bool) in
            })
        }
        animationActionMoreChannelsLabel()
    }
    
    func animationActionMoreChannelsLabel() {
        // 移动更多频道Label，如果订阅频道行数改变
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: { () in
            self.moreChannelsLabel.frame = CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * (self.array2StartY() - CGFloat(1)) + KMoreChannelDeltaHeight, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)
            }, completion: { (Bool) in
        })
    }
    
    func makeTouchedViewFrameToArea1(column: Int, row: Int) -> CGRect{
        return CGRectMake(KTableStartPointX + CGFloat(column) * KButtonWidth, KTableStartPointY + CGFloat(row) * KButtonHeight, KButtonWidth, KButtonHeight)
    }
    
    func makeTouchedViewFrameToArea2(column: Int, row: Int) -> CGRect{
        return CGRectMake(KTableStartPointX + CGFloat(column) * KButtonWidth, KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight  + CGFloat(row) * KButtonHeight, KButtonWidth, KButtonHeight)
    }
    /** 检查button是否在订阅频道section*/
    func buttonInArrayArea1(arr: NSMutableArray, point: CGPoint) -> Bool {
        // 计算新位置
        var newX: CGFloat = point.x - _point.x + KButtonWidth/2
        var newY: CGFloat = point.y - _point.y + KButtonHeight/2
        // 计算列数
        var a: Int = arr.count%5
        // 计算行数
        var b: Int = arr.count/5
        // 检查X是否在table左X和右X之间
        var isNewXGreaterThanTableXLeft = newX > KTableStartPointX
        var isNewXLessThanTableXRight = newX < KTableStartPointX + 5 * KButtonWidth
        // 检查Y是否在table上Y和下Y之间
        var isNewYGreaterThanTableYTop = newY > KTableStartPointY
        var isNewYLessThanTableYBottom = newY < KTableStartPointY + CGFloat(b) * KButtonHeight
        // 若行未满5列，检查是否在最后一个Button的右X前面
        var isNewXLessThanLastButtonXRight = newX < KTableStartPointX + CGFloat(a) * KButtonWidth
        // 若最后一行为未满5列行，检查是否在该行的上Y和下Y之间
        var isNewYGreaterThanLastRowYTop = newY > KTableStartPointY + CGFloat(b) * KButtonHeight
        var isNewYLessThanLastRowYBottom = newY < KTableStartPointY + (CGFloat(b) + CGFloat(1)) * KButtonHeight
        if (isNewXGreaterThanTableXLeft && isNewXLessThanTableXRight && isNewYGreaterThanTableYTop && isNewYLessThanTableYBottom) || (isNewXGreaterThanTableXLeft && isNewXLessThanLastButtonXRight && isNewYGreaterThanLastRowYTop && isNewYLessThanLastRowYBottom) {
            return true
        }
        return false
    }
    /** 检查button是否在更多频道section*/
    func buttonInArrayArea2(arr: NSMutableArray, point: CGPoint) -> Bool {
        // 计算新位置
        var newX: CGFloat = point.x - _point.x + KButtonWidth/2
        var newY: CGFloat = point.y - _point.y + KButtonHeight/2
        // 计算列数
        var a: Int = arr.count%5
        // 计算行数
        var b: Int = arr.count/5
        // 检查X是否在table左X和右X之间
        var isNewXGreaterThanTableXLeft = newX > KTableStartPointX
        var isNewXLessThanTableXRight = newX < KTableStartPointX + 5 * KButtonWidth
        // 检查Y是否在table上Y和下Y之间
        var isNewYGreaterThanTableYTop = newY > KTableStartPointY + KDeltaHeight + self.array2StartY() * KButtonHeight
        var isNewYLessThanTableYBottom = newY < KTableStartPointY + KDeltaHeight + (CGFloat(b) + self.array2StartY()) * KButtonHeight
        // 若行未满5列，检查是否在最后一个Button的右X前面
        var isNewXLessThanLastButtonXRight = newX < KTableStartPointX + CGFloat(a) * KButtonWidth
        // 若最后一行为未满5列行，检查是否在该行的上Y和下Y之间
        var isNewYGreaterThanLastRowYTop = newY > KTableStartPointY + KDeltaHeight + (CGFloat(b) + self.array2StartY()) * KButtonHeight
        var isNewYLessThanLastRowYBottom = newY < KTableStartPointY + KDeltaHeight + (CGFloat(b) + self.array2StartY()+1) * KButtonHeight
        if (isNewXGreaterThanTableXLeft && isNewXLessThanTableXRight && isNewYGreaterThanTableYTop && isNewYLessThanTableYBottom) || (isNewXGreaterThanTableXLeft && isNewXLessThanLastButtonXRight && isNewYGreaterThanLastRowYTop && isNewYLessThanLastRowYBottom) {
            return true
        }
        return false
    }
    /** 计算更多频道开始的Y*/
    func array2StartY() -> CGFloat {
        var y = 0;
        
        y = _viewArr11.count/5 + 2
        
        if _viewArr11.count % 5 == 0 {
            y -= 1
        }
        return CGFloat(y)
    }
    /*func array2StartY() -> CUnsignedLong {
        var y: CUnsignedLong = 0;
        
        y = (_viewArr11.count as NSNumber).unsignedLongValue / 5 + 2
        
        if _viewArr11.count % 5 == 0 {
            y -= 1
        }
        return y
    }*/
    func indexOfSelfInSubviews() -> Int{
        //var touchView = TouchView(frame: CGRectMake(0, 0, 0, 0))
        //var views = self.superview?.subviews as! [TouchView]
        //var arr = [1, 2, 3]
        //println("\(_stdlib_getDemangledTypeName(touchView))")
        var index = 0
        for v in self.superview!.subviews {
            if v is TouchView {
                let touchView = v as! TouchView
                if touchView == self {
                    println("self index = \(index)")
                    return index
                }
            }
            index++
        }
        return index
    }
}