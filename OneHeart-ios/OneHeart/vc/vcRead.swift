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
    var vCurrent    : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(switchView)))
        self.vRead.frame.origin.x = 0
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
            self.vRead.frame.origin.x = left
            self.vWrite.frame.origin.x = left + self.vRead.frame.width
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
        UIView.animate(withDuration: TimeInterval(switchTime), animations: {
            self.vRead.frame.origin.x = 0
            self.vWrite.frame.origin.x = self.vRead.frame.width
        })
    }

    private func switchToWrite() {
        self.vCurrent = self.vWrite
        UIView.animate(withDuration: TimeInterval(switchTime), animations: {
            self.vRead.frame.origin.x = -self.vRead.frame.width
            self.vWrite.frame.origin.x = 0
        })
    }

}
