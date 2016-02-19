//
//  CaloriesController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/27/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy


class CaloriesController: WKInterfaceController {
    
    @IBOutlet weak var calorieValue: WKInterfaceLabel!
    
    
    /**
    Update Speed
    */
    func updateCalories() {
        var cal:String = "0.0"
        // Something after a delay
        cal = (WatchCoreDataProxy.sharedInstance.receiveCalories() as? String)!
        print("Reading Calories \(cal)")
        calorieValue.setText(cal)
    }

    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"

        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateCalories()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}