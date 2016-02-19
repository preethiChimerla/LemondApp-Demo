//
//  ComputerRuntimeVariables.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/20/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


struct ComputerRuntimeVariables {
    
    static var Imperial = true
    
    //
    static var Altitude: Double!
    static var Grade: Double!
    
    
    
    // Current elasped tiem
    static var elapsedTime: NSTimeInterval!
    
    // Peaks and Averages for storage
    static var CadencePeak = 0.0
    static var CadenceAverage = 0.0
    static var PowerPeak = 0.0
    static var PowerAverage = 0.0
    static var SpeedPeak = 0.0
    static var SpeedAverage = 0.0
    static var HeartratePeak = 0.0
    static var HeartrateAverage = 0.0
    
    // Current Values
    static var Speed = 0.0
    static var Power = 0.0
    static var Cadence = 0.0
    static var Heartrate = 0.0
    static var Calories = 0.0
    
    // Old for determingin how the cirlce gets loaded
    static var OldSpeed: Double!
    static var OldPower: Double!
    static var OldCadence: Double!
    static var OldHeartrate: Double!
    static var OldCalories: Double!
    
    // This is the current Time as a String.  Thus: 00:15.12
    static var CurrentTime: String!
    
    // Running?
    static var CumulativeDistance = 0.0
    static var CumulativeCalories = 0.0
    
    static var ButtonMode = 0
    static var UsageMode = 10
    static var HasStarted = false
    static var StartTime:NSTimeInterval!
    static var PauseTime:NSTimeInterval!
    static var PauseBuffer:NSTimeInterval!
    
    // we we're going to store everything by the Name... However on second thought, the date may be more appropriate.
    static var SavedName = ""
    static var OrigDate:NSDate!
    
    
    static var LocationTracker: [CLLocation] = []
    static var ElevationPoints: [Double] = []
    static var LoginCount:Int = 0
    static var MapCount:Int = 0
    static var PinTracker: [CLLocation] = []
    static var MetricMode: Int = 0
    
    static var PolylinePoint:Int = 0
    static var NavigationStatus:Int = 0
    static var NavigationDirection:Int = 0


    // Prompt ... 
    static var TrainingMode = false
    static var TrainingPromptCount:Int = 0
    static var PromptCheck:Int = 0
    static var PromptLink:Int = 0
    static var PromptView:Int = 0
    static var StoredRideRoute:Int = 0
    
    static var CurrentCoordinate: CLLocationCoordinate2D!

}

