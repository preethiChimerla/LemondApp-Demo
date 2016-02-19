//
//  LocationFinder.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/10/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class LocationFinder: UIButton {
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 14.98))
        bezierPath.addLineToPoint(CGPointMake(0, 11.02))
        bezierPath.addLineToPoint(CGPointMake(3.4, 11.02))
        bezierPath.addCurveToPoint(CGPointMake(6.07, 6.07), controlPoint1: CGPointMake(3.96, 8.18), controlPoint2: CGPointMake(3.96, 8.18))
        bezierPath.addCurveToPoint(CGPointMake(11.02, 3.4), controlPoint1: CGPointMake(8.18, 3.96), controlPoint2: CGPointMake(8.18, 3.96))
        bezierPath.addLineToPoint(CGPointMake(11.02, 0))
        bezierPath.addLineToPoint(CGPointMake(14.98, 0))
        bezierPath.addLineToPoint(CGPointMake(14.98, 3.4))
        bezierPath.addCurveToPoint(CGPointMake(19.93, 6.07), controlPoint1: CGPointMake(17.82, 3.96), controlPoint2: CGPointMake(17.82, 3.96))
        bezierPath.addCurveToPoint(CGPointMake(22.6, 11.02), controlPoint1: CGPointMake(22.04, 8.18), controlPoint2: CGPointMake(22.04, 8.18))
        bezierPath.addLineToPoint(CGPointMake(26, 11.02))
        bezierPath.addLineToPoint(CGPointMake(26, 14.98))
        bezierPath.addLineToPoint(CGPointMake(22.6, 14.98))
        bezierPath.addCurveToPoint(CGPointMake(19.93, 19.93), controlPoint1: CGPointMake(22.04, 17.82), controlPoint2: CGPointMake(22.04, 17.82))
        bezierPath.addCurveToPoint(CGPointMake(14.98, 22.6), controlPoint1: CGPointMake(17.82, 22.04), controlPoint2: CGPointMake(17.82, 22.04))
        bezierPath.addLineToPoint(CGPointMake(14.98, 26))
        bezierPath.addLineToPoint(CGPointMake(11.02, 26))
        bezierPath.addLineToPoint(CGPointMake(11.02, 22.6))
        bezierPath.addCurveToPoint(CGPointMake(6.07, 19.93), controlPoint1: CGPointMake(8.18, 22.04), controlPoint2: CGPointMake(8.18, 22.04))
        bezierPath.addCurveToPoint(CGPointMake(3.4, 14.98), controlPoint1: CGPointMake(3.96, 17.82), controlPoint2: CGPointMake(3.96, 17.82))
        bezierPath.addLineToPoint(CGPointMake(0, 14.98))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(5.99, 14.98))
        bezierPath.addCurveToPoint(CGPointMake(7.85, 18.15), controlPoint1: CGPointMake(6.5, 16.81), controlPoint2: CGPointMake(6.5, 16.81))
        bezierPath.addCurveToPoint(CGPointMake(11.02, 20.01), controlPoint1: CGPointMake(9.19, 19.5), controlPoint2: CGPointMake(9.19, 19.5))
        bezierPath.addLineToPoint(CGPointMake(11.02, 16.2))
        bezierPath.addLineToPoint(CGPointMake(14.98, 16.2))
        bezierPath.addLineToPoint(CGPointMake(14.98, 20.01))
        bezierPath.addCurveToPoint(CGPointMake(18.15, 18.15), controlPoint1: CGPointMake(16.81, 19.5), controlPoint2: CGPointMake(16.81, 19.5))
        bezierPath.addCurveToPoint(CGPointMake(20.01, 14.98), controlPoint1: CGPointMake(19.5, 16.81), controlPoint2: CGPointMake(19.5, 16.81))
        bezierPath.addLineToPoint(CGPointMake(16.2, 14.98))
        bezierPath.addLineToPoint(CGPointMake(16.2, 11.02))
        bezierPath.addLineToPoint(CGPointMake(20.01, 11.02))
        bezierPath.addCurveToPoint(CGPointMake(18.15, 7.85), controlPoint1: CGPointMake(19.5, 9.19), controlPoint2: CGPointMake(19.5, 9.19))
        bezierPath.addCurveToPoint(CGPointMake(14.98, 5.99), controlPoint1: CGPointMake(16.81, 6.5), controlPoint2: CGPointMake(16.81, 6.5))
        bezierPath.addLineToPoint(CGPointMake(14.98, 9.8))
        bezierPath.addLineToPoint(CGPointMake(11.02, 9.8))
        bezierPath.addLineToPoint(CGPointMake(11.02, 5.99))
        bezierPath.addCurveToPoint(CGPointMake(7.85, 7.85), controlPoint1: CGPointMake(9.19, 6.5), controlPoint2: CGPointMake(9.19, 6.5))
        bezierPath.addCurveToPoint(CGPointMake(5.99, 11.02), controlPoint1: CGPointMake(6.5, 9.19), controlPoint2: CGPointMake(6.5, 9.19))
        bezierPath.addLineToPoint(CGPointMake(9.8, 11.02))
        bezierPath.addLineToPoint(CGPointMake(9.8, 14.98))
        bezierPath.addLineToPoint(CGPointMake(5.99, 14.98))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        fillColor.setFill()
        bezierPath.fill()

    }
}