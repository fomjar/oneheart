//
//  ViewSign.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewSign: Fui.FView {
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.fitScreen()
        self.backgroundColor = UIColor.red
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
//            if !Model.user.valid() {
//            }
            self.hide(style: .coverBottom)
        }
    }

}
