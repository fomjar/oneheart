//
//  Launch.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewLaunch: Fui.FView {
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.fitScreen()
        
        let label = UILabel(frame: CGRect(x: 0, y: self.frame.height / 8, width: self.frame.width, height: self.frame.height / 2))
        label.text = "一 心 一 意"
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        self.addSubview(label)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {_ in
            let parent = self.superview
            self.hide {
                ViewRead().show(on: parent)
            }
        }
    }
    
}
