//
//  RadarButton.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 9/2/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class RadarButton : UIButton {

    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(25, 0.01))
        bezierPath.addCurveToPoint(CGPointMake(0.01, 25), controlPoint1: CGPointMake(11.2, 0.01), controlPoint2: CGPointMake(0.01, 11.2))
        bezierPath.addCurveToPoint(CGPointMake(25, 49.99), controlPoint1: CGPointMake(0.01, 38.8), controlPoint2: CGPointMake(11.2, 49.99))
        bezierPath.addCurveToPoint(CGPointMake(49.99, 25), controlPoint1: CGPointMake(38.8, 49.99), controlPoint2: CGPointMake(49.99, 38.8))
        bezierPath.addCurveToPoint(CGPointMake(25, 0.01), controlPoint1: CGPointMake(49.99, 11.2), controlPoint2: CGPointMake(38.8, 0.01))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(25, 46.66))
        bezierPath.addCurveToPoint(CGPointMake(3.34, 25), controlPoint1: CGPointMake(13.04, 46.66), controlPoint2: CGPointMake(3.34, 36.96))
        bezierPath.addCurveToPoint(CGPointMake(25, 3.34), controlPoint1: CGPointMake(3.34, 13.04), controlPoint2: CGPointMake(13.04, 3.34))
        bezierPath.addCurveToPoint(CGPointMake(46.66, 25), controlPoint1: CGPointMake(36.96, 3.34), controlPoint2: CGPointMake(46.66, 13.04))
        bezierPath.addCurveToPoint(CGPointMake(25, 46.66), controlPoint1: CGPointMake(46.66, 36.96), controlPoint2: CGPointMake(36.96, 46.66))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        fillColor3.setFill()
        bezierPath.fill()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(6.55, 30.88, 2.4, 2.4))
        fillColor3.setFill()
        ovalPath.fill()


        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(42.34, 25.69, 3.4, 2.4))
        fillColor3.setFill()
        oval2Path.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(37.86, 12.73))
        bezier2Path.addCurveToPoint(CGPointMake(37.81, 11.66), controlPoint1: CGPointMake(38.14, 12.42), controlPoint2: CGPointMake(38.12, 11.95))
        bezier2Path.addCurveToPoint(CGPointMake(36.75, 11.71), controlPoint1: CGPointMake(37.51, 11.38), controlPoint2: CGPointMake(37.03, 11.4))
        bezier2Path.addLineToPoint(CGPointMake(26.26, 23.08))
        bezier2Path.addCurveToPoint(CGPointMake(24.95, 22.83), controlPoint1: CGPointMake(25.87, 22.9), controlPoint2: CGPointMake(25.42, 22.8))
        bezier2Path.addCurveToPoint(CGPointMake(22.44, 25.67), controlPoint1: CGPointMake(23.47, 22.92), controlPoint2: CGPointMake(22.35, 24.2))
        bezier2Path.addCurveToPoint(CGPointMake(25.29, 28.18), controlPoint1: CGPointMake(22.54, 27.15), controlPoint2: CGPointMake(23.81, 28.27))
        bezier2Path.addCurveToPoint(CGPointMake(27.79, 25.33), controlPoint1: CGPointMake(26.76, 28.08), controlPoint2: CGPointMake(27.88, 26.81))
        bezier2Path.addCurveToPoint(CGPointMake(27.39, 24.09), controlPoint1: CGPointMake(27.76, 24.88), controlPoint2: CGPointMake(27.62, 24.45))
        bezier2Path.addLineToPoint(CGPointMake(30.73, 20.46))
        bezier2Path.addCurveToPoint(CGPointMake(32.97, 25.99), controlPoint1: CGPointMake(32.12, 21.89), controlPoint2: CGPointMake(32.97, 23.84))
        bezier2Path.addCurveToPoint(CGPointMake(31.07, 31.17), controlPoint1: CGPointMake(32.97, 27.97), controlPoint2: CGPointMake(32.25, 29.77))
        bezier2Path.addCurveToPoint(CGPointMake(29.69, 30.63), controlPoint1: CGPointMake(30.7, 30.84), controlPoint2: CGPointMake(30.22, 30.63))
        bezier2Path.addCurveToPoint(CGPointMake(27.63, 32.69), controlPoint1: CGPointMake(28.55, 30.63), controlPoint2: CGPointMake(27.63, 31.55))
        bezier2Path.addCurveToPoint(CGPointMake(27.78, 33.47), controlPoint1: CGPointMake(27.63, 32.96), controlPoint2: CGPointMake(27.68, 33.23))
        bezier2Path.addCurveToPoint(CGPointMake(25, 33.97), controlPoint1: CGPointMake(26.92, 33.79), controlPoint2: CGPointMake(25.98, 33.97))
        bezier2Path.addCurveToPoint(CGPointMake(19.36, 31.63), controlPoint1: CGPointMake(22.8, 33.97), controlPoint2: CGPointMake(20.81, 33.08))
        bezier2Path.addCurveToPoint(CGPointMake(17.03, 25.99), controlPoint1: CGPointMake(17.92, 30.19), controlPoint2: CGPointMake(17.03, 28.2))
        bezier2Path.addCurveToPoint(CGPointMake(19.28, 20.44), controlPoint1: CGPointMake(17.03, 23.83), controlPoint2: CGPointMake(17.89, 21.88))
        bezier2Path.addCurveToPoint(CGPointMake(19.27, 19.91), controlPoint1: CGPointMake(19.43, 20.29), controlPoint2: CGPointMake(19.42, 20.05))
        bezier2Path.addCurveToPoint(CGPointMake(18.74, 19.91), controlPoint1: CGPointMake(19.12, 19.76), controlPoint2: CGPointMake(18.89, 19.76))
        bezier2Path.addCurveToPoint(CGPointMake(16.27, 25.99), controlPoint1: CGPointMake(17.21, 21.48), controlPoint2: CGPointMake(16.27, 23.63))
        bezier2Path.addCurveToPoint(CGPointMake(25, 34.72), controlPoint1: CGPointMake(16.27, 30.81), controlPoint2: CGPointMake(20.18, 34.72))
        bezier2Path.addCurveToPoint(CGPointMake(28.2, 34.11), controlPoint1: CGPointMake(26.13, 34.72), controlPoint2: CGPointMake(27.21, 34.5))
        bezier2Path.addCurveToPoint(CGPointMake(29.69, 34.75), controlPoint1: CGPointMake(28.58, 34.5), controlPoint2: CGPointMake(29.1, 34.75))
        bezier2Path.addCurveToPoint(CGPointMake(31.74, 32.69), controlPoint1: CGPointMake(30.82, 34.75), controlPoint2: CGPointMake(31.74, 33.82))
        bezier2Path.addCurveToPoint(CGPointMake(31.53, 31.78), controlPoint1: CGPointMake(31.74, 32.36), controlPoint2: CGPointMake(31.66, 32.06))
        bezier2Path.addCurveToPoint(CGPointMake(33.73, 25.99), controlPoint1: CGPointMake(32.9, 30.24), controlPoint2: CGPointMake(33.73, 28.22))
        bezier2Path.addCurveToPoint(CGPointMake(31.25, 19.9), controlPoint1: CGPointMake(33.73, 23.62), controlPoint2: CGPointMake(32.78, 21.47))
        bezier2Path.addLineToPoint(CGPointMake(36.15, 14.58))
        bezier2Path.addCurveToPoint(CGPointMake(40.26, 25), controlPoint1: CGPointMake(38.7, 17.31), controlPoint2: CGPointMake(40.26, 20.97))
        bezier2Path.addCurveToPoint(CGPointMake(35.79, 35.79), controlPoint1: CGPointMake(40.26, 29.21), controlPoint2: CGPointMake(38.55, 33.03))
        bezier2Path.addCurveToPoint(CGPointMake(25, 40.26), controlPoint1: CGPointMake(33.03, 38.55), controlPoint2: CGPointMake(29.21, 40.26))
        bezier2Path.addCurveToPoint(CGPointMake(19.86, 39.37), controlPoint1: CGPointMake(23.2, 40.26), controlPoint2: CGPointMake(21.47, 39.94))
        bezier2Path.addCurveToPoint(CGPointMake(19.94, 38.81), controlPoint1: CGPointMake(19.91, 39.19), controlPoint2: CGPointMake(19.94, 39))
        bezier2Path.addCurveToPoint(CGPointMake(17.88, 36.75), controlPoint1: CGPointMake(19.94, 37.68), controlPoint2: CGPointMake(19.02, 36.75))
        bezier2Path.addCurveToPoint(CGPointMake(16.28, 37.52), controlPoint1: CGPointMake(17.23, 36.75), controlPoint2: CGPointMake(16.66, 37.05))
        bezier2Path.addCurveToPoint(CGPointMake(14.21, 35.79), controlPoint1: CGPointMake(15.54, 37.01), controlPoint2: CGPointMake(14.85, 36.43))
        bezier2Path.addCurveToPoint(CGPointMake(9.74, 25), controlPoint1: CGPointMake(11.45, 33.03), controlPoint2: CGPointMake(9.74, 29.21))
        bezier2Path.addCurveToPoint(CGPointMake(14.06, 14.37), controlPoint1: CGPointMake(9.74, 20.86), controlPoint2: CGPointMake(11.39, 17.12))
        bezier2Path.addCurveToPoint(CGPointMake(14.05, 13.83), controlPoint1: CGPointMake(14.2, 14.22), controlPoint2: CGPointMake(14.2, 13.98))
        bezier2Path.addCurveToPoint(CGPointMake(13.52, 13.84), controlPoint1: CGPointMake(13.9, 13.69), controlPoint2: CGPointMake(13.66, 13.69))
        bezier2Path.addCurveToPoint(CGPointMake(8.99, 25), controlPoint1: CGPointMake(10.71, 16.73), controlPoint2: CGPointMake(8.99, 20.66))
        bezier2Path.addCurveToPoint(CGPointMake(15.92, 38.19), controlPoint1: CGPointMake(8.99, 30.47), controlPoint2: CGPointMake(11.73, 35.3))
        bezier2Path.addCurveToPoint(CGPointMake(15.83, 38.81), controlPoint1: CGPointMake(15.86, 38.38), controlPoint2: CGPointMake(15.83, 38.59))
        bezier2Path.addCurveToPoint(CGPointMake(17.88, 40.87), controlPoint1: CGPointMake(15.83, 39.95), controlPoint2: CGPointMake(16.75, 40.87))
        bezier2Path.addCurveToPoint(CGPointMake(19.52, 40.05), controlPoint1: CGPointMake(18.55, 40.87), controlPoint2: CGPointMake(19.15, 40.55))
        bezier2Path.addCurveToPoint(CGPointMake(25, 41.01), controlPoint1: CGPointMake(21.23, 40.67), controlPoint2: CGPointMake(23.08, 41.01))
        bezier2Path.addCurveToPoint(CGPointMake(41.01, 25), controlPoint1: CGPointMake(33.84, 41.01), controlPoint2: CGPointMake(41.01, 33.84))
        bezier2Path.addCurveToPoint(CGPointMake(36.66, 14.03), controlPoint1: CGPointMake(41.01, 20.75), controlPoint2: CGPointMake(39.36, 16.89))
        bezier2Path.addLineToPoint(CGPointMake(37.86, 12.73))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(25.22, 27.18))
        bezier2Path.addCurveToPoint(CGPointMake(23.45, 25.61), controlPoint1: CGPointMake(24.3, 27.23), controlPoint2: CGPointMake(23.5, 26.53))
        bezier2Path.addCurveToPoint(CGPointMake(25.01, 23.83), controlPoint1: CGPointMake(23.39, 24.69), controlPoint2: CGPointMake(24.09, 23.89))
        bezier2Path.addCurveToPoint(CGPointMake(26.79, 25.4), controlPoint1: CGPointMake(25.93, 23.77), controlPoint2: CGPointMake(26.73, 24.47))
        bezier2Path.addCurveToPoint(CGPointMake(25.22, 27.18), controlPoint1: CGPointMake(26.85, 26.32), controlPoint2: CGPointMake(26.15, 27.12))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        fillColor3.setFill()
        bezier2Path.fill()
    }
}