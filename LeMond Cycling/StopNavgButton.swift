//
//  StopNavgButton.swift
//  LeMond Cycling
//
//  Created by xiulan li on 8/28/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class StopNavgButton: UIButton {
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        UIColor.redColor().setFill()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(2, 2, 25, 25))
        ovalPath.fill()
        
        
        //// GO Drawing
        let gORect = CGRectMake(2, 2, 25, 25)
        let gOTextContent = NSString(string: "X")
        let gOStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        gOStyle.alignment = NSTextAlignment.Center
        
        let gOFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: gOStyle]
        
        let gOTextHeight: CGFloat = gOTextContent.boundingRectWithSize(CGSizeMake(gORect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: gOFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, gORect);
        gOTextContent.drawInRect(CGRectMake(gORect.minX, gORect.minY + (gORect.height - gOTextHeight) / 2, gORect.width, gOTextHeight), withAttributes: gOFontAttributes)
        CGContextRestoreGState(context)
    }
}