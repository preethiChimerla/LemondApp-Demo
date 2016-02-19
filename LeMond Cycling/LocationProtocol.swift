//
//  LocationProtocol.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/31/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation


protocol LocationProtocol {
    func didRecieveSpeedUpdate(speed: Double)

    func didReceivePowerUpdate(power: Double)

    func updateMapWithLatLon(lat: Double, lon: Double)

    func didReceiveGradeUpdate(grade: Double)

    func didReceiveLatLonGrade(lat: Double, lon: Double, altitude: Double)

    func didReceiveDistanceUpdate(distance: Double)

    func didReceiveCalorieUpdate(cal: Double)

    func didReceiveAltitude(altitude: Double)
    
}

