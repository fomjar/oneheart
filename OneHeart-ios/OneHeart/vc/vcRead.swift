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
        vWrite.frame.origin.x = UIScreen.main.bounds.width
        self.switchToRead()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func switchView(gesture: UIPanGestureRecognizer) {
        let p = gesture.translation(in: self.view)
        switch gesture.state {
        case .changed:
            print()
        case .ended:
            print()
        default:
            print()
        }
    }
    
    private func switchToRead() {
        
    }

    private func switchToWrite() {
        
    }

}
