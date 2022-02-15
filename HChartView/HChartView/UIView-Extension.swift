//
//  UIView-Extension.swift
//  wristband
//
//  Created by suhengxian on 2021/10/29.
//

import Foundation
import UIKit

extension UIView{
    public var x : CGFloat{
        get{
            return frame.origin.x
        }
        set{
            frame.origin.x = newValue
        }
    }
    public var y : CGFloat{
        get{
            return frame.origin.y
        }
        set{
            frame.origin.y = newValue
        }
    }
    public var width : CGFloat{
        get{
            return frame.size.width
        }
        set{
            frame.size.width = newValue
        }
    }
    public var height : CGFloat{
        get{
            return frame.size.height
        }
        set{
            frame.size.height = newValue
        }
    }
    
    public var size : CGSize{
        get{
            return frame.size
        }
        set{
            frame.size = newValue
        }
    }
    
    public var origin : CGPoint{
        get{
            return frame.origin
        }
        set{
            frame.origin = newValue
        }
    }
    
    public var centerX : CGFloat{
        get{
            return center.x
        }
        set{
            center.x = newValue
        }
    }
    
    public var centerY : CGFloat{
        get{
            return center.y
        }
        set{
            center.y = newValue
        }
    }
    
    var bottom:CGFloat{
        return frame.maxY
    }
    
    var right:CGFloat{
        return frame.width + frame.origin.x
    }
    
}

public extension UIView{
    func setCornerRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

