//
//  Fui.swift
//  oneheart
//
//  Created by fomjar on 2017/11/16.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

public class Fui {
    
    public enum SegueStyle {
        case fade
        case coverTop
        case coverLeft
        case coverBottom
        case coverRight
    }
    
    public static let ANIMATION_TIME = 0.8
    
    public class func animate(with: Double = Fui.ANIMATION_TIME, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        let springDamping   = CGFloat(1)
        let springVelocity  = CGFloat(4)
        UIView.animate(withDuration: with,
                       delay: 0,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: springVelocity,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: animations,
                       completion: completion)
    }

    public class func show(_ view: UIView, on: UIView? = nil, style: Fui.SegueStyle = .fade, with: TimeInterval = Fui.ANIMATION_TIME, done: (() -> Void)? = nil) {
        let parent = (on ?? view.superview)!
        if 0 == with {
            parent.addSubview(view)
            done?()
            return
        }
        switch style {
        case .fade:
            let opacity = view.layer.opacity
            view.layer.opacity = 0
            
            parent.addSubview(view)
            Fui.animate(with: with, animations: {view.layer.opacity = opacity}, completion: {_ in done?()})
        case .coverTop:
            let y = view.frame.origin.y
            view.frame.origin.y = -view.frame.height
            
            parent.addSubview(view)
            Fui.animate(with: with, animations: {view.frame.origin.y = y}, completion: {_ in done?()})
        case .coverLeft:
            let x = view.frame.origin.x
            view.frame.origin.x = -view.frame.width
            
            parent.addSubview(view)
            Fui.animate(with: with, animations: {view.frame.origin.x = x}, completion: {_ in done?()})
        case .coverBottom:
            let y = view.frame.origin.y
            view.frame.origin.y = parent.frame.height
            
            parent.addSubview(view)
            Fui.animate(with: with, animations: {view.frame.origin.y = y}, completion: {_ in done?()})
        case .coverRight:
            let x = view.frame.origin.x
            view.frame.origin.x = parent.frame.width
            
            parent.addSubview(view)
            Fui.animate(with: with, animations: {view.frame.origin.x = x}, completion: {_ in done?()})
        }
    }
    
    public class func hide(_ view: UIView, style: Fui.SegueStyle = .fade, with: TimeInterval = Fui.ANIMATION_TIME, done: (() -> Void)? = nil) {
        let parent = view.superview!
        if 0 == with {
            view.removeFromSuperview()
            done?()
            return
        }
        switch style {
        case .fade:
            let opacity = view.layer.opacity
            Fui.animate(with: with, animations: {
                view.layer.opacity = 0
            }, completion: {_ in
                view.removeFromSuperview()
                view.layer.opacity = opacity
                done?()
            })
        case .coverTop:
            let y = view.frame.origin.y
            Fui.animate(with: with, animations: {
                view.frame.origin.y = -view.frame.height
            }, completion: {_ in
                view.removeFromSuperview()
                view.frame.origin.y = y
                done?()
            })
        case .coverLeft:
            let x = view.frame.origin.x
            Fui.animate(with: with, animations: {
                view.frame.origin.x = -view.frame.width
            }, completion: {_ in
                view.removeFromSuperview()
                view.frame.origin.x = x
                done?()
            })
        case .coverBottom:
            let y = view.frame.origin.y
            Fui.animate(with: with, animations: {
                view.frame.origin.y = parent.frame.height
            }, completion: {_ in
                view.removeFromSuperview()
                view.frame.origin.y = y
                done?()
            })
        case .coverRight:
            let x = view.frame.origin.x
            Fui.animate(with: with, animations: {
                view.frame.origin.x = parent.frame.width
            }, completion: {_ in
                view.removeFromSuperview()
                view.frame.origin.x = x
                done?()
            })
        }
    }
    
    public class func packPadding(_ view: UIView,
                                  top   : CGFloat = 0,
                                  left  : CGFloat = 0,
                                  bottom: CGFloat = 0,
                                  right : CGFloat = 0) -> FView {
        let pack = FView(frame: CGRect(x: view.frame.origin.x,
                                        y: view.frame.origin.y,
                                        width   : view.frame.width + left + right,
                                        height  : view.frame.height + top + bottom))
        view.frame = CGRect(x: left,
                            y: top,
                            width   : view.frame.width,
                            height  : view.frame.height)
        pack.addSubview(view)
        return pack
    }
    
    public class func packMargin(_ view: UIView,
                                  top   : CGFloat = 0,
                                  left  : CGFloat = 0,
                                  bottom: CGFloat = 0,
                                  right : CGFloat = 0) -> FView {
        let pack = FView(frame: CGRect(x: view.frame.origin.x - left,
                                        y: view.frame.origin.y - top,
                                        width   : view.frame.width + left + right,
                                        height  : view.frame.height + top + bottom))
        view.frame = CGRect(x: left,
                            y: top,
                            width   : view.frame.width,
                            height  : view.frame.height)
        pack.addSubview(view)
        return pack
    }

    public class func packHorizontal(_ views: [UIView]) -> FView {
        var width   = CGFloat();
        var height  = CGFloat();
        for view in views {
            width   = width + view.frame.width
            height  = max(height, view.frame.height)
        }
        let pack = FView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        var currentWidth = CGFloat();
        for view in views {
            view.frame = CGRect(x: currentWidth, y: (height - view.frame.height) / 2, width: view.frame.width, height: view.frame.height)
            pack.addSubview(view)
            currentWidth = currentWidth + view.frame.width
        }
        return pack
    }

    public class func packVertical(_ views: [UIView]) -> FView {
        var width   = CGFloat();
        var height  = CGFloat();
        for view in views {
            width   = max(width, view.frame.width)
            height  = height + view.frame.height
        }
        let pack = FView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        var currentHeight = CGFloat();
        for view in views {
            view.frame = CGRect(x: (width - view.frame.width) / 2, y: currentHeight, width: view.frame.width, height: view.frame.height)
            pack.addSubview(view)
            currentHeight = currentHeight + view.frame.height
        }
        return pack
    }

    open class FView: UIView {
        
        private var onShow  : [() -> Void] = []
        private var onHide  : [() -> Void] = []
        
        public func show(on: UIView? = nil, style: Fui.SegueStyle = .fade, with: TimeInterval = 1, done: (() -> Void)? = nil) {
            Fui.show(self, on: on, style: style, with: with, done: done)
            for block in onShow {
                block()
            }
        }
        public func hide(style: Fui.SegueStyle = .fade, with: TimeInterval = 1, done: (() -> Void)? = nil) {
            Fui.hide(self, style: style, with: with, done: {
                for block in self.onHide {
                    block()
                }
                done?()
            })
        }
        public func onShow(_ block: (() -> Void)?) {
            if let b = block {
                onShow.append(b)
            }
        }
        public func onHide(_ block: (() -> Void)?) {
            if let b = block {
                onHide.append(b)
            }
        }
        public func fitScreen() {
            self.frame = UIScreen.main.bounds
        }
        public func autoSlide() {
            self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(doAutoSlide)))
        }
        private var panBagan: CGPoint?
        @objc private func doAutoSlide(gesture: UIPanGestureRecognizer) {
            let parent  = self.superview!
            let point   = gesture.translation(in: parent)
            switch gesture.state {
            case .began:
                panBagan = CGPoint(x: self.frame.origin.x + point.x, y: self.frame.origin.y + point.y)
            case .changed:
                var left    = (self.panBagan?.x)! + point.x
                var top     = (self.panBagan?.y)! + point.y
                if left < 0 {
                    if left + self.frame.width < parent.frame.width {
                        left = parent.frame.width - self.frame.width
                    }
                } else {
                    left = 0
                }
                if top < 0 {
                    if top + self.frame.height < parent.frame.height {
                        top = parent.frame.height - self.frame.height
                    }
                } else {
                    top = 0
                }
                self.frame.origin.x = left
                self.frame.origin.y = top
            case .ended:
                let left    = (self.panBagan?.x)! + point.x
                let top     = (self.panBagan?.y)! + point.y
                var nearestView : UIView? = nil
                var distance    : CGFloat = CGFloat(MAXFLOAT)
                for view in self.subviews {
                    let currentDistance = sqrt(pow(parent.frame.width / 2 - (view.center.x + left), 2) + pow(parent.frame.height / 2 - (view.center.y + top), 2))
                    if currentDistance < distance {
                        distance = currentDistance
                        nearestView = view
                    }
                }
                if let view = nearestView {
                    Fui.animate(animations: {
                        self.frame.origin.x = parent.frame.width / 2 - view.center.x
                        self.frame.origin.y = parent.frame.height / 2 - view.center.y
                    })
                }
            default:
                print()
            }
        }
    }

    public class FMask: FView {
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        init(color: UIColor = .black, opacity: Float = 0) {
            super.init(frame: UIScreen.main.bounds)
            
            self.backgroundColor    = color
            self.layer.opacity      = opacity
        }
        
    }
    
    open class FHUD: FView {
        
        open var fmask  : FMask!
        open var frect  : FView!
        open var fpack  : FView?
        
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        init() {
            super.init(frame: UIScreen.main.bounds)
            
            self.fmask = FMask(opacity: 0.2)
            self.frect = FView()
            self.frect.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
            self.frect.layer.cornerRadius    = 12
            self.frect.layer.masksToBounds   = true

            self.addSubview(self.fmask)
            self.addSubview(self.frect)
        }
        
        public func packSubviews(_ views: [UIView]) {
            if let pack = self.fpack {
                pack.removeFromSuperview()
            }
            self.fpack = Fui.packPadding(Fui.packVertical(views), top: 4, left: 4, bottom: 4, right: 4)
            self.frect.addSubview(self.fpack!)
            self.frect.frame = (self.fpack?.frame)!
            self.frect.center = self.center
        }
        
        public func styleActivityIndicator() {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            self.onShow({indicator.startAnimating()})
            self.onHide({indicator.stopAnimating()})
            
            self.packSubviews([
                Fui.packPadding(indicator, top: 8, left: 8, bottom: 8, right: 8)
                ])
        }
    }
    
}

