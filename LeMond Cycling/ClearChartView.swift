//
//  ClearChartView.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 8/14/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import WatchCoreDataProxy

class ClearChartView: UIView {
    
    // var bl : BarchartViewController!
    var overlayBg = ShareWorkoutBackground()
    
    
    
    /**
    <#Description#>
    
    - parameter rect: <#rect description#>
    */
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        
//        overlayBg.alpha = 1
//        overlayBg.frame = CGRect(
//            x: CGFloat(rect.origin.x),
//            y: CGFloat(rect.origin.y),
//            width: CGFloat(rect.width),
//            height: CGFloat(rect.height)
//        )
//        
//        println("here is rectangle width\(rect.width)")
//        println("here is rectangle height\(rect.height)")
//        overlayBg.backgroundColor = UIColor.greenColor()
//        self.addSubview(overlayBg)
//        
    }
    
    
    
}
