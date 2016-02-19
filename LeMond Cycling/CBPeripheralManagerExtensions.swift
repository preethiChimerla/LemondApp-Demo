//
//  CBPeripheralManagerExtensions.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBPeripheralManagerState {
    func asString() -> String {
        switch self {
        case Unknown:
            return "Unknown"
        case Resetting:
            return "Unknown"
        case Unsupported:
            return "Unsupported"
        case Unauthorized:
            return "Unauthorized"
        case PoweredOff:
            return "PoweredOff"
        case PoweredOn:
            return "PoweredOn"
        }
    }
}
