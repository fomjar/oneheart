//
//  futil.swift
//  fios
//
//  Created by 杜逢佳 on 2017/11/18.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

public typealias fblock = () -> Void

public class futil {
    
    public class func async(_ delay : TimeInterval  = 0,
                            block   : fblock?       = nil) {
        Timer.scheduledTimer(withTimeInterval: delay,
                             repeats         : false) {_ in
            block?()
        }
    }
    
    public class func async(delay   : TimeInterval  = 0,
                            interval: TimeInterval  = 0,
                            blocks  : [fblock]      = []) {
        if blocks.isEmpty {
            return
        }
        futil.async(-1 == delay ? interval : delay) {
            blocks[0]()
            futil.async(delay   : -1,
                        interval: interval,
                        blocks  : Array(blocks[1..<blocks.count]))
        }
    }
}
