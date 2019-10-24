//
//  LXPageViewController.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import Foundation
import UIKit

protocol LXPageViewControllerDelegate: NSObjectProtocol {
    func lxPageViewController(_ viewController: LXPageViewController, scrollViewDidScroll scrollView: UIScrollView)
    func lxPageViewController(_ viewController: LXPageViewController, mainScrollViewDidScroll scrollView: UIScrollView)
}

class LXPageViewController: UIViewController {

    weak var delegate: LXPageViewControllerDelegate?
    private var viewControllers = [LXChildViewController]()
    private var headerView: UIView!
    private var pageTitleView: UIView!
    private var currentIndex: Int = 0
    private var viewHeight: CGFloat = 0
    private var mainScrollView: LXPageScrollView!
    private var pageScrollView: UIScrollView!

    func move(toIndex: Int, animated: Bool = false) {
        viewControllers.forEach { $0.isCanScroll = true }
        pageScrollView.setContentOffset(CGPoint(x: CGFloat(toIndex) * view.frame.width, y: 0), animated: animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.scrollViewDidEndDecelerating(self.pageScrollView)
        }
    }

//    func setChildVCTabelHeight(height: CGFloat) {
//        viewControllers.forEach {
//            $0.tableViewHeight = height
//            $0.offsetY = 0
//        }
//    }
    
    init(viewControllers: [LXChildViewController], headerView: UIView, pageTitleView: UIView, viewHeight: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.headerView = headerView
        self.pageTitleView = pageTitleView
        self.viewHeight = viewHeight
        view.frame.size = CGSize(width: view.frame.width, height: self.viewHeight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainScrollView.frame = view.bounds
        mainScrollView.contentSize = CGSize(width: 0, height: mainScrollView.frame.height + headerView.frame.height-Const.kNavBarHeight)
        pageTitleView.frame.origin.y = headerView.frame.maxY
        pageScrollView.frame.origin.y = pageTitleView.frame.maxY
        pageScrollView.frame.size = CGSize(width: view.frame.width, height: mainScrollView.contentSize.height - pageTitleView.frame.maxY)
        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(viewControllers.count), height: 0)
        for index in 0..<viewControllers.count {
            let child = viewControllers[index]
            child.scrollDelegate = self
            pageScrollView.addSubview(child.view)
            child.view.frame = CGRect(x: CGFloat(index) * view.frame.width, y: 0, width: view.frame.width, height: viewHeight-Const.kNavBarHeight-pageTitleView.frame.height)
            child.tableViewHeight = viewHeight-Const.kNavBarHeight-pageTitleView.frame.height
            addChild(child)
        }
    }
    
    deinit {
        
    }
}

extension LXPageViewController {
    private func prepareView() {
        mainScrollView = LXPageScrollView()
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        
        mainScrollView.showsVerticalScrollIndicator = false
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerView)
        mainScrollView.addSubview(pageTitleView)

        pageScrollView = UIScrollView()
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.isPagingEnabled = true
        pageScrollView.delegate = self
        pageScrollView.backgroundColor = .white
        mainScrollView.addSubview(pageScrollView)
//        for child in viewControllers {
//            child.scrollDelegate = self
//            pageScrollView.addSubview(child.view)
//            addChild(child)
//        }
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension LXPageViewController: LXChildViewControllerDelegate {
    func lxChildViewController(_ viewController: LXChildViewController, scrollViewDidScroll scrollView: UIScrollView) {
        if mainScrollView.contentOffset.y < headerView.frame.height - Const.kNavBarHeight, mainScrollView.contentOffset.y > 0 {
            let child = viewControllers[currentIndex]
            child.offsetY = 0
        } 
    }
}

extension LXPageViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageScrollView.isScrollEnabled = true
        mainScrollView.isScrollEnabled = true

        if scrollView == pageScrollView {
            currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5) % viewControllers.count
        }
        
//        if scrollView == mainScrollView {
//            if scrollView.contentOffset.y >= headerView.frame.height-Const.kNavBarHeight {
//                scrollView.contentOffset = CGPoint(x: 0, y: headerView.frame.height-Const.kNavBarHeight)
//            }
//        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScrollView {
            pageScrollView.isScrollEnabled = false
            let child = viewControllers[currentIndex]
            if child.offsetY > 0 {
                scrollView.contentOffset = CGPoint(x: 0, y: headerView.frame.height-Const.kNavBarHeight)
            } else {
                viewControllers.forEach { $0.offsetY = 0 }
                delegate?.lxPageViewController(self, mainScrollViewDidScroll: scrollView)
            }
        } else if scrollView == pageScrollView {
            mainScrollView.isScrollEnabled = false
            delegate?.lxPageViewController(self, scrollViewDidScroll: scrollView)
        }
    }
}

final class LXPageScrollView: UIScrollView, UIGestureRecognizerDelegate {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
