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
        CGPathMoveToPoint(path, nil, 50,20)
        CGPathAddLineToPoint(path,nil,50,80)
        CGPathAddLineToPoint(path,nil,32,66)
        CGPathAddLineToPoint(path,nil,10,66)
        CGPathAddLineToPoint(path,nil,10,34)
        CGPathAddLineToPoint(path,nil,32,34)
        CGPathAddLineToPoint(path,nil,50,20)

        return path
    }()
    
    let b1Path: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path,nil,60,60)
    CGPathAddCurveToPoint(path,nil,66,54,66,44,60,40)
    return path
        
    }()
    
    let b1MutedPath: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,60,36 )
        CGPathAddLineToPoint(path,nil,42,18)
        return path
        }()
    
    let b2Path: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,70,68 )
        CGPathAddCurveToPoint(path,nil,80,60,82,44,70,30)
        return path
        }()
    
    let b2MutedPath: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path,nil,60,20)
        CGPathAddLineToPoint(path,nil,42,38)
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
        rightTransform.duration = 0.3
        rightTransform.fillMode = kCAFillModeBackwards
        
        let leftTransform = rightTransform.copy() as CABasicAnimation
        let speakerTransformStart = CABasicAnimation(keyPath: "strokeStart")
        speakerTransformStart.duration = 0.2
        let speakerTransformEnd = CABasicAnimation(keyPath: "strokeEnd")
        speakerTransformEnd.duration = 0.2
        
            
        
        
        
        if self.mute {
          
        leftTransform.toValue = b1MutedPath
        rightTransform.toValue = b2MutedPath
        speakerTransformStart.toValue = 0.13
        speakerTransformEnd.toValue = 0.93
        
            
            
        } else {
           leftTransform.toValue = b1Path
           rightTransform.toValue = b2Path
            
           speakerTransformStart.toValue = 0
           speakerTransformStart.beginTime = CACurrentMediaTime()+0.1
            
           speakerTransformEnd.toValue = 1
           speakerTransformEnd.beginTime = CACurrentMediaTime()+0.1
           speakerTransformStart.fillMode = kCAFillModeBackwards
           speakerTransformEnd.fillMode = kCAFillModeBackwards
            
           
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

