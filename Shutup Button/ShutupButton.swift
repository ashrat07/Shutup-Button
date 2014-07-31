//
//  ShutupButton.swift
//  Shutup Button
//
//  Created by Mohamad on 7/31/14.
//  Copyright (c) 2014 Mohamad Ibrahim. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics

class ShutupButton: UIButton {
    
    
    
    let beat1: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,52.5,21.5)
        CGPathAddQuadCurveToPoint(path,nil,55,30,52.5,38.5)
        return path
    }()
    
    let beat2: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,67.5,15)
        CGPathAddQuadCurveToPoint(path,nil,75,30,67.5,45)
        return path
        }()
    
    
    let Speaker: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,42.5,55)
        CGPathAddLineToPoint(path,nil,42.5,5)
        CGPathAddLineToPoint(path,nil,25,17.5)
        CGPathAddLineToPoint(path,nil,5,17.5)
        CGPathAddLineToPoint(path,nil,5,42.5)
        CGPathAddLineToPoint(path,nil,25,42.5)
        CGPathAddLineToPoint(path,nil,42.5,55)
        return path
        }()
    
    
    
    init(frame: CGRect) {
        super.init(frame: CGRectMake(0,0,0,0))
    }
    
    
    var mute:Bool = false
    
    
}
