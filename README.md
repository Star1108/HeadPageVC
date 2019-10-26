# HeadPageVC
    一款带有头视图，且子控制器可以下拉刷新的分页控制器
![图片名称](https://github.com/alwayns/HeadPageVC/blob/HeadPageVC/pagevc.gif) 

## 使用方法
### PageVC
viewControllers:子控制器<br>
headerView:头视图<br>
pageTitleView:菜单栏<br>
viewHeight:pageVC高度，当底部有其他空间时，通过这个来控制<br>
'''
pageVC = LXPageViewController.init(viewControllers: controllers, headerView: headView!, pageTitleView: titleView!, viewHeight: view.frame.height)
pageVC!.delegate = self
addChild(pageVC!)
view.addSubview(pageVC!.view)
'''
### 子控制器：
1.继承LXChildViewController<br>
2.重写父类属性<br>
```
    override var offsetY: CGFloat {
        set {
            tableView!.contentOffset = CGPoint(x: 0, y: newValue)
        }
        get {
            return tableView!.contentOffset.y
        }
    }
    override var isCanScroll: Bool {
        didSet {
            if isCanScroll {
                tableView!.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
            }
        }
    }
```
3.实现代理方法<br>
```
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.lxChildViewController(self, scrollViewDidScroll: scrollView)
    }
 ```

