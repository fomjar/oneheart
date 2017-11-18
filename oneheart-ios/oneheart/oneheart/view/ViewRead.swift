//
//  ViewRead.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewRead: FUI.FView {
    
    private var pack            : FUI.FView!
    private var read            : FUI.FView!
    private var write           : FUI.FView!
    private var intentionRead   : UILabel!
    private var intentionWrite  : UITextField!
    private var send            : UIButton!
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.read = FUI.FView()
        self.read.frameScreen()
        self.write = FUI.FView()
        self.write.frameScreen()
        self.write.backgroundColor = UIColor.lightGray
        
        self.intentionRead = UILabel()
        
        self.intentionWrite = UITextField()
        self.intentionWrite.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.8, height: 36)
        self.intentionWrite.borderStyle = .roundedRect
        self.intentionWrite.placeholder = "请输入你的心意"
        self.intentionWrite.textAlignment = .center
        self.intentionWrite.center = self.write.center
        self.write.addSubview(self.intentionWrite)
        
        self.send = UIButton(type: .system)
        self.send.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        self.send.center.x = self.intentionWrite.center.x
        self.send.center.y = self.intentionWrite.center.y + 60
        self.send.setTitle("发送", for: .normal)
        self.write.addSubview(self.send)
        
        self.pack = FUI.packHorizontal([self.read, self.write])
        self.pack.toGallery()
        self.addSubview(self.pack)

        self.didShow {
//            if !Model.user.valid() {
            let sign = ViewSign()
            sign.show(on: self.superview, style: .coverBottom)
            sign.didHide {self.doRead()}
//            }
            
            // check and fill intension
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.intentionWrite.resignFirstResponder()
    }
    
    private func doRead() {
        let hud = FUI.FHUD(mask: 0, rect: 0)
        hud.styleActivityIndicator(.gray)
        hud.show(on: self.read)
        FNet.post(path: "/intention/read", jsonParam: [
            "uid" : Model.user.id,
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
