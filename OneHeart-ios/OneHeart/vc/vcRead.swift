//
//  vcRead.swift
//  OneHeart
//
//  Created by 杜逢佳 on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class vcRead: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(switchView))
        gesture.direction = .left
        self.view.addGestureRecognizer(gesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func switchView(gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "read_write", sender: self)
    }
    
    @IBAction func unwindView(segue: UIStoryboardSegue) {
    }

}
