//
//  Fui.swift
//  oneheart
//
//  Created by fomjar on 2017/11/16.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

public class FUI {
    
    public enum SegueStyle {
        case fade
        case fadeTop
        case fadeLeft
        case fadeBottom
        case fadeRight
        case coverTop
        case coverLeft
        case coverBottom
        case coverRight
    }
    
    public static let ANIMATION_TIME = 0.8
    public class func animate(_ with    : Double = FUI.ANIMATION_TIME,
                              animations: @escaping FBlock) {
        FUI.animate(with: with, animations: animations, completion: nil)
    }

    public class func animate(with      : Double = FUI.ANIMATION_TIME,
                              animations: @escaping FBlock,
                              completion: ((Bool) -> Void)? = nil) {
        let springDamping   = CGFloat(1)
        let springVelocity  = CGFloat(4)

        // ensure run at main thread
        UIView.animate(withDuration : with,
                       delay        : 0,
                       usingSpringWithDamping   : springDamping,
                       initialSpringVelocity    : springVelocity,
                       options      : [.allowUserInteraction, .beginFromCurrentState],
                       animations   : animations,
                       completion   : completion)
    }

    public class func show(_ view   : UIView,
                           on       : UIView?           = nil,
                           style    : FUI.SegueStyle    = .fade,
                           with     : TimeInterval      = FUI.ANIMATION_TIME,
                           done     : FBlock?           = nil) {
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
            FUI.animate(with      : with,
                        animations: {view.layer.opacity = opacity},
                        completion: {_ in done?()})
        case .fadeTop:
            let opacity = view.layer.opacity
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            view.layer.opacity = 0
            view.frame.origin.y = view.frame.origin.y - offset
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = opacity
                            view.frame.origin.y = y
                        },
                        completion: {_ in done?()})
        case .fadeLeft:
            let opacity = view.layer.opacity
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            view.layer.opacity = 0
            view.frame.origin.x = view.frame.origin.x - offset
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = opacity
                            view.frame.origin.x = x
                        },
                        completion: {_ in done?()})
        case .fadeBottom:
            let opacity = view.layer.opacity
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            view.layer.opacity = 0
            view.frame.origin.y = view.frame.origin.y + offset
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = opacity
                            view.frame.origin.y = y
                        },
                        completion: {_ in done?()})
        case .fadeRight:
            let opacity = view.layer.opacity
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            view.layer.opacity = 0
            view.frame.origin.x = view.frame.origin.x + offset
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = opacity
                            view.frame.origin.x = x
                        },
                        completion: {_ in done?()})
        case .coverTop:
            let y = view.frame.origin.y
            view.frame.origin.y = -view.frame.height
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {view.frame.origin.y = y},
                        completion: {_ in done?()})
        case .coverLeft:
            let x = view.frame.origin.x
            view.frame.origin.x = -view.frame.width
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {view.frame.origin.x = x},
                        completion: {_ in done?()})
        case .coverBottom:
            let y = view.frame.origin.y
            view.frame.origin.y = parent.frame.height
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {view.frame.origin.y = y},
                        completion: {_ in done?()})
        case .coverRight:
            let x = view.frame.origin.x
            view.frame.origin.x = parent.frame.width
            
            parent.addSubview(view)
            FUI.animate(with      : with,
                        animations: {view.frame.origin.x = x},
                        completion: {_ in done?()})
        }
    }
    
    public class func hide(_ view   : UIView,
                           style    : FUI.SegueStyle    = .fade,
                           with     : TimeInterval      = FUI.ANIMATION_TIME,
                           done     : FBlock?           = nil) {
        let parent = view.superview!
        if 0 == with {
            view.removeFromSuperview()
            done?()
            return
        }
        switch style {
        case .fade:
            let opacity = view.layer.opacity
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = 0
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.layer.opacity = opacity
                            done?()
                        })
        case .fadeTop:
            let opacity = view.layer.opacity
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = 0
                            view.frame.origin.y = view.frame.origin.y - offset
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.layer.opacity = opacity
                            view.frame.origin.y = y
                            done?()
                        })
        case .fadeLeft:
            let opacity = view.layer.opacity
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = 0
                            view.frame.origin.x = view.frame.origin.x - offset
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.layer.opacity = opacity
                            view.frame.origin.x = x
                            done?()
                        })
        case .fadeBottom:
            let opacity = view.layer.opacity
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = 0
                            view.frame.origin.y = view.frame.origin.y + offset
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.layer.opacity = opacity
                            view.frame.origin.y = y
                            done?()
                        })
        case .fadeRight:
            let opacity = view.layer.opacity
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            FUI.animate(with      : with,
                        animations: {
                            view.layer.opacity = 0
                            view.frame.origin.x = view.frame.origin.x + offset
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.layer.opacity = opacity
                            view.frame.origin.x = x
                            done?()
                        })
        case .coverTop:
            let y = view.frame.origin.y
            FUI.animate(with      : with,
                        animations: {
                            view.frame.origin.y = -view.frame.height
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.frame.origin.y = y
                            done?()
                        })
        case .coverLeft:
            let x = view.frame.origin.x
            FUI.animate(with      : with,
                        animations: {
                            view.frame.origin.x = -view.frame.width
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.frame.origin.x = x
                            done?()
                        })
        case .coverBottom:
            let y = view.frame.origin.y
            FUI.animate(with      : with,
                        animations: {
                            view.frame.origin.y = parent.frame.height
                        },
                        completion: {_ in
                            view.removeFromSuperview()
                            view.frame.origin.y = y
                            done?()
                        })
        case .coverRight:
            let x = view.frame.origin.x
            FUI.animate(with      : with,
                        animations: {
                            view.frame.origin.x = parent.frame.width
                        },
                        completion: {_ in
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
            view.frame = CGRect(x: currentWidth,
                                y: (height - view.frame.height) / 2,
                                width   : view.frame.width,
                                height  : view.frame.height)
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
            view.frame = CGRect(x: (width - view.frame.width) / 2,
                                y: currentHeight,
                                width   : view.frame.width,
                                height  : view.frame.height)
            pack.addSubview(view)
            currentHeight = currentHeight + view.frame.height
        }
        return pack
    }

    open class FView: UIView {
        
        private var blockWillShow   : [FBlock] = []
        private var blockDidShow    : [FBlock] = []
        private var blockWillHide   : [FBlock] = []
        private var blockDidHide    : [FBlock] = []
        
        public func show(on: UIView? = nil, style: FUI.SegueStyle = .fade, with: TimeInterval = FUI.ANIMATION_TIME, done: FBlock? = nil) {
            FUI.show(self, on: on, style: style, with: with, done: {
                for block in self.blockDidShow {block()}
                done?()
            })
            for block in self.blockWillShow {block()}
        }
        public func hide(style: FUI.SegueStyle = .fade, with: TimeInterval = FUI.ANIMATION_TIME, done: FBlock? = nil) {
            for block in self.blockWillHide {block()}
            FUI.hide(self, style: style, with: with, done: {
                for block in self.blockDidHide {block()}
                done?()
            })
        }
        public func willShow(_ block: FBlock? = nil) {
            if let block = block {
                self.blockWillShow.append(block)
            }
        }
        public func didShow(_ block: FBlock? = nil) {
            if let block = block {
                self.blockDidShow.append(block)
            }
        }
        public func willHide(_ block: FBlock? = nil) {
            if let block = block {
                self.blockWillHide.append(block)
            }
        }
        public func didHide(_ block: FBlock? = nil) {
            if let block = block {
                self.blockDidHide.append(block)
            }
        }
        public func frameScreen() {
            self.frame = UIScreen.main.bounds
        }
        private var panBagan: CGPoint?
        private var panSpeed: CGFloat! = 1.0
        public func toGallery(speed: CGFloat = 1.0) {
            self.panSpeed = speed
            self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(toGalleryGesture)))
        }
        @objc private func toGalleryGesture(gesture: UIPanGestureRecognizer) {
            let parent  = self.superview!
            let point   = gesture.translation(in: parent)
            switch gesture.state {
            case .began:
                panBagan = CGPoint(x: self.frame.origin.x + point.x, y: self.frame.origin.y + point.y)
            case .changed:
                self.frame.origin.x = (self.panBagan?.x)! + point.x * self.panSpeed
                self.frame.origin.y = (self.panBagan?.y)! + point.y * self.panSpeed
                if self.frame.origin.x + self.frame.width < parent.frame.width {
                    self.frame.origin.x = parent.frame.width - self.frame.width
                }
                if self.frame.origin.x > 0 {
                    self.frame.origin.x = 0
                }
                if self.frame.origin.y + self.frame.height < parent.frame.height {
                    self.frame.origin.y = parent.frame.height - self.frame.height
                }
                if self.frame.origin.y > 0 {
                    self.frame.origin.y = 0
                }
            case .ended:
                var nearestView : UIView? = nil
                var distance    : CGFloat = CGFloat(MAXFLOAT)
                for view in self.subviews {
                    let currentDistance = sqrt(pow(parent.frame.width / 2 - (view.center.x + self.frame.origin.x), 2) + pow(parent.frame.height / 2 - (view.center.y + self.frame.origin.y), 2))
                    if currentDistance < distance {
                        distance = currentDistance
                        nearestView = view
                    }
                }
                if let view = nearestView {
                    FUI.animate {
                        self.frame.origin.x = parent.frame.width / 2 - view.center.x
                        self.frame.origin.y = parent.frame.height / 2 - view.center.y
                    }
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
        
        init(mask: Float = 0.2, rect: Float = 0.4) {
            super.init(frame: UIScreen.main.bounds)
            
            self.fmask = FMask(opacity: mask)
            self.frect = FView()
            self.frect.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(rect)).cgColor
            self.frect.layer.cornerRadius    = 12
            self.frect.layer.masksToBounds   = true

            self.addSubview(self.fmask)
            self.addSubview(self.frect)
        }
        
        public func packSubviews(_ views: [UIView]) {
            if let pack = self.fpack {
                pack.removeFromSuperview()
                self.fpack = nil
            }
            self.fpack = FUI.packPadding(FUI.packVertical(views), top: 4, left: 4, bottom: 4, right: 4)
            self.frect.addSubview(self.fpack!)
            self.frect.frame    = self.fpack!.frame
            self.frect.center   = self.center
        }
        
        public func styleActivityIndicator(_ style: UIActivityIndicatorViewStyle = .white) {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            self.willShow({indicator.startAnimating()})
            self.didHide({indicator.stopAnimating()})
            
            self.packSubviews([
                FUI.packPadding(indicator, top: 8, left: 8, bottom: 8, right: 8)
            ])
        }
    }
    
}

