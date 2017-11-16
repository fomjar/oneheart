//
//  Fui.swift
//  oneheart
//
//  Created by fomjar on 2017/11/16.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit


public protocol Fview {
    func show(on: UIView, by: TimeInterval, done: (() -> Void)?)
    func hide(by: TimeInterval, done: (() -> Void)?)
}

extension Fview where Self: UIView {
    
    public func show(on: UIView, by: TimeInterval = 0, done: (() -> Void)? = nil) {
        if 0 == by {
            on.addSubview(self)
            done?()
        } else {
            let opacity = self.layer.opacity
            self.layer.opacity = 0
            
            on.addSubview(self)
            UIView.animate(withDuration: by, animations: {
                self.layer.opacity = opacity
            }, completion: {_ in done?()})
        }
    }
    
    public func hide(by: TimeInterval = 0, done: (() -> Void)? = nil) {
        if 0 == by {
            self.removeFromSuperview()
            done?()
        } else {
            let opacity = self.layer.opacity
            UIView.animate(withDuration: by, animations: {
                self.layer.opacity = 0
            }, completion: {_ in
                self.removeFromSuperview()
                self.layer.opacity = opacity
                done?()
            })
        }
    }
}


public class Fui {
    
    public class Fmask: UIView, Fview {
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        init(color: UIColor = .black, opacity: Float = 0) {
            super.init(frame: UIScreen.main.bounds)
            
            self.backgroundColor    = color
            self.layer.opacity      = opacity
        }
        
    }
    
    public class HUD: UIView, Fview {
        
        public enum HUDtype {
            case ActivityIndicator
        }
        
        private var fmask   : Fmask!
        private var vAI     : UIActivityIndicatorView?
        
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        init(type: HUDtype) {
            super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            self.fmask = Fmask(opacity: 0.1)
            
            self.addSubview(self.fmask)
            
            self.applyType(type)
        }
        
        private func applyType(_ type: HUDtype) {
            CGRect screen = UIScreen.main.bounds
            
            switch type {
            case .ActivityIndicator:
                vAI = vAI ?? UIActivityIndicatorView(activityIndicatorStyle: .white)
                self.layer.cornerRadius     = 8
                self.layer.masksToBounds    = true
            default:
                print()
            }
        }
    }
    
}

