//
//  MainNavigationController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 7/2/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {

    override func shouldAutorotate() -> Bool {
        return false
    }

    /**
    <#Description#>

    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

}