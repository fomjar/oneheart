//
//  ViewRead.swift
//  oneheart
//
//  Created by fomjar on 2017/11/28.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit
import fcore

class ViewRead: fui.View {
    
    private var intention   : UILabel!

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.intention = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width * 0.7, height: self.frame.height * 0.6))
        self.intention.center = self.center
        self.addSubview(self.intention)
    }
    
    func read() {
        let hud = fui.HUD(mask: 0, rect: 0)
        hud.styleActivityIndicator()
        hud.show(on: self)
        fnet.post(path: "/intention/read", jsonParam: [
            "user" : Model.user.id,
            ]) {(code, desc, data) in
                hud.hide()
                switch code {
                case fnet.code.success:
                    let array = data["intentions"] as! Array<[String:Any]>
                    for item in array {
                        self.intention.text = item["intention"] as? String
                    }
                    self.intention.adjustsFontSizeToFitWidth = true
                    print("查询成功")
                default:
                    print("查询失败：\(desc)")
                }
        }
    }

}
