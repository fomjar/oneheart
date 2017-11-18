//
//  Futil.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/18.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

public typealias FBlock = () -> Void

public class FUtil {
    
    public class func async(_ delay: TimeInterval = 0, block: FBlock? = nil) {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: {_ in
            block?()
        })
    }
    
    public class func async(interval: TimeInterval = 0, blocks: [FBlock] = []) {
        
    }
    
}
