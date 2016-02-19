//
////  WatchCoreDataProxy.swift
////  LeMond Cycling
////
////  Created by Nicolas Wegener on 6/1/15.f
////  Copyright (c) 2015 LeMond. All rights reserved.
////

import Foundation
import UIKit
import CoreData


public class WatchCoreDataProxy: NSObject {
    public var sharedAppGroup: NSString = ""
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count - 1] 
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let proxyBundle = NSBundle(identifier: "cc.lemond.client.WatchCoreDataProxy")
        let modelURL = proxyBundle?.URLForResource("WatchModel", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL!)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        let containerPath = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(self.sharedAppGroup as String)?.path
        let sqlitePath = NSString(format: "%@/%@", containerPath!, "WatchModel")
        let url = NSURL(fileURLWithPath: sqlitePath as String);
        
        let model = self.managedObjectModel;
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: model)
        var error: NSError? = nil
        
        var failureReason = "There was an error creating or loading the application's saved data."
        
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true]
        
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: mOptions)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    /**
    Save data
    */
    func saveContext() {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
    
    // Second half
    
    
    /// SharedInstance?
    public class var sharedInstance: WatchCoreDataProxy {
        /**
        *  Static
        */
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: WatchCoreDataProxy? = nil
        }
        
        /**
        *  Singleton Dispatch
        */
        dispatch_once(&Static.onceToken) {
            Static.instance = WatchCoreDataProxy()
        }
        
        return Static.instance!
    }
    
    
    /**
    Send Power to watch
    
    - parameter stringData: <#stringData description#>
    */
    public func sendPowerToWatch(stringData: NSString) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        
        
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        if (results?.count == 0) {
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondTransport", inManagedObjectContext: context!) 
            newManagedObject.setValue(stringData, forKey: "currentPower")
        } else {
            let existingObject: NSManagedObject = results![0] as! NSManagedObject
            existingObject.setValue(stringData, forKey: "currentPower")
        }
        
//        if !(context?.save() != nil) {
//            print("Unresolved error \(error), \(error?.userInfo)")
//            abort()
//        }
    }
    
    /**
    Send the Cadence to the Watch
    
    - parameter stringData: <#stringData description#>
    */
    public func sendCadenceToWatch(stringData: NSString) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        
        
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        if (results?.count == 0) {
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondTransport", inManagedObjectContext: context!) 
            
            newManagedObject.setValue(stringData, forKey: "currentCadence")
            
        } else {
            let existingObject: NSManagedObject = results![0] as! NSManagedObject
            existingObject.setValue(stringData, forKey: "currentCadence")
        }
        
//        if !(context?.save() != nil) {
//            print("Unresolved error \(error), \(error?.userInfo)")
//            abort()
//        }
    }
    
    /**
    Send the Speed to the Watch
    
    - parameter stringData: <#stringData description#>
    */
    public func sendSpeedToWatch(stringData: NSString) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        if (results?.count == 0) {
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondTransport", inManagedObjectContext: context!) 
            newManagedObject.setValue(stringData, forKey: "currentSpeed")
        } else {
            let existingObject: NSManagedObject = results![0] as! NSManagedObject
            existingObject.setValue(stringData, forKey: "currentSpeed")
        }
        
//        if !(context?.save() != nil) {
//            print("Unresolved error \(error), \(error?.userInfo)")
//            abort()
//        }
    }
    
    /**
    Send HeartRate to the Watch
    
    - parameter stringData: <#stringData description#>
    */
    public func sendHeartrateToWatch(stringData: NSString) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        
        
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        if (results?.count == 0) {
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondTransport", inManagedObjectContext: context!) 
            
            newManagedObject.setValue(stringData, forKey: "currentHeartrate")
        } else {
            let existingObject: NSManagedObject = results![0] as! NSManagedObject
            existingObject.setValue(stringData, forKey: "currentHeartrate")
        }
        
//        if !(context?.save() != nil) {
//            print("Unresolved error \(error), \(error?.userInfo)")
//            abort()
//        }
    }
    
    /**
    Send Calories to the Watch
    
    - parameter stringData: <#stringData description#>
    */
    public func sendCaloriesToWatch(stringData: NSString) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        
        
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        if (results?.count == 0) {
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondTransport", inManagedObjectContext: context!) 
            newManagedObject.setValue(stringData, forKey: "cumulativeCalories")
        } else {
            let existingObject: NSManagedObject = results![0] as! NSManagedObject
            existingObject.setValue(stringData, forKey: "cumulativeCalories")
        }
        
//        if !(context?.save() != nil) {
//            print("Unresolved error \(error), \(error?.userInfo)")
//            abort()
//        }
    }
    
    
    
    /**
    Retrieve the computer Watt Power from the phone
    
    - returns: Watt Power
    */
    public func receivePower() -> NSString? {
        
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var stringData: NSString?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as! NSManagedObject
            stringData = managedObject.valueForKey("currentPower") as? NSString
        }
        
        return stringData
    }
    
    /**
    Retrieve the current computer Speed
    
    - returns: <#return value description#>
    */
    public func receiveSpeed() -> NSString? {
        
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var stringData: NSString?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as! NSManagedObject
            stringData = managedObject.valueForKey("currentSpeed") as? NSString
        }
        
        return stringData
    }
    
    /**
    Retrieve the current Cadence
    
    - returns: <#return value description#>
    */
    public func receiveCadence() -> NSString? {
        
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var stringData: NSString?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as! NSManagedObject
            stringData = managedObject.valueForKey("currentCadence") as? NSString
        }
        
        return stringData
    }
    
    
    /**
    Retrieve the current Calorie
    
    - returns: <#return value description#>
    */
    public func receiveCalories() -> NSString? {
        
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("LeMondTransport", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var stringData: NSString?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as! NSManagedObject
            stringData = managedObject.valueForKey("cumulativeCalories") as? NSString
        }
        
        return stringData
    }
    
    
    
    // ///////////
    // Store Ride Data
    // ///////////
    
    
    /**
    Fetch any unamed items
    
    - returns: <#return value description#>
    */
    public func fetchAnyUnNamed() -> [String] {
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondRide", inManagedObjectContext: self.managedObjectContext!)
        let request = NSFetchRequest()
        // Create a new predicate that filters out any object that
        // doesn't have a title of "Best Language" exactly.
        let predicate = NSPredicate(format: "name BEGINSWITH %@", "UnNamed")
        // Set the predicate on the fetch request
        request.predicate = predicate
        
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var names = [String]()
        
        if (results?.count > 0) {
            for (var i = 0; i < results?.count; i++) {
                let existingObject: NSManagedObject = results![i] as! NSManagedObject
                let currentRecName = existingObject.valueForKey("name") as? String
                names.append(currentRecName!)
            }
        }
        return names
    }
    
    /**
    Fetch our Saved Rides
    
    - returns: <#return value description#>
    */
    public func fetchSavedRides() -> Array<Array<AnyObject>> {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondRide", inManagedObjectContext: self.managedObjectContext!)
        let request = NSFetchRequest()
        
        // Perhaps add a Saved and Deleted Flag
        
        // Create a new predicate that filters out any object that
        // doesn't have a title of "Best Language" exactly.
        let predicate = NSPredicate(format: "saved == %@", true)
        // Set the predicate on the fetch request
        request.predicate = predicate
        // item[0][0]
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        
        var rides = Array<Array<AnyObject>>()
        
        if (results?.count > 0) {
            for (var i = 0; i < results?.count; i++) {
                let existingObject: NSManagedObject = results![i] as! NSManagedObject
                
                var dataArray = Array<AnyObject>()
                
                var calories: NSNumber = 0.0
                
                let time = existingObject.valueForKey("time") as! NSNumber
                let date = existingObject.valueForKey("date") as! NSDate
                let distance = (existingObject.valueForKey("time") as! NSNumber).doubleValue * (existingObject.valueForKey("speedAverage") as! NSNumber).doubleValue / 3600
                
                if existingObject.valueForKey("calories") != nil {
                    calories = existingObject.valueForKey("calories") as! NSNumber
                }
                
                dataArray.append(existingObject.valueForKey("name") as! String)
                dataArray.append(time)
                dataArray.append(date)
                dataArray.append(distance)
                dataArray.append(calories)
                rides.append(dataArray)
            }
        }
        return rides
    }
    
    
    /**
    Fetch our Saved Ride
    
    - returns: <#return value description#>
    */
    public func fetchSavedRideData(date: NSDate) -> LeMondRide! {
        
        // Pull the object parent
        let leRide = findRideAsLeMondRide(date)
        
        if(leRide.0 == true){
            return leRide.1!
        }
        return nil
    }
    
    public func fetchSavedRideDataDetails() -> LeMondRideData! {
        
        return nil
    }
    
    /**
    Description
    
    - parameter name:             <#name description#>
    - parameter time:             <#time description#>
    - parameter distance:         <#distance description#>
    - parameter calories:         <#calories description#>
    - parameter date:             <#date description#>
    - parameter metric:           <#metric description#>
    - parameter speedAverage:     <#speedAverage description#>
    - parameter speedPeak:        <#speedPeak description#>
    - parameter cadenceAverage:   <#cadenceAverage description#>
    - parameter cadencePeak:      <#cadencePeak description#>
    - parameter heartRateAverage: <#heartRateAverage description#>
    - parameter heartRatePeak:    <#heartRatePeak description#>
    - parameter wattAverage:      <#wattAverage description#>
    - parameter wattPeak:         <#wattPeak description#>
    */
    public func setRideData(
        name: NSString,
        time: Double,
        distance: Double,
        calories: Double,
        date: NSDate,
        metric: Int,
        speedAverage: Double,
        speedPeak: Double,
        cadenceAverage: Double,
        cadencePeak: Double,
        heartRateAverage: Double,
        heartRatePeak: Double,
        wattAverage: Double,
        wattPeak: Double
        ) {
            
            let context = self.managedObjectContext
            let entity = NSEntityDescription.entityForName("LeMondRide", inManagedObjectContext: self.managedObjectContext!)
            let request = NSFetchRequest()
            request.entity = entity
            var error: NSError? = nil
            let results: [AnyObject]?
            do {
                results = try self.managedObjectContext?.executeFetchRequest(request)
            } catch let error1 as NSError {
                error = error1
                results = nil
            }
            var found = false
            
            if (results?.count > 0) {
                
                for (var i = 0; i < results?.count; i++) {
                    let existingObject: NSManagedObject = results![i] as! NSManagedObject
                    if (existingObject.valueForKey("date") as? NSDate == date) {
                        
                        // Now update
                        existingObject.setValue(time, forKey: "time")
                        existingObject.setValue(date, forKey: "date")
                        // Distance and Calories
                        existingObject.setValue(distance, forKey: "distance")
                        existingObject.setValue(calories, forKey: "calories")
                        // Cadence
                        existingObject.setValue(cadenceAverage, forKey: "cadenceAverage")
                        existingObject.setValue(cadencePeak, forKey: "cadencePeak")
                        // Heartrate
                        existingObject.setValue(heartRateAverage, forKey: "heartRateAverage")
                        existingObject.setValue(heartRatePeak, forKey: "heartRatePeak")
                        // Watt
                        existingObject.setValue(wattAverage, forKey: "wattAverage")
                        existingObject.setValue(wattPeak, forKey: "wattPeak")
                        // Speed
                        existingObject.setValue(speedAverage, forKey: "speedAverage")
                        existingObject.setValue(speedPeak, forKey: "speedPeak")
                        
                        found = true
                    }
                }
            }
            
            if (results?.count == 0 || found == false) {
                let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("LeMondRide", inManagedObjectContext: context!) 
                
                newManagedObject.setValue(name, forKey: "name")
                newManagedObject.setValue(time, forKey: "time")
                newManagedObject.setValue(date, forKey: "date")
                // Distance and Calories
                newManagedObject.setValue(distance, forKey: "distance")
                newManagedObject.setValue(calories, forKey: "calories")
                // Cadence
                newManagedObject.setValue(cadenceAverage, forKey: "cadenceAverage")
                newManagedObject.setValue(cadencePeak, forKey: "cadencePeak")
                // Heartrate
                newManagedObject.setValue(heartRateAverage, forKey: "heartRateAverage")
                newManagedObject.setValue(heartRatePeak, forKey: "heartRatePeak")
                // Watt
                newManagedObject.setValue(wattAverage, forKey: "wattAverage")
                newManagedObject.setValue(wattPeak, forKey: "wattPeak")
                // Speed
                newManagedObject.setValue(speedAverage, forKey: "speedAverage")
                newManagedObject.setValue(speedPeak, forKey: "speedPeak")
                
            }
            
//            if !(context?.save() != nil) {
//                print("Unresolved error \(error), \(error?.userInfo)")
//                abort()
//            }
    }
    
    /**
    Depricated - Should soon remove all together.
    NJW: 7-7-2015
    
    - parameter name: <#name description#>
    
    - returns: <#return value description#>
    */
    func findRide(date: NSDate) -> (Bool, NSManagedObject?) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondRide", inManagedObjectContext: self.managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        var found = false
        
        if (results?.count > 0) {
            for (var i = 0; i < results?.count; i++) {
                let existingObject: NSManagedObject = results![i] as! NSManagedObject
                
                let currentRecDate = existingObject.valueForKey("date") as? NSDate
                
                if (existingObject.valueForKey("date") as? NSDate == date) {
                    return (true, existingObject)
                }
            }
        }
        return (false, nil)
    }
    
    
    /**
    <#Description#>
    
    - parameter date: <#date description#>
    
    - returns: <#return value description#>
    */
    func findRideAsLeMondRide(date: NSDate) -> (Bool, LeMondRide?) {
        
        let context = self.managedObjectContext
        let request = NSFetchRequest(entityName: "LeMondRide")
        var error: NSError? = nil
        request.predicate = NSPredicate(format: "date == %@", date)
        let results: NSArray = try! context!.executeFetchRequest(request)
        if results.count > 0 {
            for result in results {
                let ride = result as! LeMondRide
                return (true, ride)
            }
        }
        return (false, nil)
    }
    
    /**
    Depricated - Should soon remove all together.
    NJW: 7-7-2015
    
    - parameter date: <#date description#>
    
    - returns: <#return value description#>
    */
    public func findRideData(date: NSDate) -> (Bool, NSManagedObject?) {
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondRideData", inManagedObjectContext: self.managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        var found = false
        
        if (results?.count > 0) {
            for (var i = 0; i < results?.count; i++) {
                let existingObject: NSManagedObject = results![i] as! NSManagedObject
                // println(existingObject)
                
                let currentRecDate = existingObject.valueForKey("date") as? NSDate
                // println("Weighing  \(currentRecDate) == \(date)")
                //
                if (existingObject.valueForKey("date") as? NSDate == date) {
                    print("found by date \(date)")
                    print("\(existingObject)")
                    return (true, existingObject)
                }
            }
        }
        return (false, nil)
    }
    
    /**
    Save Location Data, based on origin date.
    
    - parameter name:      <#name description#>
    - parameter latitude:  <#latitude description#>
    - parameter longitude: <#longitude description#>
    - parameter elevation: <#elevation description#>
    - parameter timestamp: <#timestamp description#>
    */
    public func addLocationData(date: NSDate, latitude: NSNumber, longitude: NSNumber, elevation: NSNumber, timestamp: NSNumber, speed: NSNumber, power: NSNumber, heartrate: NSNumber, cadence: NSNumber) {
        
        let context = self.managedObjectContext
        let error: NSError? = nil
        
        // Pull the object parent
        let rideRecord = findRideAsLeMondRide(date)
        
        if(rideRecord.0 == true){
            
            let leMondRide : LeMondRide = rideRecord.1!
            
            let leMondRideData = NSEntityDescription.insertNewObjectForEntityForName("LeMondRideData", inManagedObjectContext: context!) as! LeMondRideData
            // println("💃 want to save \(latitude) & \(longitude) ")
            leMondRideData.latitude = latitude
            leMondRideData.longitude = longitude
            leMondRideData.elevation = elevation
            leMondRideData.timestamp = timestamp
            leMondRideData.speed = speed
            leMondRideData.power = power
            leMondRideData.heartrate = heartrate
            leMondRideData.cadence = cadence
            
            // Now store
            leMondRide.addListObject(leMondRideData)
            
//            if !(context?.save() != nil) {
//                print("Unresolved error \(error), \(error?.userInfo)")
//                abort()
//            }
        }else{
            // println("Didn't find any records - skipping storage")
        }
    }
    
    /**
    Save the Ride
    
    - parameter date: <#date description#>
    */
    public func saveRide(date: NSDate) {
        
        let context = self.managedObjectContext
        let error: NSError? = nil
        
        let leRide = findRide(date)
        
        if(leRide.0 == true){
            let existingObject = leRide.1 as NSManagedObject?
            
            existingObject!.setValue(true, forKey: "saved")
            
//            if !(context?.save() != nil) {
//                print("Unresolved error when saving \(error), \(error?.userInfo)")
//                abort()
//            }
        }
    }
    
    /**
    <#Description#>
    
    - parameter date: <#date description#>
    
    - returns: <#return value description#>
    */
    public func fetchLocationData(date: NSDate) -> NSMutableSet {
        let context = self.managedObjectContext
        var error: NSError? = nil
        
        let leRide = findRide(date)
        if(leRide.0 == true){
            let existingObject = leRide.1 as NSManagedObject?
            let bb = existingObject!.valueForKey("rideData") as! NSMutableSet
            return bb
        }
        // Nil
        let cc = NSMutableSet()
        return cc
    }
    
    // delete functionality for stored rides in tableview
    
    /**
    <#Description#>
    
    - parameter date: <#date description#>
    
    - returns: <#return value description#>
    */
    public func deleteRide (date: NSDate) {
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("LeMondRide", inManagedObjectContext: self.managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results: [AnyObject]?
        do {
            results = try self.managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            results = nil
        }
        var found = false
        
        if (results?.count > 0) {
            for (var i = 0; i < results?.count; i++) {
                let existingObject: NSManagedObject = results![i] as! NSManagedObject
                if (existingObject.valueForKey("date") as? NSDate == date) {
                    print("existing object here in appdelegate\(existingObject)")
                    //var mc: NSManagedObjectContext = AppDelegate.existingObject
                    context!.deleteObject( existingObject )
                    print("after hdgsvgywg -- hi mom!")
                }
            }
        }
    }

}
