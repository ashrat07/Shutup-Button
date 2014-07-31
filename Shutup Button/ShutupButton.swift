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
    
    
    var speakerLayer: CAShapeLayer! = CAShapeLayer()
    var beat1Layer: CAShapeLayer! = CAShapeLayer()
    var beat2Layer: CAShapeLayer! = CAShapeLayer()
    let enabledStrokeStart:CGFloat = 0.0
    let enabledStrokeEnd:CGFloat = 1.0
    
    let muteStrokeStart:CGFloat = 0.1
    let muteStrokeEnd: CGFloat = 0.9
    
    let b1Path,b2Path,speakerPath,b1MutedPath,b2MutedPath,speakerMutedPath: CGPath
    
    
    
    
    
    init(frame: CGRect) {
        
        
        let h  = frame.size.height
        let w = frame.size.width
        
        b1Path = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,0)
            CGPathAddQuadCurveToPoint(path,nil,w*0.07,h*0.34/2,0,h*0.34)
            return path
            }()
        
        b2Path = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,0)
            CGPathAddQuadCurveToPoint(path,nil,w*0.14,h*0.6/2,0,h*0.6)
            return path
            }()
        
        
        speakerPath = {
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
        
       
       b1MutedPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,h*0.26)
            CGPathAddQuadCurveToPoint(path,nil,w*0.26/2,h*0.26/2,w*0.26,0)
            return path
            }()
        
        b2MutedPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path,nil,0,0)
            CGPathAddQuadCurveToPoint(path,nil,w*0.26/2,h*0.26/2,w*0.26,h*0.26)
            return path
            }()
        
        
        speakerMutedPath = {
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

        
        
        
        super.init(frame: frame)
        
        
        self.speakerLayer.path = speakerPath
        self.beat1Layer.path = b1Path
        self.beat2Layer.path = b2Path
        
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
                "transform": NSNull(),
                "translate":NSNull(),
            ]
            
            self.layer.addSublayer(layer)
        }
        
        self.beat1Layer.position = CGPointMake(w*0.55,0)
        self.beat2Layer.position = CGPointMake(w*0.75,0)
    }
    
    var mute:Bool = false {
    didSet{
        
        let rightTransform = CABasicAnimation(keyPath: "path")
        rightTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
        rightTransform.duration = 0.3
        rightTransform.fillMode = kCAFillModeBackwards
        
        let leftTransform = rightTransform.copy() as CABasicAnimation
        
        if self.mute {
            
          rightTransform.toValue = b2MutedPath
          leftTransform.toValue = b1MutedPath
            
        } else {
            
            rightTransform.toValue = b2Path
            leftTransform.toValue = b1Path
        }
        
        self.beat1Layer.ocb_applyAnimation(leftTransform)
        self.beat2Layer.ocb_applyAnimation(rightTransform)
        
        
    }
}
    
    
    
}

extension CALayer {
    func ocb_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as CABasicAnimation
        
        if !copy.fromValue {
            copy.fromValue = self.presentationLayer().valueForKeyPath(copy.keyPath)
        }
        
        self.addAnimation(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath)
    }
}

