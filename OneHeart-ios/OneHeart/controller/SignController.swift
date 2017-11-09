//
//  ViewController.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/7.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

class SignController: UIViewController {

    @IBOutlet weak var vUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func vInSubmit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func vInSwitch(_ sender: Any) {
    }
    
    @IBAction func vUpSubmit(_ sender: Any) {
    }
    
    @IBAction func vUpSwitch(_ sender: Any) {
        UIView.animate(withDuration: TimeInterval(0.5)) {
            self.vUp.isHidden = true
        }
    }
    
}

