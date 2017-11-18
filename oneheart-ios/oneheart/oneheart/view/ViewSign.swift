//
//  ViewSign.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewSign: FUI.FView {
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.fitScreen()
        self.backgroundColor = UIColor.red
        
        FUtil.async(3) {
            //            if !Model.user.valid() {
            //            }
            self.hide(style: .coverBottom)
        }
    }

}
