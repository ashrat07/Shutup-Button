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
    
    var mute:Bool = false
    var speakerLayer: CAShapeLayer! = CAShapeLayer()
    var beat1Layer: CAShapeLayer! = CAShapeLayer()
    var beat2Layer: CAShapeLayer! = CAShapeLayer()
    let enabledStrokeStart:CGFloat = 0.0
    let enabledStrokeEnd:CGFloat = 1.0
    
    let muteStrokeStart:CGFloat = 0.1
    let muteStrokeEnd: CGFloat = 0.9
    
    
    
    
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        let h  = frame.size.height
        let w = frame.size.width
        
        let beat1Stroke: CGPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,0)
            CGPathAddQuadCurveToPoint(path,nil,w*0.07,(h*0.34/2),0,h*0.34)
            return path
            }()
        
        let beat2Stroke: CGPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,0)
            CGPathAddQuadCurveToPoint(path,nil,w*0.14,(h*0.6/2),0,h*0.6)
            return path
            }()
        
        
        let speakerStroke: CGPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,w/2,h)
            CGPathAddLineToPoint(path,nil,w/2,0)
            CGPathAddLineToPoint(path,nil,(w/2)*40/75,h*0.25)
            CGPathAddLineToPoint(path,nil,0,h*0.25)
            CGPathAddLineToPoint(path,nil,0,h*0.75)
            CGPathAddLineToPoint(path,nil,(w/2)*40/75,h*0.75)
            CGPathAddLineToPoint(path,nil,w/2,h)
            return path
            }()

        
        
        self.speakerLayer.path = speakerStroke
        self.beat1Layer.path = beat1Stroke
        self.beat2Layer.path = beat2Stroke
        
        for layer in [speakerLayer,beat1Layer, beat2Layer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.whiteColor().CGColor
            layer.lineWidth = 4
            layer.miterLimit = 2
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            
            
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull()
            ]
            
            self.layer.addSublayer(layer)
        }
        
        self.beat1Layer.position = CGPointMake(w*0.55,0)
        self.beat2Layer.position = CGPointMake(w*0.75,0)
    }
    
    
    
    
}
