//
//  fui.swift
//  fios
//
//  Created by fomjar on 2017/11/16.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit

public class fui {
    
    public enum segue {
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
    
    public class func animate(_ with    : Double = ANIMATION_TIME,
                              animations: @escaping fblock) {
        animate(with: with, animations: animations, completion: nil)
    }

    public class func animate(with      : Double = ANIMATION_TIME,
                              animations: @escaping fblock,
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
                           on       : UIView?       = nil,
                           style    : segue         = .fade,
                           with     : TimeInterval  = ANIMATION_TIME,
                           done     : fblock?       = nil) {
        let parent = (on ?? view.superview)!
        if 0 == with {
            parent.addSubview(view)
            done?()
            return
        }
        switch style {
        case .fade:
            let alpha = view.alpha
            view.alpha = 0
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {view.alpha = alpha},
                    completion: {_ in done?()})
        case .fadeTop:
            let alpha = view.alpha
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            view.alpha = 0
            view.frame.origin.y = view.frame.origin.y - offset
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {
                        view.alpha = alpha
                        view.frame.origin.y = y
                    },
                    completion: {_ in done?()})
        case .fadeLeft:
            let alpha = view.alpha
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            view.alpha = 0
            view.frame.origin.x = view.frame.origin.x - offset
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {
                        view.alpha = alpha
                        view.frame.origin.x = x
                    },
                    completion: {_ in done?()})
        case .fadeBottom:
            let alpha = view.alpha
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            view.alpha = 0
            view.frame.origin.y = view.frame.origin.y + offset
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {
                        view.alpha = alpha
                        view.frame.origin.y = y
                    },
                    completion: {_ in done?()})
        case .fadeRight:
            let alpha = view.alpha
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            view.alpha = 0
            view.frame.origin.x = view.frame.origin.x + offset
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {
                        view.alpha = alpha
                        view.frame.origin.x = x
                    },
                    completion: {_ in done?()})
        case .coverTop:
            let y = view.frame.origin.y
            view.frame.origin.y = -view.frame.height
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {view.frame.origin.y = y},
                    completion: {_ in done?()})
        case .coverLeft:
            let x = view.frame.origin.x
            view.frame.origin.x = -view.frame.width
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {view.frame.origin.x = x},
                    completion: {_ in done?()})
        case .coverBottom:
            let y = view.frame.origin.y
            view.frame.origin.y = parent.frame.height
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {view.frame.origin.y = y},
                    completion: {_ in done?()})
        case .coverRight:
            let x = view.frame.origin.x
            view.frame.origin.x = parent.frame.width
            
            parent.addSubview(view)
            animate(with      : with,
                    animations: {view.frame.origin.x = x},
                    completion: {_ in done?()})
        }
    }
    
    public class func hide(_ view   : UIView,
                           style    : segue         = .fade,
                           with     : TimeInterval  = ANIMATION_TIME,
                           done     : fblock?       = nil) {
        let parent = view.superview!
        if 0 == with {
            view.removeFromSuperview()
            done?()
            return
        }
        switch style {
        case .fade:
            let alpha = view.alpha
            animate(with      : with,
                    animations: {
                        view.alpha = 0
                    },
                    completion: {_ in
                        view.removeFromSuperview()
                        view.alpha = alpha
                        done?()
                    })
        case .fadeTop:
            let alpha = view.alpha
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            animate(with    : with,
                    animations: {
                        view.alpha = 0
                        view.frame.origin.y = view.frame.origin.y - offset
                    },
                    completion: {_ in
                        view.removeFromSuperview()
                        view.alpha = alpha
                        view.frame.origin.y = y
                        done?()
                    })
        case .fadeLeft:
            let alpha = view.alpha
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            animate(with      : with,
                    animations: {
                        view.alpha = 0
                        view.frame.origin.x = view.frame.origin.x - offset
                    },
                    completion: {_ in
                        view.removeFromSuperview()
                        view.alpha = alpha
                        view.frame.origin.x = x
                        done?()
                    })
        case .fadeBottom:
            let alpha = view.alpha
            let y = view.frame.origin.y
            let offset = min(view.frame.width, view.frame.height)
            animate(with      : with,
                    animations: {
                        view.alpha = 0
                        view.frame.origin.y = view.frame.origin.y + offset
                    },
                    completion: {_ in
                        view.removeFromSuperview()
                        view.alpha = alpha
                        view.frame.origin.y = y
                        done?()
                    })
        case .fadeRight:
            let alpha = view.alpha
            let x = view.frame.origin.x
            let offset = min(view.frame.width, view.frame.height)
            animate(with      : with,
                    animations: {
                        view.alpha = 0
                        view.frame.origin.x = view.frame.origin.x + offset
                    },
                    completion: {_ in
                        view.removeFromSuperview()
                        view.alpha = alpha
                        view.frame.origin.x = x
                        done?()
                    })
        case .coverTop:
            let y = view.frame.origin.y
            animate(with      : with,
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
            animate(with      : with,
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
            animate(with      : with,
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
            animate(with      : with,
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
                                  right : CGFloat = 0) -> View {
        let pack = View(frame: CGRect(x: view.frame.origin.x,
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
                                 right : CGFloat = 0) -> View {
        let pack = View(frame: CGRect(x: view.frame.origin.x - left,
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

    public class func packHorizontal(_ views: [UIView]) -> View {
        var width   = CGFloat();
        var height  = CGFloat();
        for view in views {
            width   = width + view.frame.width
            height  = max(height, view.frame.height)
        }
        let pack = View(frame: CGRect(x: 0, y: 0, width: width, height: height))
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

    public class func packVertical(_ views: [UIView]) -> View {
        var width   = CGFloat();
        var height  = CGFloat();
        for view in views {
            width   = max(width, view.frame.width)
            height  = height + view.frame.height
        }
        let pack = View(frame: CGRect(x: 0, y: 0, width: width, height: height))
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

    open class View: UIView {
        
        private var blockWillShow   : [fblock] = []
        private var blockDidShow    : [fblock] = []
        private var blockWillHide   : [fblock] = []
        private var blockDidHide    : [fblock] = []
        
        public func show(on: UIView? = nil, style: segue = .fade, with: TimeInterval = ANIMATION_TIME, done: fblock? = nil) {
            fui.show(self, on: on, style: style, with: with, done: {
                for block in self.blockDidShow {block()}
                done?()
            })
            for block in self.blockWillShow {block()}
        }
        public func hide(style: segue = .fade, with: TimeInterval = ANIMATION_TIME, done: fblock? = nil) {
            for block in self.blockWillHide {block()}
            fui.hide(self, style: style, with: with, done: {
                for block in self.blockDidHide {block()}
                done?()
            })
        }
        public func willShow(_ block: fblock? = nil) {
            if let block = block {
                self.blockWillShow.append(block)
            }
        }
        public func didShow(_ block: fblock? = nil) {
            if let block = block {
                self.blockDidShow.append(block)
            }
        }
        public func willHide(_ block: fblock? = nil) {
            if let block = block {
                self.blockWillHide.append(block)
            }
        }
        public func didHide(_ block: fblock? = nil) {
            if let block = block {
                self.blockDidHide.append(block)
            }
        }
        public func frameScreen() {
            self.frame = UIScreen.main.bounds
        }
        private var panSpeed: CGFloat! = 1.0
        private var panBagan: CGPoint?
        private var panMove: fblock?
        private var panDone: fblock?
        public func toGallery(_ speed: CGFloat = 1.0, move: fblock? = nil, done: fblock? = nil) {
            self.panSpeed = speed
            self.panMove = move
            self.panDone = done
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
                self.panMove?()
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
                    fui.animate(ANIMATION_TIME / 2) {
                        self.frame.origin.x = parent.frame.width / 2 - view.center.x
                        self.frame.origin.y = parent.frame.height / 2 - view.center.y
                        self.panDone?()
                    }
                }
            default:
                print()
            }
        }
    }

    public class Mask: View {
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        init(color: UIColor = .black, alpha: CGFloat = 0) {
            super.init(frame: UIScreen.main.bounds)
            
            self.backgroundColor    = color
            self.alpha              = alpha
        }
        
    }
    
    public class HUD: View {
        
        public var fmask  : Mask!
        public var frect  : View!
        public var fpack  : View?
        
        required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
        
        public init(mask: CGFloat = 0.2, rect: CGFloat = 0.4) {
            super.init(frame: CGRect())
            self.frameScreen()
            
            self.fmask = Mask(alpha: mask)
            self.frect = View()
            self.frect.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: rect).cgColor
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
            self.fpack = packPadding(packVertical(views), top: 4, left: 4, bottom: 4, right: 4)
            self.frect.addSubview(self.fpack!)
            self.frect.frame    = self.fpack!.frame
            self.frect.center   = self.center
        }
        
        public func styleActivityIndicator(_ style: UIActivityIndicatorView.Style = .gray) {
            let indicator = UIActivityIndicatorView(style: style)
            self.willShow({indicator.startAnimating()})
            self.didHide({indicator.stopAnimating()})
            
            self.packSubviews([
                packPadding(indicator, top: 8, left: 8, bottom: 8, right: 8)
            ])
        }
    }
    
}

