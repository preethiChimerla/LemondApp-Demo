//
//  LeMondRide.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/20/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreData

public class LeMondRide: NSManagedObject {

    @NSManaged public var cadenceAverage: NSNumber
    @NSManaged public var cadencePeak: NSNumber
    @NSManaged public var calories: NSNumber
    @NSManaged public var date: NSDate
    @NSManaged public var distance: NSNumber
    @NSManaged public var heartRateAverage: NSNumber
    @NSManaged public var heartRatePeak: NSNumber
    @NSManaged public var metric: NSNumber
    @NSManaged public var name: String
    @NSManaged public var speedAverage: NSNumber
    @NSManaged public var speedPeak: NSNumber
    @NSManaged public var time: NSNumber
    @NSManaged public var wattAverage: NSNumber
    @NSManaged public var wattPeak: NSNumber
    @NSManaged public var rideData: NSSet

}


public extension LeMondRide {
    public func addListObject(value:LeMondRideData) {
        let items = self.mutableSetValueForKey("rideData");
        items.addObject(value)
    }

    public func removeListObject(value:LeMondRideData) {
        let items = self.mutableSetValueForKey("rideData");
        items.removeObject(value)
    }
}