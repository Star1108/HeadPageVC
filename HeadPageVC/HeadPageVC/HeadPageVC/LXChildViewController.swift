//
//  LXChildViewController.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import Foundation
import UIKit

protocol LXChildViewControllerDelegate: NSObjectProtocol {
    func lxChildViewController(_ viewController: LXChildViewController, scrollViewDidScroll scrollView: UIScrollView)
}

class LXChildViewController: UIViewController {
    public var tableViewHeight: CGFloat = 0.0
    public var offsetY: CGFloat = 0.0
    public var isCanScroll: Bool = false
    public weak var scrollDelegate: LXChildViewControllerDelegate?
}
