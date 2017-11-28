//
//  ViewWrite.swift
//  oneheart
//
//  Created by fomjar on 2017/11/28.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class ViewWrite: FUI.FView {
    
    private var text    : UITextField!
    private var send    : UIButton!

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.backgroundColor = UIColor.lightGray
        
        self.text = UITextField()
        self.text.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.8, height: 36)
        self.text.borderStyle = .roundedRect
        self.text.placeholder = "请输入你的心意"
        self.text.textAlignment = .center
        self.text.center = self.center
        self.addSubview(self.text)
        
        self.send = UIButton(type: .system)
        self.send.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        self.send.center.x = self.text.center.x
        self.send.center.y = self.text.center.y + 60
        self.send.setTitle("发送", for: .normal)
        self.addSubview(self.send)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.text.resignFirstResponder()
    }
}
