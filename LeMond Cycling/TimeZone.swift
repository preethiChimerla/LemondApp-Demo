//
//  TimeZone.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/24/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation


struct TimeZone {
    
    
    /**
    ltzAbbrev()  //
    
    - returns: "GMT-2"
    */
    static func ltzAbbrev() -> String {
        return NSTimeZone.localTimeZone().abbreviation!
    }
    
    
    
    
    /**
    isDaylightSavingTime() -
    
    - returns: true (in effect)
    */
    static func isDaylightSavingTime() -> Bool {
        return NSTimeZone.localTimeZone().daylightSavingTime
    }
    
    
    /**
    daylightSavingTimeOffset()  //
    
    - returns: 3,600.0 seconds (+1 hour)
    */
    static func daylightSavingTimeOffset() -> NSTimeInterval {
        return NSTimeZone.localTimeZone().daylightSavingTimeOffset
    }
    
    
    
    /**
    nextDaylightSavingTimeTransition()!  // Feb 21, 2015, 11:00 PM (End of DaylightSavingTime)
    // every body needs to ajust their clock -1 hour
    // at the end of the DaylightSavingTime period
    // normally the offset from GMT here is -3 hours
    // -10800s
    
    - returns: <#return value description#>
    */
    static func nextDaylightSavingTimeTransition() -> NSDate? {
        return NSTimeZone.localTimeZone().nextDaylightSavingTimeTransition
    }
    
    
    
    
    /**
    nextDaylightSavingTimeTransitionAfterNext()! //  "Oct 18, 2015, 1:00 AM - when DaylightSavingTime starts again
    
    - returns: NSDate
    */
    static func nextDaylightSavingTimeTransitionAfterNext() -> NSDate? {
        if let thereIsDaylightSavingAtUserLocation = nextDaylightSavingTimeTransition() {
            return NSTimeZone.localTimeZone().nextDaylightSavingTimeTransitionAfterDate(thereIsDaylightSavingAtUserLocation)
        }
        return nil
    }
    
    

}