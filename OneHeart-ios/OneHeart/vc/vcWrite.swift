//
//  vcWrite.swift
//  OneHeart
//
//  Created by 杜逢佳 on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class vcWrite: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(unwindView))
        gesture.direction = .right
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func unwindView(gesture: UISwipeGestureRecognizer) {
    }

}
