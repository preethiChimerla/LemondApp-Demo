//
//  RightArrow.swift
//  LeMond Cycling
//
//  Created by xiulan li on 8/18/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class RightArrow: UIView {
    
    override func drawRect(rect: CGRect) {
        //// General Declarations
        
        let context = UIGraphicsGetCurrentContext()
        
        
        
        //// Color Declarations
        
        let fillColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        let fillColor4 = UIColor(red: 0.457, green: 1.000, blue: 0.623, alpha: 1.000)
        
        
        
        //// Group 8
        
        //// Group 9
        
        CGContextSaveGState(context)
        
        CGContextBeginTransparencyLayer(context, nil)
        
        
        
        //// Clip Clip 2
        
        let clip2Path = UIBezierPath(rect: CGRectMake(849.02, 1265.9, 3.15, 142.4))
        
        clip2Path.addClip()
        
        
        
        
        
        //// Rectangle 4 Drawing
        
        let rectangle4Path = UIBezierPath(rect: CGRectMake(844.02, 1260.9, 13.15, 152.4))
        
        fillColor.setFill()
        
        rectangle4Path.fill()
        
        
        
        
        
        CGContextEndTransparencyLayer(context)
        
        CGContextRestoreGState(context)
        
        
        
        
        
        //// Oval 23 Drawing
        
        let oval23Path = UIBezierPath(ovalInRect: CGRectMake(778.1, 1216.6, 45.7, 39))
        
        fillColor.setFill()
        
        oval23Path.fill()
        
        
        
        
        
        //// Oval 24 Drawing
        
        let oval24Path = UIBezierPath(ovalInRect: CGRectMake(809.2, 1252.4, 11.4, 9.9))
        
        fillColor.setFill()
        
        oval24Path.fill()
        
        
        
        
        
        //// Oval 25 Drawing
        
        let oval25Path = UIBezierPath(ovalInRect: CGRectMake(778.1, 1250.8, 11.4, 9.9))
        
        fillColor.setFill()
        
        oval25Path.fill()
        
        
        
        
        
        //// Oval 26 Drawing
        
        let oval26Path = UIBezierPath(ovalInRect: CGRectMake(852.2, 1267.1, 11.4, 9.9))
        
        fillColor.setFill()
        
        oval26Path.fill()
        
        
        
        
        
        //// Oval 27 Drawing
        
        let oval27Path = UIBezierPath(ovalInRect: CGRectMake(834.05, 1236.05, 45.7, 39))
        
        fillColor.setFill()
        
        oval27Path.fill()
        
        
        
        
        
        //// Oval 28 Drawing
        
        let oval28Path = UIBezierPath(ovalInRect: CGRectMake(893.15, 1238.05, 45.7, 39))
        
        fillColor.setFill()
        
        oval28Path.fill()
        
        
        
        
        
        //// Oval 29 Drawing
        
        let oval29Path = UIBezierPath(ovalInRect: CGRectMake(925.45, 1223.35, 9.1, 7.6))
        
        fillColor.setFill()
        
        oval29Path.fill()
        
        
        
        
        
        //// Oval 30 Drawing
        
        let oval30Path = UIBezierPath(ovalInRect: CGRectMake(929.8, 1192.7, 9.1, 7.6))
        
        fillColor.setFill()
        
        oval30Path.fill()
        
        
        
        
        
        //// Oval 31 Drawing
        
        let oval31Path = UIBezierPath(ovalInRect: CGRectMake(919.95, 1181.55, 3.2, 3.6))
        
        fillColor.setFill()
        
        oval31Path.fill()
        
        
        
        
        
        //// Oval 32 Drawing
        
        let oval32Path = UIBezierPath(ovalInRect: CGRectMake(884.1, 1320.4, 14.2, 14.7))
        
        fillColor.setFill()
        
        oval32Path.fill()
        
        
        
        
        
        //// Bezier 6 Drawing
        
        let bezier6Path = UIBezierPath()
        
        bezier6Path.moveToPoint(CGPointMake(755.48, 1443.76))
        
        bezier6Path.addCurveToPoint(CGPointMake(776.89, 1446.9), controlPoint1: CGPointMake(764.07, 1450.75), controlPoint2: CGPointMake(768.79, 1446.9))
        
        bezier6Path.addCurveToPoint(CGPointMake(782.88, 1457.75), controlPoint1: CGPointMake(778.84, 1446.9), controlPoint2: CGPointMake(781.05, 1457.99))
        
        bezier6Path.addCurveToPoint(CGPointMake(814.14, 1455.02), controlPoint1: CGPointMake(787.1, 1457.21), controlPoint2: CGPointMake(805.52, 1457.22))
        
        bezier6Path.addCurveToPoint(CGPointMake(821.59, 1457.75), controlPoint1: CGPointMake(816.03, 1454.53), controlPoint2: CGPointMake(815.16, 1460.61))
        
        bezier6Path.addCurveToPoint(CGPointMake(823.94, 1449.72), controlPoint1: CGPointMake(828.03, 1454.89), controlPoint2: CGPointMake(821.41, 1450.99))
        
        bezier6Path.addCurveToPoint(CGPointMake(835.14, 1439.99), controlPoint1: CGPointMake(829.54, 1446.91), controlPoint2: CGPointMake(836.59, 1443.61))
        
        bezier6Path.addCurveToPoint(CGPointMake(809.59, 1416.36), controlPoint1: CGPointMake(832.07, 1432.28), controlPoint2: CGPointMake(809.59, 1423.35))
        
        bezier6Path.addCurveToPoint(CGPointMake(793.47, 1409.77), controlPoint1: CGPointMake(809.59, 1407.85), controlPoint2: CGPointMake(798.31, 1415.86))
        
        bezier6Path.addCurveToPoint(CGPointMake(792.45, 1386.67), controlPoint1: CGPointMake(790.72, 1406.32), controlPoint2: CGPointMake(791.87, 1395.5))
        
        bezier6Path.addCurveToPoint(CGPointMake(793.47, 1378.12), controlPoint1: CGPointMake(792.67, 1383.43), controlPoint2: CGPointMake(794.23, 1380.29))
        
        bezier6Path.addCurveToPoint(CGPointMake(776.89, 1376.49), controlPoint1: CGPointMake(791.59, 1372.81), controlPoint2: CGPointMake(781.06, 1376.49))
        
        bezier6Path.addCurveToPoint(CGPointMake(743, 1411.69), controlPoint1: CGPointMake(758.17, 1376.49), controlPoint2: CGPointMake(743, 1392.25))
        
        bezier6Path.addCurveToPoint(CGPointMake(755.48, 1443.76), controlPoint1: CGPointMake(743, 1422.72), controlPoint2: CGPointMake(746.9, 1436.76))
        
        bezier6Path.closePath()
        
        bezier6Path.usesEvenOddFillRule = true;
        
        
        
        fillColor.setFill()
        
        bezier6Path.fill()
        
        
        
        
        
        //// Oval 33 Drawing
        
        let oval33Path = UIBezierPath(ovalInRect: CGRectMake(925.45, 1247.2, 8.3, 13.5))
        
        fillColor.setFill()
        
        oval33Path.fill()
        
        
        
        
        
        
        
        
        
        //// Bezier Drawing
        
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPointMake(24.94, 20.44))
        
        bezierPath.addLineToPoint(CGPointMake(5.77, 1.27))
        
        bezierPath.addCurveToPoint(CGPointMake(3.21, 0.76), controlPoint1: CGPointMake(5.1, 0.6), controlPoint2: CGPointMake(4.09, 0.4))
        
        bezierPath.addCurveToPoint(CGPointMake(1.76, 2.94), controlPoint1: CGPointMake(2.33, 1.13), controlPoint2: CGPointMake(1.76, 1.98))
        
        bezierPath.addLineToPoint(CGPointMake(11.81, 22.1))
        
        bezierPath.addLineToPoint(CGPointMake(1.76, 41.27))
        
        bezierPath.addCurveToPoint(CGPointMake(3.21, 43.44), controlPoint1: CGPointMake(1.76, 42.22), controlPoint2: CGPointMake(2.33, 43.08))
        
        bezierPath.addCurveToPoint(CGPointMake(4.11, 43.62), controlPoint1: CGPointMake(3.5, 43.56), controlPoint2: CGPointMake(3.81, 43.62))
        
        bezierPath.addCurveToPoint(CGPointMake(5.77, 42.93), controlPoint1: CGPointMake(4.72, 43.62), controlPoint2: CGPointMake(5.32, 43.38))
        
        bezierPath.addLineToPoint(CGPointMake(24.94, 23.77))
        
        bezierPath.addCurveToPoint(CGPointMake(25.63, 22.1), controlPoint1: CGPointMake(25.38, 23.33), controlPoint2: CGPointMake(25.63, 22.72))
        
        bezierPath.addCurveToPoint(CGPointMake(24.94, 20.44), controlPoint1: CGPointMake(25.63, 21.48), controlPoint2: CGPointMake(25.38, 20.88))
        
        bezierPath.closePath()
        
        fillColor4.setFill()
        
        bezierPath.fill()
    }
}