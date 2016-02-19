//
//  CadenceCircleView.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/5/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//


import Foundation
import UIKit

class CadenceCircleView: UIView {

    /// Our Circle Layer
    var circleLayer: CAShapeLayer!

    var cs = UIColors()


    func degreesToRadians(degrees: Double) -> CGFloat {
        let rad = degrees * M_PI / 180
        return CGFloat(rad)
    }

    /**
    <#Description#>
    
    - parameter frame: <#frame description#>
    
    - returns: <#return value description#>
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        cs.setStandard()

        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10) / 2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)

        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = (cs.barCadence).CGColor
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
        circleLayer.position = rotationPoint

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
    <#Description#>
    
    - parameter aDecoder: <#aDecoder description#>
    
    - returns: <#return value description#>
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
    <#Description#>
    
    - parameter rect: <#rect description#>
    */
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        let context = UIGraphicsGetCurrentContext();

        // Set the circle outerline-width
        CGContextSetLineWidth(context, 8.0);

        // Set the circle outerline-colour
        // UIColor.redColor().set()
        UIColor.clearColor().set()

        // Create Circle
        CGContextAddArc(context, (frame.size.width) / 2, frame.size.height / 2, (frame.size.width - 10) / 2, 0.0, CGFloat(M_PI * 2.0), 1)

        // Draw
        CGContextStrokePath(context)
    }

    /**
    Animate Circle
    
    - parameter duration: <#duration description#>
    */
    func animateCircle(duration: NSTimeInterval, from: Double, to: Double) {
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