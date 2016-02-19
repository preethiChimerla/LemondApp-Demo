
//  TraineeSessionView.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 7/15/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData
import WatchCoreDataProxy

class TraineeSessionView : UIView{
    
    var showButtons = false
    var ItemWidth:CGFloat = CGFloat(400)
    var TitleName = ""
    var DescName = ""
    var Graphic : UIImage!
    
    var graphicToShow = 1
    
    
    /**
    <#Description#>
    
    - parameter rect: <#rect description#>
    */
    override func drawRect(rect: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        if(graphicToShow == 1){
            
            //// Color Declarations
            let fillColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
            let color = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
            
            //// Group 2
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(66.54, 32.08))
            bezierPath.addLineToPoint(CGPointMake(92.18, 32.1))
            bezierPath.addCurveToPoint(CGPointMake(94.53, 29.74), controlPoint1: CGPointMake(93.48, 32.11), controlPoint2: CGPointMake(94.53, 31.04))
            bezierPath.addLineToPoint(CGPointMake(94.53, 23.44))
            bezierPath.addCurveToPoint(CGPointMake(97.7, 21.94), controlPoint1: CGPointMake(94.53, 21.78), controlPoint2: CGPointMake(96.45, 20.88))
            bezierPath.addLineToPoint(CGPointMake(116.32, 37.57))
            bezierPath.addCurveToPoint(CGPointMake(116.32, 41.62), controlPoint1: CGPointMake(117.57, 38.63), controlPoint2: CGPointMake(117.57, 40.57))
            bezierPath.addLineToPoint(CGPointMake(97.7, 57.26))
            bezierPath.addCurveToPoint(CGPointMake(94.53, 55.76), controlPoint1: CGPointMake(96.45, 58.31), controlPoint2: CGPointMake(94.53, 57.41))
            bezierPath.addLineToPoint(CGPointMake(94.53, 49.5))
            bezierPath.addCurveToPoint(CGPointMake(92.19, 47.14), controlPoint1: CGPointMake(94.53, 48.2), controlPoint2: CGPointMake(93.48, 47.14))
            bezierPath.addLineToPoint(CGPointMake(78.6, 47.14))
            bezierPath.addCurveToPoint(CGPointMake(76.25, 49.5), controlPoint1: CGPointMake(77.3, 47.14), controlPoint2: CGPointMake(76.25, 48.2))
            bezierPath.addLineToPoint(CGPointMake(76.25, 63.77))
            bezierPath.addCurveToPoint(CGPointMake(78.6, 66.14), controlPoint1: CGPointMake(76.25, 65.08), controlPoint2: CGPointMake(77.3, 66.14))
            bezierPath.addLineToPoint(CGPointMake(109.95, 66.14))
            bezierPath.addCurveToPoint(CGPointMake(112.66, 68.87), controlPoint1: CGPointMake(111.45, 66.14), controlPoint2: CGPointMake(112.66, 67.36))
            bezierPath.addLineToPoint(CGPointMake(112.66, 78.43))
            bezierPath.addCurveToPoint(CGPointMake(109.95, 81.16), controlPoint1: CGPointMake(112.66, 79.94), controlPoint2: CGPointMake(111.45, 81.16))
            bezierPath.addLineToPoint(CGPointMake(66.54, 81.16))
            bezierPath.addCurveToPoint(CGPointMake(61.34, 75.93), controlPoint1: CGPointMake(63.67, 81.16), controlPoint2: CGPointMake(61.34, 78.82))
            bezierPath.addLineToPoint(CGPointMake(61.34, 37.32))
            bezierPath.addCurveToPoint(CGPointMake(66.54, 32.08), controlPoint1: CGPointMake(61.34, 34.42), controlPoint2: CGPointMake(63.67, 32.08))
            bezierPath.closePath()
            bezierPath.usesEvenOddFillRule = true;
            
            fillColor.setFill()
            bezierPath.fill()
            
            
            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.moveToPoint(CGPointMake(173.8, 80.4))
            bezier2Path.addLineToPoint(CGPointMake(148.16, 80.38))
            bezier2Path.addCurveToPoint(CGPointMake(145.81, 82.74), controlPoint1: CGPointMake(146.86, 80.38), controlPoint2: CGPointMake(145.81, 81.44))
            bezier2Path.addLineToPoint(CGPointMake(145.81, 89.05))
            bezier2Path.addCurveToPoint(CGPointMake(142.64, 90.54), controlPoint1: CGPointMake(145.81, 90.7), controlPoint2: CGPointMake(143.9, 91.6))
            bezier2Path.addLineToPoint(CGPointMake(124.02, 74.91))
            bezier2Path.addCurveToPoint(CGPointMake(124.02, 70.86), controlPoint1: CGPointMake(122.77, 73.85), controlPoint2: CGPointMake(122.77, 71.91))
            bezier2Path.addLineToPoint(CGPointMake(142.64, 55.22))
            bezier2Path.addCurveToPoint(CGPointMake(145.81, 56.72), controlPoint1: CGPointMake(143.9, 54.17), controlPoint2: CGPointMake(145.81, 55.07))
            bezier2Path.addLineToPoint(CGPointMake(145.81, 62.98))
            bezier2Path.addCurveToPoint(CGPointMake(148.15, 65.34), controlPoint1: CGPointMake(145.81, 64.28), controlPoint2: CGPointMake(146.86, 65.34))
            bezier2Path.addLineToPoint(CGPointMake(161.74, 65.34))
            bezier2Path.addCurveToPoint(CGPointMake(164.09, 62.98), controlPoint1: CGPointMake(163.04, 65.34), controlPoint2: CGPointMake(164.09, 64.28))
            bezier2Path.addLineToPoint(CGPointMake(164.09, 48.71))
            bezier2Path.addCurveToPoint(CGPointMake(161.74, 46.34), controlPoint1: CGPointMake(164.09, 47.4), controlPoint2: CGPointMake(163.04, 46.34))
            bezier2Path.addLineToPoint(CGPointMake(130.39, 46.34))
            bezier2Path.addCurveToPoint(CGPointMake(127.68, 43.62), controlPoint1: CGPointMake(128.9, 46.34), controlPoint2: CGPointMake(127.68, 45.12))
            bezier2Path.addLineToPoint(CGPointMake(127.68, 34.05))
            bezier2Path.addCurveToPoint(CGPointMake(130.39, 31.32), controlPoint1: CGPointMake(127.68, 32.54), controlPoint2: CGPointMake(128.9, 31.32))
            bezier2Path.addLineToPoint(CGPointMake(173.8, 31.32))
            bezier2Path.addCurveToPoint(CGPointMake(179, 36.55), controlPoint1: CGPointMake(176.67, 31.32), controlPoint2: CGPointMake(179, 33.66))
            bezier2Path.addLineToPoint(CGPointMake(179, 75.17))
            bezier2Path.addCurveToPoint(CGPointMake(173.8, 80.4), controlPoint1: CGPointMake(179, 78.06), controlPoint2: CGPointMake(176.67, 80.4))
            bezier2Path.closePath()
            bezier2Path.usesEvenOddFillRule = true;
            
            fillColor.setFill()
            bezier2Path.fill()


        }else if(graphicToShow == 2){

            //// Color Declarations
            let fillColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
            let strokeColor = UIColor(red: 0.200, green: 0.200, blue: 0.200, alpha: 1.000)

            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(146.11, 31.84))
            bezierPath.addCurveToPoint(CGPointMake(141.07, 27.05), controlPoint1: CGPointMake(146.06, 29.18), controlPoint2: CGPointMake(143.82, 27.05))
            bezierPath.addLineToPoint(CGPointMake(76.94, 27.05))
            bezierPath.addCurveToPoint(CGPointMake(71.89, 31.85), controlPoint1: CGPointMake(74.18, 27.05), controlPoint2: CGPointMake(71.93, 29.19))
            bezierPath.addLineToPoint(CGPointMake(71, 82.33))
            bezierPath.addCurveToPoint(CGPointMake(76.03, 87.27), controlPoint1: CGPointMake(70.95, 85.05), controlPoint2: CGPointMake(73.22, 87.27))
            bezierPath.addLineToPoint(CGPointMake(142.06, 87.27))
            bezierPath.addCurveToPoint(CGPointMake(147.09, 82.33), controlPoint1: CGPointMake(144.88, 87.27), controlPoint2: CGPointMake(147.14, 85.04))
            bezierPath.addLineToPoint(CGPointMake(146.11, 31.84))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(109.05, 23.29))
            bezierPath.addLineToPoint(CGPointMake(113.92, 23.29))
            bezierPath.addCurveToPoint(CGPointMake(116.65, 20.4), controlPoint1: CGPointMake(115.67, 23.29), controlPoint2: CGPointMake(116.65, 21.72))
            bezierPath.addCurveToPoint(CGPointMake(114.38, 17.19), controlPoint1: CGPointMake(116.65, 19.09), controlPoint2: CGPointMake(116.14, 17.71))
            bezierPath.addCurveToPoint(CGPointMake(111.95, 14.69), controlPoint1: CGPointMake(112.61, 16.68), controlPoint2: CGPointMake(111.95, 16.31))
            bezierPath.addCurveToPoint(CGPointMake(109.05, 12), controlPoint1: CGPointMake(111.95, 13.08), controlPoint2: CGPointMake(110.53, 12))
            bezierPath.addCurveToPoint(CGPointMake(106.14, 14.69), controlPoint1: CGPointMake(107.56, 12), controlPoint2: CGPointMake(106.14, 13.08))
            bezierPath.addCurveToPoint(CGPointMake(103.72, 17.19), controlPoint1: CGPointMake(106.14, 16.31), controlPoint2: CGPointMake(105.48, 16.68))
            bezierPath.addCurveToPoint(CGPointMake(101.44, 20.4), controlPoint1: CGPointMake(101.95, 17.71), controlPoint2: CGPointMake(101.44, 19.09))
            bezierPath.addCurveToPoint(CGPointMake(104.17, 23.29), controlPoint1: CGPointMake(101.44, 21.72), controlPoint2: CGPointMake(102.42, 23.29))
            bezierPath.addLineToPoint(CGPointMake(109.05, 23.29))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(144.19, 91.03))
            bezierPath.addLineToPoint(CGPointMake(73.9, 91.03))
            bezierPath.addCurveToPoint(CGPointMake(71, 94.57), controlPoint1: CGPointMake(72.3, 91.03), controlPoint2: CGPointMake(71, 92.61))
            bezierPath.addCurveToPoint(CGPointMake(73.9, 98.1), controlPoint1: CGPointMake(71, 96.52), controlPoint2: CGPointMake(72.3, 98.1))
            bezierPath.addLineToPoint(CGPointMake(77.61, 98.1))
            bezierPath.addCurveToPoint(CGPointMake(79.87, 101.64), controlPoint1: CGPointMake(79.13, 98.1), controlPoint2: CGPointMake(80.24, 99.85))
            bezierPath.addLineToPoint(CGPointMake(78.3, 109.2))
            bezierPath.addCurveToPoint(CGPointMake(80.38, 113.5), controlPoint1: CGPointMake(77.9, 111.09), controlPoint2: CGPointMake(78.84, 113.02))
            bezierPath.addCurveToPoint(CGPointMake(81.11, 113.62), controlPoint1: CGPointMake(80.63, 113.58), controlPoint2: CGPointMake(80.87, 113.62))
            bezierPath.addCurveToPoint(CGPointMake(83.91, 110.96), controlPoint1: CGPointMake(82.4, 113.62), controlPoint2: CGPointMake(83.58, 112.56))
            bezierPath.addLineToPoint(CGPointMake(85.85, 101.66))
            bezierPath.addCurveToPoint(CGPointMake(89.6, 98.1), controlPoint1: CGPointMake(86.29, 99.56), controlPoint2: CGPointMake(87.83, 98.1))
            bezierPath.addLineToPoint(CGPointMake(128.35, 98.1))
            bezierPath.addCurveToPoint(CGPointMake(132.09, 101.61), controlPoint1: CGPointMake(130.11, 98.1), controlPoint2: CGPointMake(131.64, 99.54))
            bezierPath.addLineToPoint(CGPointMake(134.1, 110.92))
            bezierPath.addCurveToPoint(CGPointMake(136.91, 113.57), controlPoint1: CGPointMake(134.44, 112.51), controlPoint2: CGPointMake(135.62, 113.57))
            bezierPath.addCurveToPoint(CGPointMake(137.63, 113.46), controlPoint1: CGPointMake(137.15, 113.57), controlPoint2: CGPointMake(137.39, 113.54))
            bezierPath.addCurveToPoint(CGPointMake(139.72, 109.16), controlPoint1: CGPointMake(139.18, 112.98), controlPoint2: CGPointMake(140.11, 111.05))
            bezierPath.addLineToPoint(CGPointMake(138.09, 101.67))
            bezierPath.addCurveToPoint(CGPointMake(140.34, 98.1), controlPoint1: CGPointMake(137.7, 99.87), controlPoint2: CGPointMake(138.81, 98.1))
            bezierPath.addLineToPoint(CGPointMake(144.19, 98.1))
            bezierPath.addCurveToPoint(CGPointMake(147.09, 94.57), controlPoint1: CGPointMake(145.79, 98.1), controlPoint2: CGPointMake(147.09, 96.52))
            bezierPath.addCurveToPoint(CGPointMake(144.19, 91.03), controlPoint1: CGPointMake(147.09, 92.61), controlPoint2: CGPointMake(145.79, 91.03))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(95.33, 60.93))
            bezierPath.addCurveToPoint(CGPointMake(93.83, 62.4), controlPoint1: CGPointMake(94.5, 60.93), controlPoint2: CGPointMake(93.83, 61.59))
            bezierPath.addLineToPoint(CGPointMake(93.83, 70.74))
            bezierPath.addCurveToPoint(CGPointMake(95.33, 72.22), controlPoint1: CGPointMake(93.83, 71.56), controlPoint2: CGPointMake(94.5, 72.22))
            bezierPath.addLineToPoint(CGPointMake(99.93, 72.22))
            bezierPath.addCurveToPoint(CGPointMake(101.44, 70.74), controlPoint1: CGPointMake(100.76, 72.22), controlPoint2: CGPointMake(101.44, 71.55))
            bezierPath.addLineToPoint(CGPointMake(101.44, 62.4))
            bezierPath.addCurveToPoint(CGPointMake(99.93, 60.93), controlPoint1: CGPointMake(101.44, 61.59), controlPoint2: CGPointMake(100.76, 60.93))
            bezierPath.addLineToPoint(CGPointMake(95.33, 60.93))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(118.16, 45.87))
            bezierPath.addCurveToPoint(CGPointMake(116.65, 47.35), controlPoint1: CGPointMake(117.33, 45.87), controlPoint2: CGPointMake(116.65, 46.54))
            bezierPath.addLineToPoint(CGPointMake(116.65, 70.73))
            bezierPath.addCurveToPoint(CGPointMake(118.16, 72.22), controlPoint1: CGPointMake(116.65, 71.55), controlPoint2: CGPointMake(117.33, 72.22))
            bezierPath.addLineToPoint(CGPointMake(122.76, 72.22))
            bezierPath.addCurveToPoint(CGPointMake(124.26, 70.73), controlPoint1: CGPointMake(123.59, 72.22), controlPoint2: CGPointMake(124.26, 71.55))
            bezierPath.addLineToPoint(CGPointMake(124.26, 47.35))
            bezierPath.addCurveToPoint(CGPointMake(122.76, 45.87), controlPoint1: CGPointMake(124.26, 46.54), controlPoint2: CGPointMake(123.59, 45.87))
            bezierPath.addLineToPoint(CGPointMake(118.16, 45.87))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(106.74, 53.4))
            bezierPath.addCurveToPoint(CGPointMake(105.24, 54.88), controlPoint1: CGPointMake(105.91, 53.4), controlPoint2: CGPointMake(105.24, 54.07))
            bezierPath.addLineToPoint(CGPointMake(105.24, 70.74))
            bezierPath.addCurveToPoint(CGPointMake(106.74, 72.22), controlPoint1: CGPointMake(105.24, 71.56), controlPoint2: CGPointMake(105.92, 72.22))
            bezierPath.addLineToPoint(CGPointMake(111.35, 72.22))
            bezierPath.addCurveToPoint(CGPointMake(112.85, 70.74), controlPoint1: CGPointMake(112.18, 72.22), controlPoint2: CGPointMake(112.85, 71.55))
            bezierPath.addLineToPoint(CGPointMake(112.85, 54.88))
            bezierPath.addCurveToPoint(CGPointMake(111.35, 53.4), controlPoint1: CGPointMake(112.85, 54.06), controlPoint2: CGPointMake(112.17, 53.4))
            bezierPath.addLineToPoint(CGPointMake(106.74, 53.4))
            bezierPath.closePath()
            bezierPath.usesEvenOddFillRule = true;

            fillColor.setFill()
            bezierPath.fill()


            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.moveToPoint(CGPointMake(165.64, 40.36))
            bezier2Path.addCurveToPoint(CGPointMake(152.68, 27.53), controlPoint1: CGPointMake(165.64, 33.27), controlPoint2: CGPointMake(159.84, 27.53))
            bezier2Path.addCurveToPoint(CGPointMake(139.72, 40.36), controlPoint1: CGPointMake(145.52, 27.53), controlPoint2: CGPointMake(139.72, 33.27))
            bezier2Path.addCurveToPoint(CGPointMake(152.68, 53.19), controlPoint1: CGPointMake(139.72, 47.45), controlPoint2: CGPointMake(145.52, 53.19))
            bezier2Path.addCurveToPoint(CGPointMake(165.64, 40.36), controlPoint1: CGPointMake(159.84, 53.19), controlPoint2: CGPointMake(165.64, 47.45))
            bezier2Path.closePath()
            bezier2Path.moveToPoint(CGPointMake(132.91, 61.39))
            bezier2Path.addLineToPoint(CGPointMake(134.87, 82.93))
            bezier2Path.addCurveToPoint(CGPointMake(139.51, 87.3), controlPoint1: CGPointMake(135.09, 85.33), controlPoint2: CGPointMake(137.07, 87.2))
            bezier2Path.addLineToPoint(CGPointMake(140.95, 87.36))
            bezier2Path.addCurveToPoint(CGPointMake(141.68, 88.07), controlPoint1: CGPointMake(141.34, 87.37), controlPoint2: CGPointMake(141.66, 87.68))
            bezier2Path.addLineToPoint(CGPointMake(143.44, 110.71))
            bezier2Path.addCurveToPoint(CGPointMake(148.23, 115.1), controlPoint1: CGPointMake(143.63, 113.18), controlPoint2: CGPointMake(145.72, 115.1))
            bezier2Path.addLineToPoint(CGPointMake(157.21, 115.1))
            bezier2Path.addCurveToPoint(CGPointMake(162, 110.7), controlPoint1: CGPointMake(159.72, 115.1), controlPoint2: CGPointMake(161.81, 113.18))
            bezier2Path.addLineToPoint(CGPointMake(163.74, 88.07))
            bezier2Path.addCurveToPoint(CGPointMake(164.47, 87.35), controlPoint1: CGPointMake(163.77, 87.67), controlPoint2: CGPointMake(164.08, 87.37))
            bezier2Path.addLineToPoint(CGPointMake(165.91, 87.3))
            bezier2Path.addCurveToPoint(CGPointMake(170.49, 82.97), controlPoint1: CGPointMake(168.32, 87.19), controlPoint2: CGPointMake(170.28, 85.34))
            bezier2Path.addLineToPoint(CGPointMake(172.44, 61.39))
            bezier2Path.addLineToPoint(CGPointMake(172.44, 61.26))
            bezier2Path.addCurveToPoint(CGPointMake(165.69, 54.57), controlPoint1: CGPointMake(172.44, 57.56), controlPoint2: CGPointMake(169.42, 54.57))
            bezier2Path.addLineToPoint(CGPointMake(139.66, 54.57))
            bezier2Path.addCurveToPoint(CGPointMake(132.91, 61.26), controlPoint1: CGPointMake(135.93, 54.57), controlPoint2: CGPointMake(132.91, 57.56))
            bezier2Path.addLineToPoint(CGPointMake(132.91, 61.39))
            bezier2Path.closePath()
            bezier2Path.usesEvenOddFillRule = true;

            fillColor.setFill()
            bezier2Path.fill()


            //// Group
            CGContextSaveGState(context)
            CGContextBeginTransparencyLayer(context, nil)

            //// Clip Clip
            let clipPath = UIBezierPath()
            clipPath.moveToPoint(CGPointMake(123.65, 18.93))
            clipPath.addLineToPoint(CGPointMake(181.43, 18.93))
            clipPath.addLineToPoint(CGPointMake(181.43, 124))
            clipPath.addLineToPoint(CGPointMake(123.65, 124))
            clipPath.addLineToPoint(CGPointMake(123.65, 18.93))
            clipPath.closePath()
            clipPath.moveToPoint(CGPointMake(164.06, 40.6))
            clipPath.addCurveToPoint(CGPointMake(152.54, 51.92), controlPoint1: CGPointMake(164.06, 46.85), controlPoint2: CGPointMake(158.9, 51.92))
            clipPath.addCurveToPoint(CGPointMake(141.03, 40.6), controlPoint1: CGPointMake(146.18, 51.92), controlPoint2: CGPointMake(141.03, 46.85))
            clipPath.addCurveToPoint(CGPointMake(152.54, 29.29), controlPoint1: CGPointMake(141.03, 34.35), controlPoint2: CGPointMake(146.18, 29.29))
            clipPath.addCurveToPoint(CGPointMake(164.06, 40.6), controlPoint1: CGPointMake(158.9, 29.29), controlPoint2: CGPointMake(164.06, 34.35))
            clipPath.addLineToPoint(CGPointMake(164.06, 40.6))
            clipPath.closePath()
            clipPath.moveToPoint(CGPointMake(134.19, 61.44))
            clipPath.addLineToPoint(CGPointMake(136.15, 82.92))
            clipPath.addCurveToPoint(CGPointMake(139.37, 85.93), controlPoint1: CGPointMake(136.3, 84.57), controlPoint2: CGPointMake(137.68, 85.86))
            clipPath.addLineToPoint(CGPointMake(140.82, 85.99))
            clipPath.addCurveToPoint(CGPointMake(143, 88.08), controlPoint1: CGPointMake(141.99, 86.03), controlPoint2: CGPointMake(142.93, 86.93))
            clipPath.addLineToPoint(CGPointMake(144.76, 110.63))
            clipPath.addCurveToPoint(CGPointMake(148.08, 113.65), controlPoint1: CGPointMake(144.89, 112.33), controlPoint2: CGPointMake(146.34, 113.65))
            clipPath.addLineToPoint(CGPointMake(157.09, 113.65))
            clipPath.addCurveToPoint(CGPointMake(160.41, 110.63), controlPoint1: CGPointMake(158.83, 113.65), controlPoint2: CGPointMake(160.28, 112.33))
            clipPath.addLineToPoint(CGPointMake(162.15, 88.06))
            clipPath.addCurveToPoint(CGPointMake(164.33, 85.98), controlPoint1: CGPointMake(162.24, 86.92), controlPoint2: CGPointMake(163.17, 86.03))
            clipPath.addLineToPoint(CGPointMake(165.78, 85.92))
            clipPath.addCurveToPoint(CGPointMake(168.94, 82.96), controlPoint1: CGPointMake(167.44, 85.86), controlPoint2: CGPointMake(168.79, 84.59))
            clipPath.addLineToPoint(CGPointMake(170.9, 61.44))
            clipPath.addCurveToPoint(CGPointMake(165.61, 56.25), controlPoint1: CGPointMake(170.9, 58.57), controlPoint2: CGPointMake(168.53, 56.25))
            clipPath.addLineToPoint(CGPointMake(139.47, 56.25))
            clipPath.addCurveToPoint(CGPointMake(134.19, 61.44), controlPoint1: CGPointMake(136.55, 56.25), controlPoint2: CGPointMake(134.19, 58.57))
            clipPath.addLineToPoint(CGPointMake(134.19, 61.44))
            clipPath.closePath()
            clipPath.usesEvenOddFillRule = true;

            clipPath.addClip()


            //// Bezier 3 Drawing
            let bezier3Path = UIBezierPath()
            bezier3Path.moveToPoint(CGPointMake(164.06, 40.6))
            bezier3Path.addCurveToPoint(CGPointMake(152.54, 51.92), controlPoint1: CGPointMake(164.06, 46.85), controlPoint2: CGPointMake(158.9, 51.92))
            bezier3Path.addCurveToPoint(CGPointMake(141.03, 40.6), controlPoint1: CGPointMake(146.18, 51.92), controlPoint2: CGPointMake(141.03, 46.85))
            bezier3Path.addCurveToPoint(CGPointMake(152.54, 29.29), controlPoint1: CGPointMake(141.03, 34.35), controlPoint2: CGPointMake(146.18, 29.29))
            bezier3Path.addCurveToPoint(CGPointMake(164.06, 40.6), controlPoint1: CGPointMake(158.9, 29.29), controlPoint2: CGPointMake(164.06, 34.35))
            bezier3Path.addLineToPoint(CGPointMake(164.06, 40.6))
            bezier3Path.closePath()
            bezier3Path.moveToPoint(CGPointMake(134.19, 61.44))
            bezier3Path.addLineToPoint(CGPointMake(136.15, 82.92))
            bezier3Path.addCurveToPoint(CGPointMake(139.37, 85.93), controlPoint1: CGPointMake(136.3, 84.57), controlPoint2: CGPointMake(137.68, 85.86))
            bezier3Path.addLineToPoint(CGPointMake(140.82, 85.99))
            bezier3Path.addCurveToPoint(CGPointMake(143, 88.08), controlPoint1: CGPointMake(141.99, 86.03), controlPoint2: CGPointMake(142.93, 86.93))
            bezier3Path.addLineToPoint(CGPointMake(144.76, 110.63))
            bezier3Path.addCurveToPoint(CGPointMake(148.08, 113.65), controlPoint1: CGPointMake(144.89, 112.33), controlPoint2: CGPointMake(146.34, 113.65))
            bezier3Path.addLineToPoint(CGPointMake(157.09, 113.65))
            bezier3Path.addCurveToPoint(CGPointMake(160.41, 110.63), controlPoint1: CGPointMake(158.83, 113.65), controlPoint2: CGPointMake(160.28, 112.33))
            bezier3Path.addLineToPoint(CGPointMake(162.15, 88.06))
            bezier3Path.addCurveToPoint(CGPointMake(164.33, 85.98), controlPoint1: CGPointMake(162.24, 86.92), controlPoint2: CGPointMake(163.17, 86.03))
            bezier3Path.addLineToPoint(CGPointMake(165.78, 85.92))
            bezier3Path.addCurveToPoint(CGPointMake(168.94, 82.96), controlPoint1: CGPointMake(167.44, 85.86), controlPoint2: CGPointMake(168.79, 84.59))
            bezier3Path.addLineToPoint(CGPointMake(170.9, 61.44))
            bezier3Path.addCurveToPoint(CGPointMake(165.61, 56.25), controlPoint1: CGPointMake(170.9, 58.57), controlPoint2: CGPointMake(168.53, 56.25))
            bezier3Path.addLineToPoint(CGPointMake(139.47, 56.25))
            bezier3Path.addCurveToPoint(CGPointMake(134.19, 61.44), controlPoint1: CGPointMake(136.55, 56.25), controlPoint2: CGPointMake(134.19, 58.57))
            bezier3Path.addLineToPoint(CGPointMake(134.19, 61.44))
            bezier3Path.closePath()
            strokeColor.setStroke()
            bezier3Path.lineWidth = 8
            bezier3Path.stroke()

            CGContextEndTransparencyLayer(context)
            
        }else if(graphicToShow == 3){

            //// Color Declarations
            let fillColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
            let fillColor2 = UIColor(red: 0.200, green: 0.200, blue: 0.200, alpha: 1.000)
            let textForeground2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

            //// Group
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(102.09, 20.05))
            bezierPath.addCurveToPoint(CGPointMake(97.51, 15.39), controlPoint1: CGPointMake(99.56, 20.05), controlPoint2: CGPointMake(97.51, 17.96))
            bezierPath.addLineToPoint(CGPointMake(97.51, 4.22))
            bezierPath.addCurveToPoint(CGPointMake(102.09, -0.45), controlPoint1: CGPointMake(97.51, 1.64), controlPoint2: CGPointMake(99.56, -0.45))
            bezierPath.addCurveToPoint(CGPointMake(106.68, 4.22), controlPoint1: CGPointMake(104.62, -0.45), controlPoint2: CGPointMake(106.68, 1.64))
            bezierPath.addLineToPoint(CGPointMake(106.68, 15.39))
            bezierPath.addCurveToPoint(CGPointMake(102.09, 20.05), controlPoint1: CGPointMake(106.68, 17.96), controlPoint2: CGPointMake(104.62, 20.05))
            bezierPath.addLineToPoint(CGPointMake(102.09, 20.05))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(141.75, 15.39))
            bezierPath.addLineToPoint(CGPointMake(141.75, 4.22))
            bezierPath.addCurveToPoint(CGPointMake(137.16, -0.45), controlPoint1: CGPointMake(141.75, 1.64), controlPoint2: CGPointMake(139.7, -0.45))
            bezierPath.addCurveToPoint(CGPointMake(132.58, 4.22), controlPoint1: CGPointMake(134.64, -0.45), controlPoint2: CGPointMake(132.58, 1.64))
            bezierPath.addLineToPoint(CGPointMake(132.58, 15.39))
            bezierPath.addCurveToPoint(CGPointMake(137.16, 20.05), controlPoint1: CGPointMake(132.58, 17.96), controlPoint2: CGPointMake(134.64, 20.05))
            bezierPath.addCurveToPoint(CGPointMake(141.75, 15.39), controlPoint1: CGPointMake(139.7, 20.05), controlPoint2: CGPointMake(141.75, 17.96))
            bezierPath.addLineToPoint(CGPointMake(141.75, 15.39))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(157, 13.63))
            bezierPath.addLineToPoint(CGPointMake(157, 94.38))
            bezierPath.addCurveToPoint(CGPointMake(149.78, 101.74), controlPoint1: CGPointMake(157, 98.45), controlPoint2: CGPointMake(153.76, 101.74))
            bezierPath.addLineToPoint(CGPointMake(89.22, 101.74))
            bezierPath.addCurveToPoint(CGPointMake(82, 94.38), controlPoint1: CGPointMake(85.24, 101.74), controlPoint2: CGPointMake(82, 98.45))
            bezierPath.addLineToPoint(CGPointMake(82, 13.63))
            bezierPath.addCurveToPoint(CGPointMake(89.22, 6.28), controlPoint1: CGPointMake(82, 9.57), controlPoint2: CGPointMake(85.24, 6.28))
            bezierPath.addLineToPoint(CGPointMake(91.24, 6.28))
            bezierPath.addCurveToPoint(CGPointMake(93.72, 8.8), controlPoint1: CGPointMake(92.6, 6.28), controlPoint2: CGPointMake(93.72, 7.41))
            bezierPath.addLineToPoint(CGPointMake(93.72, 15.35))
            bezierPath.addCurveToPoint(CGPointMake(103.48, 23.74), controlPoint1: CGPointMake(93.72, 20.52), controlPoint2: CGPointMake(98.24, 24.61))
            bezierPath.addCurveToPoint(CGPointMake(110.43, 14.9), controlPoint1: CGPointMake(107.58, 23.06), controlPoint2: CGPointMake(110.43, 19.13))
            bezierPath.addLineToPoint(CGPointMake(110.43, 8.8))
            bezierPath.addCurveToPoint(CGPointMake(112.91, 6.28), controlPoint1: CGPointMake(110.43, 7.41), controlPoint2: CGPointMake(111.54, 6.28))
            bezierPath.addLineToPoint(CGPointMake(126.37, 6.28))
            bezierPath.addCurveToPoint(CGPointMake(128.84, 8.8), controlPoint1: CGPointMake(127.74, 6.28), controlPoint2: CGPointMake(128.84, 7.41))
            bezierPath.addLineToPoint(CGPointMake(128.84, 15.35))
            bezierPath.addCurveToPoint(CGPointMake(138.61, 23.74), controlPoint1: CGPointMake(128.84, 20.52), controlPoint2: CGPointMake(133.37, 24.61))
            bezierPath.addCurveToPoint(CGPointMake(145.56, 14.89), controlPoint1: CGPointMake(142.72, 23.06), controlPoint2: CGPointMake(145.56, 19.13))
            bezierPath.addLineToPoint(CGPointMake(145.56, 8.8))
            bezierPath.addCurveToPoint(CGPointMake(148.04, 6.28), controlPoint1: CGPointMake(145.56, 7.41), controlPoint2: CGPointMake(146.67, 6.28))
            bezierPath.addLineToPoint(CGPointMake(149.78, 6.28))
            bezierPath.addCurveToPoint(CGPointMake(157, 13.63), controlPoint1: CGPointMake(153.76, 6.28), controlPoint2: CGPointMake(157, 9.57))
            bezierPath.addLineToPoint(CGPointMake(157, 13.63))
            bezierPath.closePath()
            bezierPath.usesEvenOddFillRule = true;

            fillColor.setFill()
            bezierPath.fill()


            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.moveToPoint(CGPointMake(96.04, 66.14))
            bezier2Path.addCurveToPoint(CGPointMake(96, 62.04), controlPoint1: CGPointMake(94.93, 65.02), controlPoint2: CGPointMake(94.88, 63.16))
            bezier2Path.addLineToPoint(CGPointMake(108, 50.02))
            bezier2Path.addCurveToPoint(CGPointMake(111.34, 50.02), controlPoint1: CGPointMake(108.92, 49.1), controlPoint2: CGPointMake(110.41, 49.1))
            bezier2Path.addLineToPoint(CGPointMake(119.77, 58.48))
            bezier2Path.addCurveToPoint(CGPointMake(122.09, 58.48), controlPoint1: CGPointMake(120.41, 59.12), controlPoint2: CGPointMake(121.45, 59.12))
            bezier2Path.addLineToPoint(CGPointMake(130.69, 49.86))
            bezier2Path.addCurveToPoint(CGPointMake(130.69, 47.53), controlPoint1: CGPointMake(131.33, 49.22), controlPoint2: CGPointMake(131.33, 48.17))
            bezier2Path.addLineToPoint(CGPointMake(127.68, 44.52))
            bezier2Path.addCurveToPoint(CGPointMake(128.85, 41.7), controlPoint1: CGPointMake(126.65, 43.48), controlPoint2: CGPointMake(127.38, 41.7))
            bezier2Path.addLineToPoint(CGPointMake(140.39, 41.7))
            bezier2Path.addCurveToPoint(CGPointMake(142.92, 44.23), controlPoint1: CGPointMake(141.79, 41.7), controlPoint2: CGPointMake(142.92, 42.84))
            bezier2Path.addLineToPoint(CGPointMake(142.92, 55.8))
            bezier2Path.addCurveToPoint(CGPointMake(140.11, 56.97), controlPoint1: CGPointMake(142.92, 57.27), controlPoint2: CGPointMake(141.15, 58))
            bezier2Path.addLineToPoint(CGPointMake(137.12, 53.97))
            bezier2Path.addCurveToPoint(CGPointMake(134.8, 53.97), controlPoint1: CGPointMake(136.48, 53.33), controlPoint2: CGPointMake(135.44, 53.33))
            bezier2Path.addLineToPoint(CGPointMake(122.48, 66.28))
            bezier2Path.addCurveToPoint(CGPointMake(119.39, 66.28), controlPoint1: CGPointMake(121.63, 67.14), controlPoint2: CGPointMake(120.24, 67.14))
            bezier2Path.addLineToPoint(CGPointMake(110.83, 57.7))
            bezier2Path.addCurveToPoint(CGPointMake(108.51, 57.7), controlPoint1: CGPointMake(110.19, 57.06), controlPoint2: CGPointMake(109.15, 57.06))
            bezier2Path.addLineToPoint(CGPointMake(100.09, 66.14))
            bezier2Path.addCurveToPoint(CGPointMake(96.04, 66.14), controlPoint1: CGPointMake(98.97, 67.26), controlPoint2: CGPointMake(97.16, 67.26))
            bezier2Path.closePath()
            bezier2Path.usesEvenOddFillRule = true;
            
            fillColor2.setFill()
            bezier2Path.fill()
            

            //// Label Drawing
            let labelRect = CGRectMake(104.37, 73.58, 30.75, 20)
            let labelTextContent = NSString(string: "24/7")
            let labelStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            labelStyle.alignment = NSTextAlignment.Center

            let labelFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(UIFont.systemFontSize()), NSForegroundColorAttributeName: textForeground2, NSParagraphStyleAttributeName: labelStyle]

            let labelTextHeight: CGFloat = labelTextContent.boundingRectWithSize(CGSizeMake(labelRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).size.height
            CGContextSaveGState(context)
            CGContextClipToRect(context, labelRect);
            labelTextContent.drawInRect(CGRectMake(labelRect.minX, labelRect.minY + (labelRect.height - labelTextHeight) / 2, labelRect.width, labelTextHeight), withAttributes: labelFontAttributes)
            CGContextRestoreGState(context)
            
        }else if(graphicToShow == 4){
            
            //// Color Declarations
            let fillColor3 = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
            
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(132.87, 15.29))
            bezierPath.addCurveToPoint(CGPointMake(117.52, 30.59), controlPoint1: CGPointMake(132.87, 23.74), controlPoint2: CGPointMake(125.99, 30.59))
            bezierPath.addCurveToPoint(CGPointMake(102.16, 15.29), controlPoint1: CGPointMake(109.04, 30.59), controlPoint2: CGPointMake(102.16, 23.74))
            bezierPath.addCurveToPoint(CGPointMake(117.52, 0), controlPoint1: CGPointMake(102.16, 6.85), controlPoint2: CGPointMake(109.04, 0))
            bezierPath.addCurveToPoint(CGPointMake(132.87, 15.29), controlPoint1: CGPointMake(125.99, 0), controlPoint2: CGPointMake(132.87, 6.85))
            bezierPath.addLineToPoint(CGPointMake(132.87, 15.29))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(93.04, 43.45))
            bezierPath.addLineToPoint(CGPointMake(95.66, 72.48))
            bezierPath.addCurveToPoint(CGPointMake(99.95, 76.55), controlPoint1: CGPointMake(95.87, 74.72), controlPoint2: CGPointMake(97.7, 76.45))
            bezierPath.addLineToPoint(CGPointMake(101.89, 76.62))
            bezierPath.addCurveToPoint(CGPointMake(104.8, 79.45), controlPoint1: CGPointMake(103.45, 76.69), controlPoint2: CGPointMake(104.7, 77.9))
            bezierPath.addLineToPoint(CGPointMake(107.14, 109.93))
            bezierPath.addCurveToPoint(CGPointMake(111.56, 114), controlPoint1: CGPointMake(107.32, 112.23), controlPoint2: CGPointMake(109.24, 114))
            bezierPath.addLineToPoint(CGPointMake(123.58, 114))
            bezierPath.addCurveToPoint(CGPointMake(128, 109.92), controlPoint1: CGPointMake(125.89, 114), controlPoint2: CGPointMake(127.82, 112.23))
            bezierPath.addLineToPoint(CGPointMake(130.33, 79.43))
            bezierPath.addCurveToPoint(CGPointMake(133.22, 76.62), controlPoint1: CGPointMake(130.43, 77.89), controlPoint2: CGPointMake(131.68, 76.68))
            bezierPath.addLineToPoint(CGPointMake(135.15, 76.54))
            bezierPath.addCurveToPoint(CGPointMake(139.37, 72.53), controlPoint1: CGPointMake(137.37, 76.45), controlPoint2: CGPointMake(139.17, 74.74))
            bezierPath.addLineToPoint(CGPointMake(141.98, 43.45))
            bezierPath.addCurveToPoint(CGPointMake(134.94, 36.44), controlPoint1: CGPointMake(141.98, 39.58), controlPoint2: CGPointMake(138.83, 36.44))
            bezierPath.addLineToPoint(CGPointMake(100.09, 36.44))
            bezierPath.addCurveToPoint(CGPointMake(93.04, 43.45), controlPoint1: CGPointMake(96.2, 36.44), controlPoint2: CGPointMake(93.04, 39.58))
            bezierPath.addLineToPoint(CGPointMake(93.04, 43.45))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(148.09, 43.45))
            bezierPath.addLineToPoint(CGPointMake(145.45, 73.07))
            bezierPath.addCurveToPoint(CGPointMake(137.99, 82.18), controlPoint1: CGPointMake(145.06, 77.41), controlPoint2: CGPointMake(142.02, 80.97))
            bezierPath.addCurveToPoint(CGPointMake(136.04, 84.51), controlPoint1: CGPointMake(137.02, 82.48), controlPoint2: CGPointMake(136.12, 83.5))
            bezierPath.addLineToPoint(CGPointMake(134.58, 100.75))
            bezierPath.addCurveToPoint(CGPointMake(137.86, 104.32), controlPoint1: CGPointMake(134.4, 102.67), controlPoint2: CGPointMake(135.93, 104.32))
            bezierPath.addLineToPoint(CGPointMake(146.85, 104.32))
            bezierPath.addCurveToPoint(CGPointMake(150.73, 100.74), controlPoint1: CGPointMake(148.89, 104.32), controlPoint2: CGPointMake(150.58, 102.77))
            bezierPath.addLineToPoint(CGPointMake(152.77, 73.99))
            bezierPath.addCurveToPoint(CGPointMake(155.32, 71.53), controlPoint1: CGPointMake(152.87, 72.64), controlPoint2: CGPointMake(153.97, 71.58))
            bezierPath.addLineToPoint(CGPointMake(157.01, 71.45))
            bezierPath.addCurveToPoint(CGPointMake(160.71, 67.94), controlPoint1: CGPointMake(158.95, 71.37), controlPoint2: CGPointMake(160.54, 69.87))
            bezierPath.addLineToPoint(CGPointMake(163, 42.42))
            bezierPath.addCurveToPoint(CGPointMake(156.82, 36.27), controlPoint1: CGPointMake(163, 39.02), controlPoint2: CGPointMake(160.23, 36.27))
            bezierPath.addLineToPoint(CGPointMake(149.62, 36.27))
            bezierPath.addCurveToPoint(CGPointMake(147.41, 39.34), controlPoint1: CGPointMake(148.03, 36.27), controlPoint2: CGPointMake(146.91, 37.82))
            bezierPath.addCurveToPoint(CGPointMake(148.09, 43.45), controlPoint1: CGPointMake(147.85, 40.63), controlPoint2: CGPointMake(148.09, 42.01))
            bezierPath.addLineToPoint(CGPointMake(148.09, 43.45))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(139.7, 4.43))
            bezierPath.addCurveToPoint(CGPointMake(137.66, 7.92), controlPoint1: CGPointMake(138.06, 4.67), controlPoint2: CGPointMake(137.07, 6.37))
            bezierPath.addCurveToPoint(CGPointMake(135.74, 26.55), controlPoint1: CGPointMake(140.11, 14.31), controlPoint2: CGPointMake(139.27, 21.02))
            bezierPath.addCurveToPoint(CGPointMake(137.12, 30.36), controlPoint1: CGPointMake(134.85, 27.95), controlPoint2: CGPointMake(135.55, 29.81))
            bezierPath.addCurveToPoint(CGPointMake(155.02, 16.36), controlPoint1: CGPointMake(146.32, 33.61), controlPoint2: CGPointMake(156, 26.27))
            bezierPath.addCurveToPoint(CGPointMake(139.7, 4.43), controlPoint1: CGPointMake(154.3, 8.95), controlPoint2: CGPointMake(147.41, 3.31))
            bezierPath.addLineToPoint(CGPointMake(139.7, 4.43))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(87.59, 39.34))
            bezierPath.addCurveToPoint(CGPointMake(85.37, 36.27), controlPoint1: CGPointMake(88.09, 37.82), controlPoint2: CGPointMake(86.97, 36.27))
            bezierPath.addLineToPoint(CGPointMake(78.18, 36.27))
            bezierPath.addCurveToPoint(CGPointMake(72, 42.42), controlPoint1: CGPointMake(74.76, 36.27), controlPoint2: CGPointMake(72, 39.02))
            bezierPath.addLineToPoint(CGPointMake(74.29, 67.94))
            bezierPath.addCurveToPoint(CGPointMake(77.99, 71.45), controlPoint1: CGPointMake(74.46, 69.87), controlPoint2: CGPointMake(76.04, 71.37))
            bezierPath.addLineToPoint(CGPointMake(79.68, 71.53))
            bezierPath.addCurveToPoint(CGPointMake(82.22, 73.99), controlPoint1: CGPointMake(81.03, 71.58), controlPoint2: CGPointMake(82.13, 72.64))
            bezierPath.addLineToPoint(CGPointMake(84.27, 100.74))
            bezierPath.addCurveToPoint(CGPointMake(88.15, 104.32), controlPoint1: CGPointMake(84.42, 102.77), controlPoint2: CGPointMake(86.11, 104.32))
            bezierPath.addLineToPoint(CGPointMake(97.13, 104.32))
            bezierPath.addCurveToPoint(CGPointMake(100.42, 100.75), controlPoint1: CGPointMake(99.07, 104.32), controlPoint2: CGPointMake(100.59, 102.67))
            bezierPath.addLineToPoint(CGPointMake(98.96, 84.51))
            bezierPath.addCurveToPoint(CGPointMake(97, 82.18), controlPoint1: CGPointMake(98.87, 83.5), controlPoint2: CGPointMake(97.98, 82.48))
            bezierPath.addCurveToPoint(CGPointMake(89.54, 73.07), controlPoint1: CGPointMake(92.97, 80.97), controlPoint2: CGPointMake(89.93, 77.41))
            bezierPath.addLineToPoint(CGPointMake(86.91, 43.45))
            bezierPath.addCurveToPoint(CGPointMake(87.59, 39.34), controlPoint1: CGPointMake(86.91, 42.01), controlPoint2: CGPointMake(87.15, 40.63))
            bezierPath.addLineToPoint(CGPointMake(87.59, 39.34))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(79.97, 16.36))
            bezierPath.addCurveToPoint(CGPointMake(97.87, 30.36), controlPoint1: CGPointMake(79, 26.27), controlPoint2: CGPointMake(88.68, 33.61))
            bezierPath.addCurveToPoint(CGPointMake(99.25, 26.55), controlPoint1: CGPointMake(99.45, 29.81), controlPoint2: CGPointMake(100.15, 27.95))
            bezierPath.addCurveToPoint(CGPointMake(97.34, 7.92), controlPoint1: CGPointMake(95.72, 21.02), controlPoint2: CGPointMake(94.88, 14.31))
            bezierPath.addCurveToPoint(CGPointMake(95.3, 4.43), controlPoint1: CGPointMake(97.93, 6.37), controlPoint2: CGPointMake(96.94, 4.67))
            bezierPath.addCurveToPoint(CGPointMake(79.97, 16.36), controlPoint1: CGPointMake(87.59, 3.31), controlPoint2: CGPointMake(80.7, 8.95))
            bezierPath.addLineToPoint(CGPointMake(79.97, 16.36))
            bezierPath.closePath()
            bezierPath.usesEvenOddFillRule = true;
            
            fillColor3.setFill()
            bezierPath.fill()
            
        }
        
        
        let color2 = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.000)
        
        //// Text Drawing
        let textRect = CGRectMake(2, 114, 240, 41)
        let textTextContent = NSString(string: TitleName)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Text 2 Drawing
        
        let text2Rect = CGRectMake(0, 155, 240, 155)
        let text2Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text2Style.alignment = NSTextAlignment.Center
        let text2FontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: text2Style]
        DescName.drawInRect(text2Rect, withAttributes: text2FontAttributes)
    }
    
}
    