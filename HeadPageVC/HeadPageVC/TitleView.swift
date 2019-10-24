//
//  TitleView.swift
//  HeadPageVC
//
//  Created by star on 2019/10/24.
//  Copyright © 2019 star. All rights reserved.
//

import Foundation
import UIKit
import Then
import Stevia

class TitleView: UIView {
    var clickHandle: ((UIButton) -> Void)?
    private var selectBtn: UIButton?
    private var dynamicBtn = UIButton.init().then {
        $0.setTitle("控制器1", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.setTitleColor(.black, for: .selected)
        $0.tag = 1000
    }

    private var answerBtn = UIButton.init().then {
        $0.setTitle("控制器2", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.setTitleColor(.black, for: .selected)
        $0.tag = 1001
    }
    
    private var questionBtn = UIButton.init().then {
        $0.setTitle("控制器3", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.setTitleColor(.black, for: .selected)
        $0.tag = 1002
    }
    
    private var iterator = UIView.init().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
    }
    
    private var line = UIView.init().then {
        $0.backgroundColor = .gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.sv(dynamicBtn, answerBtn, questionBtn, line)
        self.layout(
            0,
            |-dynamicBtn-answerBtn-questionBtn-|,
            0,
            |line| ~ 1,
            0
        )
        equal(widths: dynamicBtn, answerBtn, questionBtn)
        self.layoutIfNeeded()
        dynamicBtn.addTarget(self, action: #selector(clickBtn(btn:)), for: .touchUpInside)
        answerBtn.addTarget(self, action: #selector(clickBtn(btn:)), for: .touchUpInside)
        questionBtn.addTarget(self, action: #selector(clickBtn(btn:)), for: .touchUpInside)
        
        iterator.frame = CGRect(x: 0, y: self.frame.height-9, width: 20, height: 4)
        iterator.center = CGPoint(x: dynamicBtn.center.x, y: iterator.center.y)
        self.addSubview(iterator)
    }
    
    func selectMenuIndex(index: Int) {
        selectBtn?.isSelected = false
        selectBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let btn: UIButton = self.viewWithTag(1000+index) as! UIButton
        btn.isSelected = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        selectBtn = btn
        
        UIView.animate(withDuration: 0.2) {
            self.iterator.center = CGPoint(x: btn.center.x, y: self.iterator.center.y)
        }
    }
    
    func iteratorScroll(proportion: CGFloat) {
        let width = (questionBtn.center.x-dynamicBtn.center.x)/2.0
        self.iterator.center = CGPoint(x: dynamicBtn.center.x+proportion*width, y: self.iterator.center.y)
    }
    
    @objc private func clickBtn(btn: UIButton) {
        selectMenuIndex(index: btn.tag - 1000)
        if let block = clickHandle {
            block(btn)
        }
    }
}
