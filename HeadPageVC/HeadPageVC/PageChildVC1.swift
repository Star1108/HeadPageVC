//
//  PageChildVC.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import Foundation
import UIKit

class PageChildVC1: LXChildViewController {
    private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - ( 44.0+UIApplication.shared.statusBarFrame.height)-45), style: .plain)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
    
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
}

extension PageChildVC1: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.lxChildViewController(self, scrollViewDidScroll: scrollView)
    }
}
