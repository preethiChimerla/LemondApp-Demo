//
//  SpeedCircleViewMap.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 7/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class SpeedCircleViewMap: UIButton {
    
    /// Our Circle Layer
    var circleLayer: CAShapeLayer!
    
    var cs = UIColors()
    var x1 = 0.0
    var y1 = 0.0
    var r1 = 0.0

    
    func degreesToRadians(degrees: Double) -> CGFloat {
        let rad = degrees * M_PI / 180
        return CGFloat(rad)
    }
    
    /**
    <#Description#>
    
    - parameter frame: <#frame description#>
    
    - returns: <#return value description#>
    */
    func oldkInit(frame: CGRect) {
//      super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        cs.setStandard()
       
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        if (DeviceType.IS_IPHONE_6){
            x1 = 50.5
            y1 = 187
            r1 = 45.5
        } else if(DeviceType.IS_IPHONE_6P){
            x1 = 50.5
            y1 = 206.5
            r1 = 45.5
        } else {
            x1 = 50.5
            y1 = 159.5
            r1 = 45.8
        }
        let circlePath = UIBezierPath(arcCenter: CGPoint(
            x: CGFloat(x1), // frame.size.width / 2.0,
            y: CGFloat(y1)), // frame.size.height / 2.0),
            //radius: (frame.size.width - 14) / 2,
            radius: CGFloat(r1),
            startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2.0),
            clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        if (circleLayer != nil) {
            circleLayer.removeFromSuperlayer()
        }
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = (cs.barSpeed).CGColor
        
        
        circleLayer.lineWidth = 10.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        let minX = CGRectGetMinX(frame);
        let minY = CGRectGetMinY(frame);
        let width = CGRectGetWidth(frame);
        let height = CGRectGetHeight(frame);
        
        
        let rotationPoint = CGPointMake(0.5, 0.5)
        let anchorPoint = CGPointMake(
            (rotationPoint.x - minX) / width,
            (rotationPoint.y - minY) / height
        )
      
        circleLayer.anchorPoint = anchorPoint
        circleLayer.position = CGPointMake(minX, minY)
        
        circleLayer.transform = CATransform3DMakeRotation(
            degreesToRadians(-90),
            CGFloat(0.0),
            CGFloat(0.0),
            CGFloat(1.0)
        );
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
        
    }
    
    /**
    Animate Circle
    
    - parameter duration: <#duration description#>
    */
    func animateCircle(duration: NSTimeInterval, from: Double, to: Double) {
//        println("Caught Speed Adjustment \(from) \(to)")
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = from
        animation.toValue = to
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = CGFloat(to)
        // Do the actual animation
        circleLayer.addAnimation(animation, forKey: "animateCircle")
    }
}
