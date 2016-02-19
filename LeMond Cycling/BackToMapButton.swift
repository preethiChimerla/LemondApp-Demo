//
//  BackToMapButton.swift
//  LeMond Cycling
//
//  Created by xiulan li on 8/31/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation

class BackToMapButton: UIButton {
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        
        
        let color2 = UIColor(red: 0.650, green: 0.650, blue: 0.650, alpha: 0.347)
        
        let fillColor2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        
        
        //// Oval Drawing
        
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(3, 3, 44, 44))
        
        color2.setFill()
        
        ovalPath.fill()
        
        
        
        
        
        //// Bezier Drawing
        
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPointMake(23.02, 27.02))
        
        bezierPath.addLineToPoint(CGPointMake(23.64, 28.61))
        
        bezierPath.addCurveToPoint(CGPointMake(21.84, 29.17), controlPoint1: CGPointMake(23.04, 28.86), controlPoint2: CGPointMake(22.43, 29.05))
        
        bezierPath.addLineToPoint(CGPointMake(21.5, 27.5))
        
        bezierPath.addCurveToPoint(CGPointMake(23.02, 27.02), controlPoint1: CGPointMake(21.99, 27.39), controlPoint2: CGPointMake(22.5, 27.23))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(18, 29.08))
        
        bezierPath.addCurveToPoint(CGPointMake(19.93, 29.36), controlPoint1: CGPointMake(18.61, 29.26), controlPoint2: CGPointMake(19.27, 29.35))
        
        bezierPath.addLineToPoint(CGPointMake(19.96, 27.65))
        
        bezierPath.addCurveToPoint(CGPointMake(18.46, 27.43), controlPoint1: CGPointMake(19.44, 27.64), controlPoint2: CGPointMake(18.94, 27.57))
        
        bezierPath.addLineToPoint(CGPointMake(18, 29.08))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(31.28, 26.09))
        
        bezierPath.addCurveToPoint(CGPointMake(32.69, 26.59), controlPoint1: CGPointMake(31.77, 26.18), controlPoint2: CGPointMake(32.25, 26.35))
        
        bezierPath.addLineToPoint(CGPointMake(33.47, 25.06))
        
        bezierPath.addCurveToPoint(CGPointMake(31.61, 24.4), controlPoint1: CGPointMake(32.88, 24.75), controlPoint2: CGPointMake(32.25, 24.53))
        
        bezierPath.addLineToPoint(CGPointMake(31.28, 26.09))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(27.76, 24.68))
        
        bezierPath.addLineToPoint(CGPointMake(28.27, 26.31))
        
        bezierPath.addCurveToPoint(CGPointMake(29.78, 26.01), controlPoint1: CGPointMake(28.78, 26.15), controlPoint2: CGPointMake(29.29, 26.05))
        
        bezierPath.addLineToPoint(CGPointMake(29.65, 24.3))
        
        bezierPath.addCurveToPoint(CGPointMake(27.76, 24.68), controlPoint1: CGPointMake(29.03, 24.35), controlPoint2: CGPointMake(28.4, 24.48))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(25.06, 25.97))
        
        bezierPath.addCurveToPoint(CGPointMake(24.5, 26.3), controlPoint1: CGPointMake(24.87, 26.09), controlPoint2: CGPointMake(24.68, 26.2))
        
        bezierPath.addLineToPoint(CGPointMake(25.32, 27.8))
        
        bezierPath.addCurveToPoint(CGPointMake(25.94, 27.42), controlPoint1: CGPointMake(25.52, 27.68), controlPoint2: CGPointMake(25.73, 27.56))
        
        bezierPath.addCurveToPoint(CGPointMake(26.8, 26.94), controlPoint1: CGPointMake(26.24, 27.24), controlPoint2: CGPointMake(26.52, 27.08))
        
        bezierPath.addLineToPoint(CGPointMake(26.03, 25.41))
        
        bezierPath.addCurveToPoint(CGPointMake(25.06, 25.97), controlPoint1: CGPointMake(25.71, 25.57), controlPoint2: CGPointMake(25.39, 25.76))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(29.72, 15.29))
        
        bezierPath.addCurveToPoint(CGPointMake(29.26, 17.23), controlPoint1: CGPointMake(29.72, 15.99), controlPoint2: CGPointMake(29.55, 16.65))
        
        bezierPath.addLineToPoint(CGPointMake(25.5, 24.71))
        
        bezierPath.addCurveToPoint(CGPointMake(21.69, 17.14), controlPoint1: CGPointMake(25.5, 24.71), controlPoint2: CGPointMake(21.71, 17.17))
        
        bezierPath.addCurveToPoint(CGPointMake(21.28, 15.29), controlPoint1: CGPointMake(21.43, 16.58), controlPoint2: CGPointMake(21.28, 15.95))
        
        bezierPath.addCurveToPoint(CGPointMake(25.5, 11), controlPoint1: CGPointMake(21.28, 12.92), controlPoint2: CGPointMake(23.17, 11))
        
        bezierPath.addCurveToPoint(CGPointMake(29.72, 15.29), controlPoint1: CGPointMake(27.83, 11), controlPoint2: CGPointMake(29.72, 12.92))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(28.03, 15.29))
        
        bezierPath.addCurveToPoint(CGPointMake(25.5, 12.71), controlPoint1: CGPointMake(28.03, 13.87), controlPoint2: CGPointMake(26.9, 12.71))
        
        bezierPath.addCurveToPoint(CGPointMake(22.97, 15.29), controlPoint1: CGPointMake(24.1, 12.71), controlPoint2: CGPointMake(22.97, 13.87))
        
        bezierPath.addCurveToPoint(CGPointMake(25.5, 17.86), controlPoint1: CGPointMake(22.97, 16.71), controlPoint2: CGPointMake(24.1, 17.86))
        
        bezierPath.addCurveToPoint(CGPointMake(28.03, 15.29), controlPoint1: CGPointMake(26.9, 17.86), controlPoint2: CGPointMake(28.03, 16.71))
        
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPointMake(33.94, 19.57))
        
        bezierPath.addLineToPoint(CGPointMake(29.98, 19.57))
        
        bezierPath.addLineToPoint(CGPointMake(29.12, 21.29))
        
        bezierPath.addLineToPoint(CGPointMake(32.72, 21.29))
        
        bezierPath.addLineToPoint(CGPointMake(34.54, 26.84))
        
        bezierPath.addLineToPoint(CGPointMake(33.96, 27.49))
        
        bezierPath.addCurveToPoint(CGPointMake(34.9, 28.58), controlPoint1: CGPointMake(34.58, 28.06), controlPoint2: CGPointMake(34.9, 28.58))
        
        bezierPath.addLineToPoint(CGPointMake(35.08, 28.48))
        
        bezierPath.addLineToPoint(CGPointMake(36.66, 33.29))
        
        bezierPath.addLineToPoint(CGPointMake(14.34, 33.29))
        
        bezierPath.addLineToPoint(CGPointMake(16.03, 28.14))
        
        bezierPath.addCurveToPoint(CGPointMake(16.2, 28.26), controlPoint1: CGPointMake(16.09, 28.18), controlPoint2: CGPointMake(16.14, 28.22))
        
        bezierPath.addLineToPoint(CGPointMake(17.1, 26.81))
        
        bezierPath.addCurveToPoint(CGPointMake(16.59, 26.44), controlPoint1: CGPointMake(16.9, 26.68), controlPoint2: CGPointMake(16.73, 26.56))
        
        bezierPath.addLineToPoint(CGPointMake(18.28, 21.29))
        
        bezierPath.addLineToPoint(CGPointMake(21.88, 21.29))
        
        bezierPath.addCurveToPoint(CGPointMake(21.02, 19.57), controlPoint1: CGPointMake(21.53, 20.58), controlPoint2: CGPointMake(21.25, 20.02))
        
        bezierPath.addLineToPoint(CGPointMake(17.06, 19.57))
        
        bezierPath.addLineToPoint(CGPointMake(12, 35))
        
        bezierPath.addLineToPoint(CGPointMake(39, 35))
        
        bezierPath.addLineToPoint(CGPointMake(33.94, 19.57))
        
        bezierPath.closePath()
        
        bezierPath.miterLimit = 4;
        
        
        
        fillColor2.setFill()
        
        bezierPath.fill()
    }
}