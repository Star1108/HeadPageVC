//
//  AppDelegate.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let nav = UINavigationController.init(rootViewController: ViewController.init())
        nav.modalPresentationStyle = .fullScreen
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
        return true
    }
}

