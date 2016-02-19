//
//  HeartRateController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/27/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy


class HeartRateController: WKInterfaceController {
    
    @IBOutlet weak var heartrateValue: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}