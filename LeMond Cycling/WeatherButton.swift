//
//  WeatherButton.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 8/27/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation

class WeatherButton: UIButton {

    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color = UIColor(red: 0.932, green: 1.000, blue: 0.000, alpha: 1.000)
        let color2 = UIColor(red: 0.650, green: 0.650, blue: 0.650, alpha: 0.347)

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(3, 3, 44, 44))
        color2.setFill()
        ovalPath.fill()


        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(13.48, 26.47))
        bezierPath.addLineToPoint(CGPointMake(4.77, 25.1))
        bezierPath.addLineToPoint(CGPointMake(4.77, 23.51))
        bezierPath.addLineToPoint(CGPointMake(15.06, 23.51))
        bezierPath.addLineToPoint(CGPointMake(15.06, 26.47))
        bezierPath.addLineToPoint(CGPointMake(13.48, 26.47))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(17.95, 34.15))
        bezierPath.addLineToPoint(CGPointMake(11.74, 38.33))
        bezierPath.addLineToPoint(CGPointMake(10.54, 37.17))
        bezierPath.addLineToPoint(CGPointMake(16.97, 30.97))
        bezierPath.addLineToPoint(CGPointMake(19.14, 32.99))
        bezierPath.addLineToPoint(CGPointMake(17.95, 34.15))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(15.77, 17.84))
        bezierPath.addLineToPoint(CGPointMake(10.65, 11.01))
        bezierPath.addLineToPoint(CGPointMake(11.85, 9.85))
        bezierPath.addLineToPoint(CGPointMake(19.14, 16.94))
        bezierPath.addLineToPoint(CGPointMake(16.97, 19.01))
        bezierPath.addLineToPoint(CGPointMake(15.77, 17.84))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(25.24, 32.93))
        bezierPath.addCurveToPoint(CGPointMake(17.02, 24.94), controlPoint1: CGPointMake(20.72, 32.93), controlPoint2: CGPointMake(17.02, 29.39))
        bezierPath.addCurveToPoint(CGPointMake(25.24, 16.94), controlPoint1: CGPointMake(17.02, 20.49), controlPoint2: CGPointMake(20.72, 16.94))
        bezierPath.addCurveToPoint(CGPointMake(33.46, 24.94), controlPoint1: CGPointMake(29.76, 16.94), controlPoint2: CGPointMake(33.46, 20.49))
        bezierPath.addCurveToPoint(CGPointMake(25.24, 32.93), controlPoint1: CGPointMake(33.46, 29.39), controlPoint2: CGPointMake(29.76, 32.93))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(23.66, 13.45))
        bezierPath.addLineToPoint(CGPointMake(25.13, 3.97))
        bezierPath.addLineToPoint(CGPointMake(26.71, 3.97))
        bezierPath.addLineToPoint(CGPointMake(26.71, 15.04))
        bezierPath.addLineToPoint(CGPointMake(23.66, 15.04))
        bezierPath.addLineToPoint(CGPointMake(23.66, 13.45))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(26.71, 36.43))
        bezierPath.addLineToPoint(CGPointMake(25.29, 44))
        bezierPath.addLineToPoint(CGPointMake(23.66, 44))
        bezierPath.addLineToPoint(CGPointMake(23.66, 34.84))
        bezierPath.addLineToPoint(CGPointMake(26.71, 34.84))
        bezierPath.addLineToPoint(CGPointMake(26.71, 36.43))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(34.77, 32.09))
        bezierPath.addLineToPoint(CGPointMake(40.05, 39.07))
        bezierPath.addLineToPoint(CGPointMake(38.85, 40.24))
        bezierPath.addLineToPoint(CGPointMake(31.39, 32.99))
        bezierPath.addLineToPoint(CGPointMake(33.57, 30.92))
        bezierPath.addLineToPoint(CGPointMake(34.77, 32.09))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(32.64, 15.78))
        bezierPath.addLineToPoint(CGPointMake(39.17, 11.22))
        bezierPath.addLineToPoint(CGPointMake(40.37, 12.39))
        bezierPath.addLineToPoint(CGPointMake(33.57, 18.95))
        bezierPath.addLineToPoint(CGPointMake(31.45, 16.94))
        bezierPath.addLineToPoint(CGPointMake(32.64, 15.78))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(37.05, 23.51))
        bezierPath.addLineToPoint(CGPointMake(45, 24.88))
        bezierPath.addLineToPoint(CGPointMake(45, 26.47))
        bezierPath.addLineToPoint(CGPointMake(35.47, 26.47))
        bezierPath.addLineToPoint(CGPointMake(35.47, 23.51))
        bezierPath.addLineToPoint(CGPointMake(37.05, 23.51))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        color.setFill()
        bezierPath.fill()
        
    }
}