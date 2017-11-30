//
//  ViewRead.swift
//  oneheart
//
//  Created by fomjar on 2017/11/28.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewRead: FUI.View {
    
    private var intention   : UILabel!

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.intention = UILabel()
        self.addSubview(self.intention)
    }
    
    func read() {
        let hud = FUI.HUD(mask: 0, rect: 0)
        hud.styleActivityIndicator()
        hud.show(on: self)
        FNet.post(path: "/intention/read", jsonParam: [
            "user" : Model.user.id,
            ]) {(code, desc, data) in
                hud.hide()
                switch code {
                case FNet.Code.success:
                    let intentions = data["intentions"] as Array
                    print("查询成功")
                default:
                    print("查询失败：\(desc)")
                }
        }
    }

}
