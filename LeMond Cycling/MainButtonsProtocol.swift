//
//  ButtonsProtocol.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 5/22/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

protocol MainButtonsProtocol {
    
    func settingspopup()

    func startstopTimer(leTime: String)

    func showComputerMain()
    
    // added by Vicky on Aug 26th.
    func showWeather()
    // added by Vicky on Aug 26th.
    func showMap()
}
