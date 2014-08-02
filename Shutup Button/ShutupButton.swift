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

    let speakerPath: CGPath = {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 46,18)
        CGPathAddLineToPoint(path,nil,34,32)
        CGPathAddLineToPoint(path,nil,10,32)
        CGPathAddLineToPoint(path,nil,10,67)
        CGPathAddLineToPoint(path,nil,34,67)
        CGPathAddLineToPoint(path,nil,46,81)
        CGPathAddLineToPoint(path,nil,46,18)

        return path

    }()
    
    let b1Path: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path,nil,58,42 )
    CGPathAddCurveToPoint(path,nil,60,45,60,54,58,57)
    return path
    }()
    
    let b1MutedPath: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,38,18 )
        CGPathAddLineToPoint(path,nil,49,28)
        return path
        }()
  
    let b2Path: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,64,36 )
        CGPathAddCurveToPoint(path,nil,69,42,69,58,64,63)
        return path


        }()
    
    let b2MutedPath: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,38,28)
        CGPathAddLineToPoint(path,nil,49,18)
        return path
        }()
    
    
    
    init(frame: CGRect) {
        super.init(frame: frame)
        let h  = frame.size.height
        let w = frame.size.width
        

        self.speakerLayer.path = speakerPath
        self.beat1Layer.path = b1Path
        self.beat2Layer.path = b2Path
        var totalBounds = CGRectZero
        
        for path in [speakerPath,b1Path,b2Path] {
            totalBounds = CGRectUnion(totalBounds, CGPathGetPathBoundingBox(CGPathCreateCopyByStrokingPath(path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)))
        }
        
        for layer in [speakerLayer,beat1Layer, beat2Layer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.whiteColor().CGColor
            layer.lineWidth = 4
            layer.miterLimit = 4
            layer.lineJoin = kCALineJoinRound
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            layer.bounds = totalBounds
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull(),
                "translate":NSNull(),
            ]
            self.layer.addSublayer(layer)
        }
    }
    
    var mute:Bool = false {
    didSet{
        
        let rightTransform = CABasicAnimation(keyPath: "path")
        rightTransform.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rightTransform.duration = 0.5
        rightTransform.fillMode = kCAFillModeBackwards
        
        let leftTransform = rightTransform.copy() as CABasicAnimation
        let speakerTransformStart = CABasicAnimation(keyPath: "strokeStart")
        speakerTransformStart.duration = 0.5
        let speakerTransformEnd = CABasicAnimation(keyPath: "strokeEnd")
        speakerTransformEnd.duration = 0.5
        
            
        
        
        
        if self.mute {
          
        leftTransform.toValue = b1MutedPath
        rightTransform.toValue = b2MutedPath
        speakerTransformStart.toValue = 0.1
        speakerTransformEnd.toValue = 0.9
        
            
            
        } else {
           leftTransform.toValue = b1Path
           rightTransform.toValue = b2Path
           speakerTransformStart.toValue = 0
           speakerTransformEnd.toValue = 1
        }
        
        self.beat1Layer.ocb_applyAnimation(leftTransform)
        self.beat2Layer.ocb_applyAnimation(rightTransform)
        self.speakerLayer.ocb_applyAnimation(speakerTransformStart)
        self.speakerLayer.ocb_applyAnimation(speakerTransformEnd)
        
        
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

