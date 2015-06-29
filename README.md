# OrderButtonDemo

Swift版本的OrderButton的演示。<br>
Demo of Swift version OrderButton.<br>
Objective-C版本链接：<br>
Objective-C version: <a><herf="https://github.com/ppt04025/ifengNewsOrderDemo">https://github.com/ppt04025/ifengNewsOrderDemo</a><br>
因为上面大神的OC版本在Swift中遇到ARC问题，所以就尝试着重写一下到swift版本。<br>
Rewrite this into swift version because the Objective-C version can not use in swift app. Kinda ARC issue.

模拟器测试最低支持iOS7.1。
Test successfully on iOS7.1.

使用方法<br>
Usage:<br>
把OrderButton文件夹拖放到你的项目中就可以直接使用了。<br>
Drag and Drop the OrderButton folder into your project.<br>
在你需要使用Order button的view controller的文件里面添加一下代码，<br>
In the view controller that you wanna add this order button into it, add below codes.<br>
在viewDidLoad方法中初始化order button并添加到这个view里面<br>
In viewDidLoad, initialize the order button and add to the view.<br>
```
var orderButton: OrderButton = OrderButton.orderButtonWithViewController(self, titleArr: NSArray(array: KChannelList), urlStringArr: NSArray(array: KChannelUrlStringList)) as! OrderButton
self.view.addSubview(orderButton)
orderButton.addTarget(self, action: "orderViewOut:", forControlEvents: UIControlEvents.TouchUpInside)
```
创建order view并使之出现的方法。<br>
Function for creating the order view and slide out.<br>
```
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
```
使order view消失并返回root view。<br>
Function for dismissing the order view and returning to the root view.<br>
```
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
```
