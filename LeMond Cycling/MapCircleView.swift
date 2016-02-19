//
//  MapCircleView.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/10/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class MapCircleView: UIButton {

    var currentNumber: String = "00"

    func updateSpeed(speed: Double) {
        currentNumber = String(format: "%.1f", speed)
        self.setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.407)
        _ = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 100, 100))
        color.setFill()
        ovalPath.fill()


        //// Text Drawing
        let textRect = CGRectMake(14, 11, 71, 77)
        let textTextContent = NSString(string: currentNumber)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center

        let textFontAttributes = [NSFontAttributeName: UIFont(name: "UnitedSansSemiCond-Heavy", size: 30)!, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)


        makeCircle(rect: rect)
    }

    func makeCircle(rect rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        let leColor = UIColor.whiteColor()

        // decide on radius
        let rad = CGFloat(50.0)

        for i in 1 ... 60 {

            // save the original position and origin
            CGContextSaveGState(context)
            // make translation
            CGContextTranslateCTM(context, CGRectGetMidX(rect), (CGRectGetMidY(rect)))
            // make rotation
            CGContextRotateCTM(context, degree2radian(CGFloat(i) * 6))
            if i % 5 == 0 {
                // if an hour position we want a line slightly longer
                drawSecondMarker(ctx: context!, x: rad - 20, y: 0, radius: rad - 10, color: leColor, size: 1.5)
            } else {
                drawSecondMarker(ctx: context!, x: rad - 10, y: 0, radius: rad, color: leColor, size: 1.5)
            }
            // restore state before next translation
            CGContextRestoreGState(context)

        }
    }


    /**
    Draw Second Marker
    
    - parameter ctx:    <#ctx description#>
    - parameter x:      <#x description#>
    - parameter y:      <#y description#>
    - parameter radius: <#radius description#>
    - parameter color:  <#color description#>
    - parameter size:   <#size description#>
    */
    func drawSecondMarker(ctx ctx: CGContextRef, x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor, size: Float) {
        // generate a path
        let path = CGPathCreateMutable()
        // move to starting point on edge of circle
        CGPathMoveToPoint(path, nil, radius, y)
        // draw line of required length
        CGPathAddLineToPoint(path, nil, x, y)
        // close subpath
        CGPathCloseSubpath(path)
        // add the path to the context
        CGContextAddPath(ctx, path)
        // set the line width
        CGContextSetLineWidth(ctx, CGFloat(size))
        // set the line color
        CGContextSetStrokeColorWithColor(ctx, color.CGColor)
        // draw the line
        CGContextStrokePath(ctx)
    }

    /**
    Calculate Degree 2 Radian
    
    - parameter a: Float which is a Degree
    
    - returns: a Float which is a Radian
    */
    func degree2radian(a: CGFloat) -> CGFloat {
        let b = CGFloat(M_PI) * a / 180
        return b
    }

}