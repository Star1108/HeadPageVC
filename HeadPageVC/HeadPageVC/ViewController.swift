//
//  ViewController.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var headView: UIImageView?
    private var titleView: TitleView?
    private var pageVC: LXPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "测试PageVC"
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension ViewController {
    private func initUI() {
        headView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        headView?.image = UIImage.init(named: "headImage")
        
        titleView = TitleView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        titleView?.clickHandle = { [weak self] (btn) in
            self?.pageVC?.move(toIndex: btn.tag-1000, animated: false)
        }
        
        let controllers = [PageChildVC1.init(), PageChildVC2.init(), PageChildVC1.init()]
        pageVC = LXPageViewController.init(viewControllers: controllers, headerView: headView!, pageTitleView: titleView!, viewHeight: view.frame.height)
        pageVC!.delegate = self

        addChild(pageVC!)
        view.addSubview(pageVC!.view)
        titleView?.selectMenuIndex(index: 0)
    }
}

extension ViewController: LXPageViewControllerDelegate {
    func lxPageViewController(_ viewController: LXPageViewController, scrollViewDidScroll scrollView: UIScrollView) {
        titleView?.iteratorScroll(proportion: scrollView.contentOffset.x/view.frame.width)
        if scrollView.contentOffset.x == 2*view.frame.width {
            titleView?.selectMenuIndex(index: 2)
        } else if scrollView.contentOffset.x == view.frame.width {
            titleView?.selectMenuIndex(index: 1)
        } else if scrollView.contentOffset.x == 0 {
            titleView?.selectMenuIndex(index: 0)
        }
    }
    
    func lxPageViewController(_ viewController: LXPageViewController, mainScrollViewDidScroll scrollView: UIScrollView) {
        let alpha = scrollView.contentOffset.y/(headView!.frame.height-Const.kNavBarHeight)
        self.navigationController?.navigationBar.alpha = alpha
    }
}
