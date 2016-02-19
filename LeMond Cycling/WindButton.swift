//
//  WindButton.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 9/2/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class WindButton: UIButton {
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let fillColor2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// wind_cooling_fan
        //// Group 2
        //// Group 3
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(33.04, 24.29))
        bezierPath.addCurveToPoint(CGPointMake(37.69, 19.45), controlPoint1: CGPointMake(34.89, 23.05), controlPoint2: CGPointMake(36.6, 21.46))
        bezierPath.addCurveToPoint(CGPointMake(30.96, 5.35), controlPoint1: CGPointMake(41.31, 12.82), controlPoint2: CGPointMake(37.49, 4.96))
        bezierPath.addCurveToPoint(CGPointMake(26.61, 16.69), controlPoint1: CGPointMake(25.68, 5.66), controlPoint2: CGPointMake(26.82, 12.19))
        bezierPath.addCurveToPoint(CGPointMake(30.37, 18.44), controlPoint1: CGPointMake(27.96, 16.91), controlPoint2: CGPointMake(29.26, 17.49))
        bezierPath.addCurveToPoint(CGPointMake(33.04, 24.29), controlPoint1: CGPointMake(32.14, 19.97), controlPoint2: CGPointMake(33.04, 22.13))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        bezierPath.usesEvenOddFillRule = true;

        fillColor2.setFill()
        bezierPath.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(19.54, 19.27))
        bezier2Path.addCurveToPoint(CGPointMake(20.37, 18.44), controlPoint1: CGPointMake(19.79, 18.96), controlPoint2: CGPointMake(20.08, 18.7))
        bezier2Path.addCurveToPoint(CGPointMake(13.93, 17.69), controlPoint1: CGPointMake(18.33, 17.75), controlPoint2: CGPointMake(16.11, 17.38))
        bezier2Path.addCurveToPoint(CGPointMake(6.71, 31.54), controlPoint1: CGPointMake(6.47, 18.76), controlPoint2: CGPointMake(2.49, 26.53))
        bezier2Path.addCurveToPoint(CGPointMake(18.66, 28.05), controlPoint1: CGPointMake(10.21, 35.71), controlPoint2: CGPointMake(14.89, 30.5))
        bezier2Path.addCurveToPoint(CGPointMake(19.54, 19.27), controlPoint1: CGPointMake(17.14, 25.3), controlPoint2: CGPointMake(17.38, 21.79))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;

        bezier2Path.usesEvenOddFillRule = true;

        fillColor2.setFill()
        bezier2Path.fill()


        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(30.98, 29.54))
        bezier3Path.addCurveToPoint(CGPointMake(21.58, 31), controlPoint1: CGPointMake(28.52, 32.18), controlPoint2: CGPointMake(24.62, 32.73))
        bezier3Path.addCurveToPoint(CGPointMake(23.23, 37.84), controlPoint1: CGPointMake(21.63, 33.33), controlPoint2: CGPointMake(22.06, 35.75))
        bezier3Path.addCurveToPoint(CGPointMake(38.73, 39.56), controlPoint1: CGPointMake(26.94, 44.43), controlPoint2: CGPointMake(35.6, 45.33))
        bezier3Path.addCurveToPoint(CGPointMake(30.98, 29.54), controlPoint1: CGPointMake(41.36, 34.7), controlPoint2: CGPointMake(34.59, 32.22))
        bezier3Path.closePath()
        bezier3Path.miterLimit = 4;

        bezier3Path.usesEvenOddFillRule = true;

        fillColor2.setFill()
        bezier3Path.fill()


        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(29.32, 19.67))
        bezier4Path.addCurveToPoint(CGPointMake(20.76, 20.32), controlPoint1: CGPointMake(26.78, 17.48), controlPoint2: CGPointMake(22.95, 17.77))
        bezier4Path.addCurveToPoint(CGPointMake(21.41, 28.91), controlPoint1: CGPointMake(18.58, 22.87), controlPoint2: CGPointMake(18.87, 26.72))
        bezier4Path.addCurveToPoint(CGPointMake(29.97, 28.26), controlPoint1: CGPointMake(23.95, 31.1), controlPoint2: CGPointMake(27.78, 30.81))
        bezier4Path.addCurveToPoint(CGPointMake(29.32, 19.67), controlPoint1: CGPointMake(32.15, 25.71), controlPoint2: CGPointMake(31.86, 21.86))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(27.08, 25.77))
        bezier4Path.addCurveToPoint(CGPointMake(23.89, 26.01), controlPoint1: CGPointMake(26.27, 26.72), controlPoint2: CGPointMake(24.84, 26.83))
        bezier4Path.addCurveToPoint(CGPointMake(23.65, 22.81), controlPoint1: CGPointMake(22.94, 25.19), controlPoint2: CGPointMake(22.84, 23.76))
        bezier4Path.addCurveToPoint(CGPointMake(26.84, 22.57), controlPoint1: CGPointMake(24.46, 21.86), controlPoint2: CGPointMake(25.89, 21.75))
        bezier4Path.addCurveToPoint(CGPointMake(27.08, 25.77), controlPoint1: CGPointMake(27.78, 23.39), controlPoint2: CGPointMake(27.89, 24.82))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;

        bezier4Path.usesEvenOddFillRule = true;

        fillColor2.setFill()
        bezier4Path.fill()




        //// Group 4
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPointMake(10.64, 13.99))
        bezier5Path.addLineToPoint(CGPointMake(9.8, 13.39))
        bezier5Path.addCurveToPoint(CGPointMake(15.12, 8.18), controlPoint1: CGPointMake(11.25, 11.32), controlPoint2: CGPointMake(13.03, 9.57))
        bezier5Path.addCurveToPoint(CGPointMake(22.02, 5.31), controlPoint1: CGPointMake(17.23, 6.78), controlPoint2: CGPointMake(19.55, 5.81))
        bezier5Path.addLineToPoint(CGPointMake(22.22, 6.34))
        bezier5Path.addCurveToPoint(CGPointMake(10.64, 13.99), controlPoint1: CGPointMake(17.53, 7.29), controlPoint2: CGPointMake(13.42, 10.01))
        bezier5Path.closePath()
        bezier5Path.miterLimit = 4;

        fillColor2.setFill()
        bezier5Path.fill()


        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(13.66, 15.5))
        bezier6Path.addLineToPoint(CGPointMake(12.87, 14.84))
        bezier6Path.addCurveToPoint(CGPointMake(22.43, 8.35), controlPoint1: CGPointMake(15.37, 11.74), controlPoint2: CGPointMake(18.68, 9.5))
        bezier6Path.addLineToPoint(CGPointMake(22.73, 9.35))
        bezier6Path.addCurveToPoint(CGPointMake(13.66, 15.5), controlPoint1: CGPointMake(19.17, 10.44), controlPoint2: CGPointMake(16.03, 12.57))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;

        fillColor2.setFill()
        bezier6Path.fill()




        //// Group 5
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.moveToPoint(CGPointMake(22.36, 44.78))
        bezier7Path.addCurveToPoint(CGPointMake(14.87, 42.17), controlPoint1: CGPointMake(19.69, 44.35), controlPoint2: CGPointMake(17.17, 43.47))
        bezier7Path.addCurveToPoint(CGPointMake(8.88, 37.17), controlPoint1: CGPointMake(12.53, 40.86), controlPoint2: CGPointMake(10.52, 39.18))
        bezier7Path.addLineToPoint(CGPointMake(9.78, 36.56))
        bezier7Path.addCurveToPoint(CGPointMake(22.55, 43.77), controlPoint1: CGPointMake(12.88, 40.38), controlPoint2: CGPointMake(17.42, 42.94))
        bezier7Path.addLineToPoint(CGPointMake(22.36, 44.78))
        bezier7Path.closePath()
        bezier7Path.miterLimit = 4;

        fillColor2.setFill()
        bezier7Path.fill()


        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(22.33, 41.41))
        bezier8Path.addCurveToPoint(CGPointMake(11.62, 35.52), controlPoint1: CGPointMake(18.18, 40.46), controlPoint2: CGPointMake(14.47, 38.42))
        bezier8Path.addLineToPoint(CGPointMake(12.44, 34.84))
        bezier8Path.addCurveToPoint(CGPointMake(22.6, 40.42), controlPoint1: CGPointMake(15.15, 37.59), controlPoint2: CGPointMake(18.66, 39.51))
        bezier8Path.addLineToPoint(CGPointMake(22.33, 41.41))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;

        fillColor2.setFill()
        bezier8Path.fill()




        //// Group 6
        //// Bezier 9 Drawing
        let bezier9Path = UIBezierPath()
        bezier9Path.moveToPoint(CGPointMake(43.05, 33.13))
        bezier9Path.addLineToPoint(CGPointMake(42.1, 32.69))
        bezier9Path.addCurveToPoint(CGPointMake(42.96, 18.65), controlPoint1: CGPointMake(44.18, 28.28), controlPoint2: CGPointMake(44.48, 23.3))
        bezier9Path.addLineToPoint(CGPointMake(43.96, 18.32))
        bezier9Path.addCurveToPoint(CGPointMake(44.93, 25.77), controlPoint1: CGPointMake(44.75, 20.73), controlPoint2: CGPointMake(45.07, 23.24))
        bezier9Path.addCurveToPoint(CGPointMake(43.05, 33.13), controlPoint1: CGPointMake(44.78, 28.34), controlPoint2: CGPointMake(44.15, 30.82))
        bezier9Path.closePath()
        bezier9Path.miterLimit = 4;

        fillColor2.setFill()
        bezier9Path.fill()


        //// Bezier 10 Drawing
        let bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(40.35, 31.67))
        bezier10Path.addLineToPoint(CGPointMake(39.36, 31.32))
        bezier10Path.addCurveToPoint(CGPointMake(39.9, 20.22), controlPoint1: CGPointMake(40.64, 27.75), controlPoint2: CGPointMake(40.83, 23.91))
        bezier10Path.addLineToPoint(CGPointMake(40.92, 19.97))
        bezier10Path.addCurveToPoint(CGPointMake(40.35, 31.67), controlPoint1: CGPointMake(41.9, 23.86), controlPoint2: CGPointMake(41.7, 27.91))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;

        fillColor2.setFill()
        bezier10Path.fill()
        
        
        
        
        //// Group 7
        //// Bezier 11 Drawing
        let bezier11Path = UIBezierPath()
        bezier11Path.moveToPoint(CGPointMake(25, 0))
        bezier11Path.addCurveToPoint(CGPointMake(0, 25), controlPoint1: CGPointMake(11.19, 0), controlPoint2: CGPointMake(0, 11.19))
        bezier11Path.addCurveToPoint(CGPointMake(25, 50), controlPoint1: CGPointMake(0, 38.81), controlPoint2: CGPointMake(11.19, 50))
        bezier11Path.addCurveToPoint(CGPointMake(50, 25), controlPoint1: CGPointMake(38.81, 50), controlPoint2: CGPointMake(50, 38.81))
        bezier11Path.addCurveToPoint(CGPointMake(25, 0), controlPoint1: CGPointMake(50, 11.19), controlPoint2: CGPointMake(38.81, 0))
        bezier11Path.closePath()
        bezier11Path.moveToPoint(CGPointMake(25, 47.74))
        bezier11Path.addCurveToPoint(CGPointMake(2.26, 25), controlPoint1: CGPointMake(12.44, 47.74), controlPoint2: CGPointMake(2.26, 37.56))
        bezier11Path.addCurveToPoint(CGPointMake(25, 2.26), controlPoint1: CGPointMake(2.26, 12.44), controlPoint2: CGPointMake(12.44, 2.26))
        bezier11Path.addCurveToPoint(CGPointMake(47.74, 25), controlPoint1: CGPointMake(37.56, 2.26), controlPoint2: CGPointMake(47.74, 12.44))
        bezier11Path.addCurveToPoint(CGPointMake(25, 47.74), controlPoint1: CGPointMake(47.74, 37.56), controlPoint2: CGPointMake(37.56, 47.74))
        bezier11Path.closePath()
        bezier11Path.miterLimit = 4;
        
        fillColor2.setFill()
        bezier11Path.fill()
    }
}