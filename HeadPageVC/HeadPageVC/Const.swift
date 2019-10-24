//
//  Const.swift
//  ChalkTalks
//
//  Created by Cloud on 2019/9/3.
//  Copyright © 2019 何雨晴. All rights reserved.
//

import UIKit
import AdSupport

struct Const {
    /// 屏幕宽度
    static let kScreenWidth = UIScreen.main.bounds.size.width
    
    /// 屏幕高度
    static let kScreenHeight = UIScreen.main.bounds.size.height
    static let kScalWidth = (Const.kScreenWidth / 375) /// 宽度比
    static let kScalHeight = (Const.kScreenHeight / 667) /// 高度比
    
    /// 状态栏
    static let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
    
    /// navigationBar高度
    static let kNavBarHeight = 44.0+UIApplication.shared.statusBarFrame.height
    
    /// tabbar高度
    static let kTabBarHeight = CGFloat(isX ? 83.0 : 49.0)
    static let kBottomOffset = CGFloat(isX ? 34.0 : 0.0)
    static let isX: Bool = UIScreen.main.bounds.height >= 812
    static let isIphoneX = UIScreen.main.nativeBounds.size.height-2436 == 0
    static let isSmallIphone = UIScreen.main.bounds.size.height == 480
}

