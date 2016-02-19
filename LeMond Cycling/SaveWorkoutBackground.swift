//
//  SaveWorkoutBackground.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/12/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class SaveWorkoutBackground: UIView {
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color4 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.598)

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 423, 684))
        color4.setFill()
        rectanglePath.fill()
    }
}
