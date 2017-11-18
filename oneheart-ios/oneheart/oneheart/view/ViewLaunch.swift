//
//  Launch.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewLaunch: FUI.FView {
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        let title = UILabel()
        title.frame = CGRect(x: 0, y: self.frame.height / 4, width: self.frame.width, height: 40)
        title.text  = "一  心  一  意"
        title.font  = title.font.withSize(title.frame.height)
        title.textAlignment = .center
        title.layer.opacity = 0
        self.addSubview(title)
        
        self.didShow {
            title.layer.opacity = 1
            FUI.show(title, style: .fadeBottom, with: 1, done: {
                FUtil.async(1) {
                    ViewRead().show(on: self.superview)
                    self.hide()
                }
            })
        }
    }
    
}