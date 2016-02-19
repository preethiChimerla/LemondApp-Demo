//
//  MapGoButton.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 7/23/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class MapGoButton: UIButton {
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color4 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(2, 2, 25, 25))
        color4.setFill()
        ovalPath.fill()


        //// GO Drawing
        let gORect = CGRectMake(4, 4, 27, 21)
        let gOTextContent = NSString(string: "GO")
        let gOStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        gOStyle.alignment = NSTextAlignment.Left

        let gOFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: gOStyle]

        let gOTextHeight: CGFloat = gOTextContent.boundingRectWithSize(CGSizeMake(gORect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: gOFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, gORect);
        gOTextContent.drawInRect(CGRectMake(gORect.minX, gORect.minY + (gORect.height - gOTextHeight) / 2, gORect.width, gOTextHeight), withAttributes: gOFontAttributes)
        CGContextRestoreGState(context)
    }
}