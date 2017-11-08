//
//  vcLaunch.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class vcLaunch: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(3), repeats: false, block: {_ in
            self.performSegue(withIdentifier: "launch_login", sender: self)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
