//
//  LeMondColors.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 4/12/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

struct UIColors {

    // Standard Colors

    var barStyle = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var topNav = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var background = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var highlights = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var icons = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var text = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)

    var speed = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var power = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var cadence = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var heartrate = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

    var barSpeed = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var barPower = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var barCadence = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var barHeartrate = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

    var subNumberText = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)


    // Modify HEX to RGB
    func UIColorFromRGB(rgbValue: UInt32) -> UIColor {
        let r = Float((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Float((rgbValue & 0xFF00) >> 8) / 255.0
        let b = Float((rgbValue & 0xFF)) / 255.0
        let c = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        return c;
    }



    // Set to the Default color Schemes
    mutating func setStandard() {

        barStyle = UIColorFromRGB(0x212425)
        topNav = UIColorFromRGB(0x58585B)
        background = UIColorFromRGB(0x2F2F2F) // 010011 // 110128

        // Main Dials
        speed = UIColorFromRGB(0x0C35DE)
        power = UIColorFromRGB(0x53F80D)
        cadence = UIColorFromRGB(0xFFE200)
        heartrate = UIColorFromRGB(0xFF0000)

        barSpeed = UIColorFromRGB(0xFFE200)
        barPower = UIColorFromRGB(0x12D2FF)
        barCadence = UIColorFromRGB(0x53F80D)
        barHeartrate = UIColorFromRGB(0xFF0000)

        subNumberText = UIColorFromRGB(0x939597)
    }


    // length should be defined in seconds
    func setInterval(length: Int16) {


    }

    // Set threshold colors
    func setThreshold() {

    }



    // Set Return Functions
    func getTextColor() -> UIColor {
        return text
    }

}