//
//  SaveOverlay.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/12/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class SaveWorkoutOverlay: UIView {

    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color3 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.699)

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 303, 272))
        color3.setFill()
        rectanglePath.fill()

    }

}