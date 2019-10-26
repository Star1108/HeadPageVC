# HeadPageVC
    一款带有头视图，且子控制器可以下拉刷新的分页控制器
![图片名称](https://github.com/alwayns/HeadPageVC/blob/HeadPageVC/pagevc.gif) 

## 使用方法
### 子控制器：
1.继承LXChildViewController\n
2.重写父类属性\n
    'override var offsetY: CGFloat {
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
    }'
3.实现代理方法\n
    'func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.lxChildViewController(self, scrollViewDidScroll: scrollView)
    }'

