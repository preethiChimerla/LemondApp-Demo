//
//  RadarView.swift
//  LeMond Cycling
//
//  Created by xiulan li on 8/25/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
class RadarView:UIView{
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    
    func refresh(){
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.546)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, width, height))
        color.setFill()
        rectanglePath.fill()
    }
    
}