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
        self.fitScreen()
        
        let label = UILabel(frame: CGRect(x: 0, y: self.frame.height / 4, width: self.frame.width, height: self.frame.height / 8))
        label.text = "一  心  一  意"
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.layer.opacity = 0
        self.addSubview(label)
        
        self.onShow {
            FUtil.async(1) {
                label.layer.opacity = 1
                FUI.show(label, style: .fadeBottom, with: 1)
                FUtil.async(2) {
                    let parent = self.superview
                    self.hide {
                        ViewRead().show(on: parent)
                    }
                }
            }
        }
    }
    
}
