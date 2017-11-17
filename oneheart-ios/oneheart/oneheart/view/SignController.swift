//
//  ViewController.swift
//  oneheart
//
//  Created by fomjar on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class SignController: UIViewController {

    @IBOutlet weak var tfInMail: UITextField!
    @IBOutlet weak var tfInPass: UITextField!
    @IBOutlet weak var tfUpMail: UITextField!
    @IBOutlet weak var tfUpPass: UITextField!
    @IBOutlet weak var vIn: UIView!
    @IBOutlet weak var vUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)

        if nil != Model.user.mail
            && !Model.user.mail.isEmpty {
            self.vUp.layer.opacity = 0
            self.tfInMail.text = Model.user.mail
            self.tfInPass.text = Model.user.pass
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tfInMail.resignFirstResponder()
        self.tfInPass.resignFirstResponder()
        self.tfUpMail.resignFirstResponder()
        self.tfUpPass.resignFirstResponder()
    }
    
    @objc private func keyboardShow(n: Notification) {
        let userInfo = n.userInfo! as NSDictionary
        let value = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let height = value.cgRectValue.height
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = -height
        }
    }
    
    @objc private func keyboardHide() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func vInSubmit(_ sender: Any) {
        Fnet.post(path: "/user/signin", jsonParam: [
            "mail" : tfInMail.text!,
            "pass" : tfInPass.text!
        ]) {(code, desc, data) in
            switch Code(rawValue: code)! {
            case Code.success:
                Model.user.save(data)
                print("登录成功：\(Model.user)")
                self.dismiss(animated: true, completion: nil)
            default:
                print("登录失败：\(desc)")
            }
        }
    }
    
    @IBAction func vInSwitch(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.vUp.layer.opacity = 1
        }
    }
    
    @IBAction func vUpSubmit(_ sender: Any) {
        Fnet.post(path: "/user/signup", jsonParam: [
            "mail" : tfUpMail.text!,
            "pass" : tfUpPass.text!
        ]) {(code, desc, data) in
            switch Code(rawValue: code)! {
            case Code.success:
                Model.user.save(data)
                print("注册成功：\(Model.user)")
                self.dismiss(animated: true, completion: nil)
            default:
                print("注册失败：\(desc)")
            }
        }
    }
    
    @IBAction func vUpSwitch(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.vUp.layer.opacity = 0
        }
    }
    
}

