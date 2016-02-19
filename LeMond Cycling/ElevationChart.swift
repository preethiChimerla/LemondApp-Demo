//
//  ElevationChart.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/26/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit


class ElevationChart : UIView{

    /// Our plot points
    var points:[Double]!

    var cs = UIColors()

    /**
    Draw her up!

    - parameter rect: <#rect description#>
    */
    override func drawRect(rect: CGRect) {

        if(points == nil){
            return
        }

        points = Array(points.reverse())

        let ctx = UIGraphicsGetCurrentContext()

        cs.setStandard()
        // Get the context
        CGContextSetFillColorWithColor(ctx, cs.background.CGColor)
        CGContextFillRect(ctx, rect)


        let height = CGRectGetHeight(rect)
        let width = CGRectGetWidth(rect)
        let wc = Double(Double(points.count) / Double(width))

        var offset = 0.0
        if( (wc * Double(points.count)) < Double(width) ){
            offset =  Double(width) - ( wc * Double(points.count))
            offset = offset / Double(points.count)
        }

        // Noramilze the inputs
        var ceil:Double!
        var floor:Double!
        for i in points {
            if(ceil == nil){
                ceil = i
            }
            if(floor == nil){
                floor = i
            }
            if(i > ceil){
                ceil = i
            }
            if(i < floor){
                floor = i
            }
        }

        // Let's draw her out!
        var wcc = 0.0
        for i in points {
            // sanitize the height
            let chh = sanitizeHeight( Double(height), ceil: ceil, floor:floor, input: i)
            if(!chh.isNaN){
                CGContextSetLineWidth(ctx, 1.0)
                CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
                CGContextMoveToPoint(ctx, CGFloat(wcc), CGFloat(chh) )
                CGContextAddLineToPoint(ctx, CGFloat(wcc), height  )
                CGContextStrokePath(ctx)
                wcc += (wc + offset)
            }
        }
    }

    /**
    Sanitize the Height

    - parameter h:     <#h description#>
    - parameter ceil:  <#ceil description#>
    - parameter floor: <#floor description#>
    - parameter input: <#input description#>

    - returns: <#return value description#>
    */
    func sanitizeHeight( h: Double, ceil: Double, floor: Double, input: Double) -> Double {
        return h - (((ceil - floor) - (ceil - input)) * (h / (ceil - floor)))
    }

    func refesh(){
        self.setNeedsDisplay()
    }
    
}