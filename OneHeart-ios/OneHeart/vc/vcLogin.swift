//
//  ViewController.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class vcLogin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBAction func login(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: {_ in
            self.performSegue(withIdentifier: "login_read", sender: self)
        })
    }
    
}

