//
//  ViewSign.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit
import fcore

class ViewSign: fui.View {
    
    private var inTitle : UILabel!
    private var inMail  : UITextField!
    private var inPass  : UITextField!
    private var inSubmit: UIButton!
    private var inSwitch: UIButton!
    
    private var upTitle : UILabel!
    private var upMail  : UITextField!
    private var upPass  : UITextField!
    private var upSubmit: UIButton!
    private var upSwitch: UIButton!

    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        self.backgroundColor = UIColor.white
        
        self.inTitle = UILabel()
        self.inTitle.frame = CGRect(x: 0, y: self.frame.height / 4, width: self.frame.width, height: 40)
        self.inTitle.text = "登    陆"
        self.inTitle.font = self.inTitle.font.withSize(self.inTitle.frame.height)
        self.inTitle.textAlignment = .center
        self.inMail = UITextField()
        self.inMail.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.6, height: 36)
        self.inMail.center.x = self.center.x
        self.inMail.center.y = self.frame.height * 2 / 3
        self.inMail.placeholder = "输入邮箱"
        self.inPass = UITextField()
        self.inPass.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.6, height: 36)
        self.inPass.center.x = self.center.x
        self.inPass.center.y = self.frame.height * 2 / 3 + 40
        self.inPass.placeholder = "输入密码"
        self.inSubmit = UIButton(type: .system)
        self.inSubmit.setTitle("登陆", for: .normal)
        self.inSubmit.frame = CGRect(x: 0, y: 0, width: 32, height: 16)
        self.inSubmit.center.x = self.center.x - 30
        self.inSubmit.center.y = self.frame.height * 2 / 3 + 100
        self.inSwitch = UIButton(type: .system)
        self.inSwitch.setTitle("新用户", for: .normal)
        self.inSwitch.frame = CGRect(x: 0, y: 0, width: 48, height: 16)
        self.inSwitch.center.x = self.center.x + 30
        self.inSwitch.center.y = self.frame.height * 2 / 3 + 100
        
        self.upTitle = UILabel()
        self.upTitle.frame = CGRect(x: 0, y: self.frame.height / 4, width: self.frame.width, height: 40)
        self.upTitle.text = "注    册"
        self.upTitle.font = self.upTitle.font.withSize(self.upTitle.frame.height)
        self.upTitle.textAlignment = .center
        self.upMail = UITextField()
        self.upMail.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.6, height: 36)
        self.upMail.center.x = self.center.x
        self.upMail.center.y = self.frame.height * 2 / 3
        self.upMail.placeholder = "输入邮箱"
        self.upPass = UITextField()
        self.upPass.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.6, height: 36)
        self.upPass.center.x = self.center.x
        self.upPass.center.y = self.frame.height * 2 / 3 + 40
        self.upPass.placeholder = "输入密码"
        self.upSubmit = UIButton(type: .system)
        self.upSubmit.setTitle("注册", for: .normal)
        self.upSubmit.frame = CGRect(x: 0, y: 0, width: 32, height: 16)
        self.upSubmit.center.x = self.center.x - 30
        self.upSubmit.center.y = self.frame.height * 2 / 3 + 100
        self.upSwitch = UIButton(type: .system)
        self.upSwitch.setTitle("老用户", for: .normal)
        self.upSwitch.frame = CGRect(x: 0, y: 0, width: 48, height: 16)
        self.upSwitch.center.x = self.center.x + 30
        self.upSwitch.center.y = self.frame.height * 2 / 3 + 100

        self.addSubview(self.inTitle)
        self.addSubview(self.inMail)
        self.addSubview(self.inPass)
        self.addSubview(self.inSubmit)
        self.addSubview(self.inSwitch)

        NotificationCenter.default.addObserver(self,
                                               selector : #selector(keyboardWillShow),
                                               name     :UIResponder.keyboardWillShowNotification,
                                               object   : nil)
        NotificationCenter.default.addObserver(self,
                                               selector : #selector(keyboardWillHide),
                                               name     :UIResponder.keyboardWillHideNotification,
                                               object   : nil)
        self.inSubmit.addTarget(self, action: #selector(submitIn), for: .touchUpInside)
        self.upSubmit.addTarget(self, action: #selector(submitUp), for: .touchUpInside)
        self.inSwitch.addTarget(self, action: #selector(switchToUp), for: .touchUpInside)
        self.upSwitch.addTarget(self, action: #selector(switchToIn), for: .touchUpInside)

        if nil != Model.user.mail
            && !Model.user.mail.isEmpty {
            self.inMail.text = Model.user.mail
            self.inPass.text = Model.user.pass
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inMail.resignFirstResponder()
        self.inPass.resignFirstResponder()
        self.upMail.resignFirstResponder()
        self.upPass.resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(n: Notification) {
        let userInfo = n.userInfo! as NSDictionary
        let value = userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let height = value.cgRectValue.height
        fui.animate {
            self.frame.origin.y = -height
        }
    }
    
    @objc private func keyboardWillHide() {
        fui.animate {
            self.frame.origin.y = 0
        }
    }
    
    @objc private func switchToUp() {
        let interval = 0.06
        futil.async(delay: 0, interval: interval, blocks: [
            {fui.hide(self.inTitle, style: .fadeLeft)},
            {fui.hide(self.inMail, style: .fadeLeft)},
            {fui.hide(self.inPass, style: .fadeLeft)},
            {
                fui.hide(self.inSubmit, style: .fadeLeft)
                fui.hide(self.inSwitch, style: .fadeLeft)
            },
        ])
        futil.async(delay: 0.6, interval: interval, blocks: [
            {fui.show(self.upTitle, on: self, style: .fadeRight)},
            {fui.show(self.upMail, on: self, style: .fadeRight)},
            {fui.show(self.upPass, on: self, style: .fadeRight)},
            {
                fui.show(self.upSubmit, on: self, style: .fadeRight)
                fui.show(self.upSwitch, on: self, style: .fadeRight)
            },
        ])
    }
    
    @objc private func switchToIn() {
        let interval = 0.06
        futil.async(delay: 0, interval: interval, blocks: [
            {fui.hide(self.upTitle, style: .fadeRight)},
            {fui.hide(self.upMail, style: .fadeRight)},
            {fui.hide(self.upPass, style: .fadeRight)},
            {
                fui.hide(self.upSubmit, style: .fadeRight)
                fui.hide(self.upSwitch, style: .fadeRight)
            },
        ])
        futil.async(delay: 0.6, interval: interval, blocks: [
            {fui.show(self.inTitle, on: self, style: .fadeLeft)},
            {fui.show(self.inMail, on: self, style: .fadeLeft)},
            {fui.show(self.inPass, on: self, style: .fadeLeft)},
            {
                fui.show(self.inSubmit, on: self, style: .fadeLeft)
                fui.show(self.inSwitch, on: self, style: .fadeLeft)
            },
        ])
    }
    
    @objc private func submitUp() {
        let hud = fui.HUD()
        hud.styleActivityIndicator()
        hud.show(on: self)
        fnet.post(path: "/user/signup", jsonParam: [
            "mail" : upMail.text!,
            "pass" : upPass.text!
        ]) {(code, desc, data) in
            hud.hide()
            switch code {
            case fnet.code.success:
                Model.user.save(data)
                print("注册成功：\(Model.user)")
                self.hide(style: .coverBottom)
            default:
                print("注册失败：\(desc)")
            }
        }
    }
    
    @objc private func submitIn() {
        let hud = fui.HUD()
        hud.styleActivityIndicator()
        hud.show(on: self)
        fnet.post(path: "/user/signin", jsonParam: [
            "mail" : inMail.text!,
            "pass" : inPass.text!
        ]) {(code, desc, data) in
            hud.hide()
            switch code {
            case fnet.code.success:
                Model.user.save(data)
                print("登陆成功：\(Model.user)")
                self.hide(style: .coverBottom)
            default:
                print("登陆失败：\(desc)")
            }
        }
    }

}
