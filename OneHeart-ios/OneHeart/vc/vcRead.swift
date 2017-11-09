//
//  vcRead.swift
//  OneHeart
//
//  Created by 杜逢佳 on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class vcRead: UIViewController {
    
    @IBOutlet weak var vRead    : UIView!
    @IBOutlet weak var vWrite   : UIView!
    @IBOutlet weak var lcOffsetX: NSLayoutConstraint!
    @IBOutlet weak var tfIntention  : UITextField!
    var vCurrent    : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(switchView)))
        self.vWrite.addGestureRecognizer(UITapGestureRecognizer(target: self.tfIntention, action: #selector(resignFirstResponder)))
        
        self.vCurrent = self.vRead
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var panBegan    : CGFloat?
    var switchValue = CGFloat(8)
    var switchTime  = Double(0.4)
    
    @objc private func switchView(gesture: UIPanGestureRecognizer) {
        let p = gesture.translation(in: self.view)
        switch gesture.state {
        case .began:
            self.panBegan = self.vRead.frame.origin.x
        case .changed:
            var left = self.panBegan! + p.x
            if left < -self.vRead.frame.width
                {left = -self.vRead.frame.width}
            if left > 0
                {left = 0}
            self.lcOffsetX.constant = left
        case .ended:
            switch self.vCurrent! {
            case self.vRead!:
                if -self.vRead.frame.origin.x * self.switchValue > self.vRead.frame.width
                    {self.switchToWrite()}
                else
                    {self.switchToRead()}
            case self.vWrite!:
                if -self.vRead.frame.origin.x / (self.switchValue - 1) * self.switchValue < self.vRead.frame.width
                    {self.switchToRead()}
                else
                    {self.switchToWrite()}
            default:
                print()
            }
        default:
            print()
        }
    }
    
    private func switchToRead() {
        self.vCurrent = self.vRead
        self.lcOffsetX.constant = 0
        UIView.animate(withDuration: TimeInterval(switchTime), animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func switchToWrite() {
        self.vCurrent = self.vWrite
        self.lcOffsetX.constant = -self.vRead.frame.width
        UIView.animate(withDuration: TimeInterval(switchTime), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func sendIntention(_ sender: Any) {
        Net("/config/get")
        .jsonBody(key: "keys", val: [])
        .post {(code, desc, data) in
        }
    }
    
}
