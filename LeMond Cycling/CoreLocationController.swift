//
//  CoreLocationController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreLocation
import WatchCoreDataProxy


class CoreLocationController: NSObject, CLLocationManagerDelegate {

    //var useMetric = 0;

    var lastLocation: CLLocation!
    var lastCalled = 0.0
    var loadPost = [Float]()
    var speeds = [Float]()
    var pastLocation = [Double]()

    let settings = StoreUserDefaults()
    var temperature: NSNumber!
    var tempValue = 0.0
    var windSpeed: NSNumber!
    var headwindValue = 0.0
    var windDirection = ""
    var movingDirection = 0.0
    var windDegree = 0.0


    var locationManager: CLLocationManager = CLLocationManager()

    // Delegate
    var delegate: LocationProtocol?

    // P = 0.5 x ρ x v3 x Cd x A
    var calcMode = 0
    var units = 1

    //
    // 0 --> Clinchers
    // 1 --> Tubular
    // 2 --> MTB
    var tireValues = [0.005, 0.004, 0.012]

    //  INDEX ASSOC
    //  0 --> Hoods
    //  1 --> Bartops
    //  2 --> Bar ends
    //  2 --> Drops
    //  2 --> Aerobar
    var aeroValues = [0.388, 0.445, 0.42, 0.3, 0.233, 0.2]


    /**
     <#Description#>

     - returns: <#return value description#>
     */
    override init() {
        super.init()

        ComputerRuntimeVariables.Speed = 0.0
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        // Core Data Proxy
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"

        // We actually don't want any distance filter.
        // self.locationManager.distanceFilter  = 3000 // Must move at least 3km
        // self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Accurate within a kilometer
        //println("Heading Available: \(CLLocationManager.headingAvailable())")
    }


    /**
     Location Manager

     - parameter manager:   <#manager description#>
     - parameter locations: <#locations description#>
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations[0]
        let lon = location.coordinate.longitude //  locValue.longitude
        let lat = location.coordinate.latitude // locValue.latitude

        let currentTime = NSDate().timeIntervalSince1970 * 1000

        if( ComputerRuntimeVariables.ButtonMode == 1 ){
            ComputerRuntimeVariables.LocationTracker.append(locations[0])
        }


        //ComputerRuntimeVariables.Altitude = manager.locations.altitude
        //println("Current Location \(ComputerRuntimeVariables.Altitude)")
        // ComputerRuntimeVariables.Altitude = manager.location.altitude
        ComputerRuntimeVariables.Altitude = location.altitude
        //println("Current Altitude \(location.altitude)")

        let locValue: CLLocationCoordinate2D = location.coordinate // manager.location!.coordinate
        //let long = locValue.longitude
        //let lat = locValue.latitude

        var diff = 0.0
        if (lastCalled > 0.0) {
            diff = currentTime - lastCalled
        }

        var grade = 0.0
        if (pastLocation.count > 0) {

            grade = didReceiveGradeUpdate(
                Double(lon),
                loc1y: Double(lat),
                loc1z: Double(location.altitude),
                loc2x: Double(pastLocation[0]),
                loc2y: Double(pastLocation[1]),
                loc2z: Double(pastLocation[2])
            )

            pastLocation[0] = lon
            pastLocation[1] = lat
            pastLocation[2] = location.altitude
        } else {
            pastLocation.append(lon)
            pastLocation.append(lat)
            pastLocation.append(location.altitude)
        }

        // Storing the Grade
        ComputerRuntimeVariables.Grade = grade

        if(lastLocation == nil){
            lastCalled = currentTime
            lastLocation = location
            return
        }

        let leLastLocation = location.distanceFromLocation(lastLocation)

        // println("Distance -> \(leLastLocation)")
        determinPower(diff, leDistance: Double(leLastLocation));
        let cal = determinCalories((diff / 1000) * 0.000277778)


        if (ComputerRuntimeVariables.MetricMode == 1) {
            ComputerRuntimeVariables.Speed = manager.location!.speed * 3.6
            self.delegate?.didRecieveSpeedUpdate(manager.location!.speed * 3.6)
            self.delegate?.didReceiveDistanceUpdate(leLastLocation)
            // Elevation
            self.delegate?.didReceiveAltitude(ComputerRuntimeVariables.Altitude)
        } else {
            ComputerRuntimeVariables.Speed = manager.location!.speed * 2.23694
            self.delegate?.didRecieveSpeedUpdate(manager.location!.speed * 2.23694)
            self.delegate?.didReceiveDistanceUpdate(leLastLocation * 0.000621371)
            // Elevation
            self.delegate?.didReceiveAltitude(ComputerRuntimeVariables.Altitude * 3.28084)
        }

        self.delegate?.didReceivePowerUpdate(ComputerRuntimeVariables.Power)
        self.delegate?.didReceiveCalorieUpdate(cal)
        self.delegate?.updateMapWithLatLon(location.coordinate.latitude, lon: location.coordinate.longitude)

        if( ComputerRuntimeVariables.ButtonMode == 1 ){
            // Add Power to the chart to!
            ComputerRuntimeVariables.ElevationPoints.append(ComputerRuntimeVariables.Altitude)
        }

        // Store our location
        storeLocation(location.coordinate.latitude, lon: location.coordinate.longitude, altitude: location.altitude)

        lastCalled = currentTime
        lastLocation = location
    }

    /**
     Virtual Calorie Computation

     - parameter leTime: <#leTime description#>

     - returns: <#return value description#>
     */
    func determinCalories(leTime: Double) -> Double {

        // avg power (W) X duration (hours) X 3.6
        let calories = ComputerRuntimeVariables.Power * leTime * 3.6
        // println(" Calories \(calories)")
        return calories
    }

    /**
     Determin Power Output

     - parameter leTime:     <#leTime description#>
     - parameter leDistance: <#leDistance description#>
     */
    func determinPower(leTime: Double, leDistance: Double) {

        units = ComputerRuntimeVariables.MetricMode == 0 ? 1 : 0

        // fetch temperature data from Aeris weather SDK
        if temperature != nil {
            tempValue = temperature.doubleValue

        } else {
            tempValue = 0.0
        }

        // update headwindValue using windSpeed and windDirection from the weather SDK

        if windSpeed != nil {
            //println("windSpeed : \(windSpeed.doubleValue)")
            //println("windDirection: \(windDirection)")
            //println("movingDirection: \(movingDirection)")
            determinHeadwindValue(windSpeed.doubleValue, windDirection: windDirection, movingDirection: movingDirection)
            //println("headwindValue: \(headwindValue)")
        } else {
            headwindValue = 0.0
        }

        let elevValue = ComputerRuntimeVariables.Altitude
        let riderWeightValue = (settings.UserWeight as NSString).doubleValue == 0.0 ? 150 : (settings.UserWeight as NSString).doubleValue
        let bikeWieghtValue = (settings.UserBikeWeight as NSString).doubleValue == 0.0 ? 15 : (settings.UserBikeWeight as NSString).doubleValue
        let gradeValue = ComputerRuntimeVariables.Grade // 0
        let speedValue = ComputerRuntimeVariables.Speed
        let distanceValue = leDistance  // This can be calculated from the intervals in which the speed has been calculated.

        let rweightv = riderWeightValue * (Bool(units) ? 0.4536 : 1)
        let bweightv = bikeWieghtValue * (Bool(units) ? 0.4536 : 1)

        let temperaturev = (tempValue - (Bool(units) ? 32 : 0)) * (Bool(units) ? 0.5555 : 1)
        let elevationv = elevValue * (Bool(units) ? 0.3048 : 1)
        let density = (1.293 - 0.00426 * temperaturev) * exp(-elevationv / 7E3) // Used for
        let frontalArea = aeroValues[1] // Used for defining the wind resistance of the human.
        let twt = 9.8 * (rweightv + bweightv)
        let gradev = 0.01 * gradeValue
        let rollingRes = tireValues[0]

        let A2 = 0.5 * frontalArea * density

        let headwindv = headwindValue * (Bool(units) ? 1.609 : 1) / 3.6
        let tres = twt * (gradev + rollingRes)
        let v = speedValue / 3.6 * (Bool(units) ? 1.609 : 1)
        let tv = v + headwindv

        let transv = 0.95

        // These were never used.
        _ = (v * tres + v * tv * tv * A2) / transv
        _ = 0 < v ? 16.6667 * distanceValue / v : 0

        ComputerRuntimeVariables.Power = (v * tres + v * tv * tv * A2) / transv

        // println(powerv)
        // var v = 3.6 * newton(A2, headwindv, tres, transv, powerv)
    }

    func determinHeadwindValue(windSpeed: Double, windDirection: String, movingDirection: Double) {

        switch windDirection {
        case "N":
            windDegree = 0.0
        case "NNE":
            windDegree = 22.5
        case "NE":
            windDegree = 45.0
        case "ENE":
            windDegree = 67.5
        case "E":
            windDegree = 90.0
        case "ESE":
            windDegree = 112.5
        case "SE":
            windDegree = 135
        case "SSE":
            windDegree = 157.5
        case "S":
            windDegree = 180.0
        case "SSW":
            windDegree = 202.5
        case "SW":
            windDegree = 225.0
        case "WSW":
            windDegree = 247.5
        case "W":
            windDegree = 270.0
        case "WNW":
            windDegree = 292.5
        case "NW":
            windDegree = 315
        case "NNW":
            windDegree = 337.5
        default:
            windDegree = 360.0
        }

        // tail wind with negative value and head wind with positive value
        // println("windDegree: \(windDegree)")
        headwindValue = windSpeed * cos(abs(movingDirection - windDegree) * M_PI / 180) * (-1)

    }

    /**
     Location Manager will prompt the user to agree to share their location

     - parameter manager: <#manager description#>
     - parameter status:  <#status description#>
     */
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus")
        switch status {
        case .NotDetermined:
            print(".NotDetermined")
            break

        case .AuthorizedAlways:
            // print(".AuthorizedAlways")
            // Update location
            self.locationManager.startUpdatingLocation()
            // Update heading
            self.locationManager.startUpdatingHeading()
            break
        case .Denied:
            print(".Denied")
            break
        default:
            print("Unhandled authorization status")
            break
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        movingDirection = newHeading.magneticHeading
        print("moving direction: \(movingDirection)")
    }
    /**
     Grade Calculation

     - parameter loc1x:
     - parameter loc1y:
     - parameter loc1z:
     - parameter loc2x:
     - parameter loc2y:
     - parameter loc2z:

     - returns:
     */
    func didReceiveGradeUpdate(loc1x: Double, loc1y: Double, loc1z: Double, loc2x: Double, loc2y: Double, loc2z: Double) -> Double {

        //var grade = 100 * (loc1z - loc2z) / sqrt(pow(loc1x - loc2x, 2) + pow(loc1y - loc2y, 2))
        //println("\(grade) = 100 * (\(loc1z) - \(loc2z)) / sqrt(pow(\(loc1x) - \(loc2x), 2) + pow(\(loc1y) - \(loc2y), 2))")


        let hcInMeters = distanceOfGeoId(loc1x, lon1: loc1y, lat2: loc2x, lon2: loc2y)


        let hc = (hcInMeters * 0.000621371) // the horizontal difference in miles
        let vc = ((loc1z - loc2z) * 0.3048)// the vertical difference in ft

        let gc = (vc / (hc * 5280) * 100)
        //         println("\(gc) = (\(vc)/ (\(hc) * 5280) * 100)")

        // return grade
        return gc
    }


    /**
     Determin Speed

     - parameter ts1:
     - parameter ts2:
     - parameter lat1:
     - parameter lon1:
     - parameter lat2:
     - parameter lon2:
     */
    func determinSpeed(ts1: Double, ts2: Double, lat1: Double, lon1: Double, lat2: Double, lon2: Double) {
        let dist = distanceOfGeoId(lat1, lon1: lon1, lat2: lat2, lon2: lon2);
        let time_s = (ts1 - ts2) / 1000.0;

        let speed_mps = Double(dist) / Double(time_s);
        let speedKph = (speed_mps * 3600.0) / 1000.0;
        let speedMph = speedKph / 1.609344

        // Set the speed

        ComputerRuntimeVariables.Speed = 0.0
        if (ComputerRuntimeVariables.MetricMode == 1) {
            if (speedKph.isNaN) {
                ComputerRuntimeVariables.Speed = 0.0
                self.delegate?.didRecieveSpeedUpdate(0.0)
            } else if (speedKph > 0) {
                ComputerRuntimeVariables.Speed = speedKph
                self.delegate?.didRecieveSpeedUpdate(Double(speedKph))
            } else {
                self.delegate?.didRecieveSpeedUpdate(0.0)
            }
        } else {
            if (speedMph.isNaN) {
                ComputerRuntimeVariables.Speed = 0.0
                self.delegate?.didRecieveSpeedUpdate(0.0)
            } else if (speedKph > 0) {
                ComputerRuntimeVariables.Speed = speedMph
                self.delegate?.didRecieveSpeedUpdate(Double(speedMph))
            } else {
                self.delegate?.didRecieveSpeedUpdate(0.0)
            }
        }
    }

    /**
     Distance between two locations

     - parameter lat1: <#lat1 description#>
     - parameter lon1: <#lon1 description#>
     - parameter lat2: <#lat2 description#>
     - parameter lon2: <#lon2 description#>

     - returns: <#return value description#>
     */
    func distanceOfGeoId(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {

        // Convert degrees to radians
        let lat1r = lat1 * M_PI / 180.0;
        let lon1r = lon1 * M_PI / 180.0;

        let lat2r = lat2 * M_PI / 180.0;
        let lon2r = lon2 * M_PI / 180.0;

        // radius of earth in metres
        let r: Double = 6378100;

        // P
        let rho1 = r * cos(lat1r);
        let z1 = r * sin(lat1r);
        let x1 = rho1 * cos(lon1r);
        let y1 = rho1 * sin(lon1r);

        // Q
        let rho2 = r * cos(lat2r);
        let z2 = r * sin(lat2r);
        let x2 = rho2 * cos(lon2r);
        let y2 = rho2 * sin(lon2r);

        // Dot product
        let dot = (x1 * x2 + y1 * y2 + z1 * z2);
        let cos_theta = dot / (r * r);

        let theta = acos(cos_theta);

        // Distance in Metres
        return Double(r) * Double(theta);
    }


    /**
     Newton Calculation

     - parameter a: <#a description#>
     - parameter b: <#b description#>
     - parameter d: <#d description#>
     - parameter f: <#f description#>
     - parameter h: <#h description#>

     - returns: <#return value description#>
     */
    func newton(a: Double, b: Double, d: Double, f: Double, h: Double) -> Double {
        var g = 20.00;
        var i = 0, e = 0.0
        for (i = 1; 10 > i; i++) {
            var e = g + b
            e = g - (g * (a * e * e + d) - f * h) / (a * (3 * g + b) * e + d)
            if (0.05 > abs(e - g)) {
                return e;
            }
            g = e
        }
        return 0
    }

    /**
     Create Ride Name

     - returns: <#return value description#>
     */

    func createNewRideName() -> String {
        var tmpName = "UnNamed"
        let existingName = WatchCoreDataProxy.sharedInstance.fetchAnyUnNamed()
        if(existingName.count > 0){
            var i = 1
            var b = false
            for leName in existingName  {
                if(b == true){
                    break
                }
                if( leName != "UnNamed \(i)" ){
                    tmpName = "UnNamed \(i)"
                    b = true
                }
                i++
            }
        }
        return tmpName
    }

    /**
     Save the current ride data.

     - parameter lat:      Numerical Lat
     - parameter lon:      Numerical Lon
     - parameter altitude: Numerical Altitude
     */
    func storeLocation(lat: Double, lon: Double, altitude: Double) {

        // println("Location Controller Button State [\(ComputerRuntimeVariables.ButtonMode)]")
        if( ComputerRuntimeVariables.ButtonMode == 1 && ComputerRuntimeVariables.elapsedTime != nil){

            var ti = NSInteger(ComputerRuntimeVariables.elapsedTime)
            var ms = Int((ComputerRuntimeVariables.elapsedTime % 1) * 1000)
            var rideLengthInSeconds: Double = Double(ti) % 60.0
            let mdate = NSDate().timeIntervalSince1970


            // init
            if( ComputerRuntimeVariables.OrigDate == nil){

                // Store instance of Time
                ComputerRuntimeVariables.OrigDate = NSDate()

                // Save Ride Data
                WatchCoreDataProxy.sharedInstance.setRideData(
                    "",
                    time: rideLengthInSeconds, // Elapsed Time
                    distance: 0.0, // distance:Double,
                    calories: 0.0, // calories:Double,
                    date: ComputerRuntimeVariables.OrigDate, // <-- this is our "primary key"
                    metric: 0,
                    speedAverage: 0.0, // speedAverage:Double,
                    speedPeak: 0.0, // speedPeak:Double,
                    cadenceAverage: 0.0, // cadenceAverage:Double,
                    cadencePeak: 0.0, // cadencePeak:Double,
                    heartRateAverage: 0.0, // heartRateAverage:Double,
                    heartRatePeak: 0.0, // heartRatePeak:Double,
                    wattAverage: 0.0, // wattAverage:Double,
                    wattPeak: 0.0

                )

            }

            // Store Lat / Long / Power / Speed, etc
            WatchCoreDataProxy.sharedInstance.addLocationData(
                ComputerRuntimeVariables.OrigDate,
                latitude: lat,
                longitude: lon,
                elevation: altitude,
                timestamp: mdate,
                speed: ComputerRuntimeVariables.Speed,
                power: ComputerRuntimeVariables.Power,
                heartrate: ComputerRuntimeVariables.Heartrate,
                cadence: ComputerRuntimeVariables.Cadence
            )
        }
    }
    
}

