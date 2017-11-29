//
//  ViewRead.swift
//  oneheart
//
//  Created by fomjar on 2017/11/28.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewRead: FUI.FView {
    
    private var label   : UILabel!

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.label = UILabel()
        self.addSubview(self.label)
    }
    
    func read() {
        let hud = FUI.FHUD(mask: 0, rect: 0)
        hud.styleActivityIndicator()
        hud.show(on: self)
        FNet.post(path: "/intention/read", jsonParam: [
            "user" : Model.user.id,
            ]) {(code, desc, data) in
                hud.hide()
                if let code = code {
                    switch code {
                    case Code.success:
                        print("查询成功")
                    default:
                        print("查询失败：\(desc)")
                    }
                }
        }
    }

}
