//
//  ViewRead.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewRead: Fui.FView {
    
    private var pack        : Fui.FView!
    private var read        : Fui.FView!
    private var write       : Fui.FView!
    private var intention   : UITextField!
    private var send        : UIButton!
    private var load        : UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.fitScreen()
        
        self.read = Fui.FView()
        self.read.fitScreen()
        self.write = Fui.FView()
        self.write.fitScreen()
        
        self.load = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.load.center = self.read.center
        self.load.startAnimating()
        self.read.addSubview(load)
        
        self.intention = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width * 0.8, height: 40))
        self.intention.borderStyle = .roundedRect
        self.intention.placeholder = "请输入你的心意"
        self.intention.textAlignment = .center
        self.intention.center = self.write.center
        self.write.addSubview(self.intention)
        
        self.send = UIButton(type: .system)
        self.send.setTitle("发送", for: .normal)
        self.send.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        self.send.center.x = self.intention.center.x
        self.send.center.y = self.intention.center.y + 40
        self.write.addSubview(self.send)
        
        self.pack = Fui.packHorizontal([self.read, self.write])
        self.pack.autoSlide()
        self.addSubview(self.pack)

        self.onShow {
            let parent = self.superview
            if !Model.user.valid() {
                ViewSign().show(on: parent, style: .coverBottom)
                return
            }
            // request net data
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.intention.resignFirstResponder()
    }

}
