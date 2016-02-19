//
//  LeMondRideData.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 7/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreData

public class LeMondRideData: NSManagedObject {

    @NSManaged public var cadence: NSNumber
    @NSManaged public var elevation: NSNumber
    @NSManaged public var heartrate: NSNumber
    @NSManaged public var latitude: NSNumber
    @NSManaged public var longitude: NSNumber
    @NSManaged public var power: NSNumber
    @NSManaged public var speed: NSNumber
    @NSManaged public var timestamp: NSNumber
    @NSManaged public var ride: LeMondRide

}

public extension LeMondRideData{
}