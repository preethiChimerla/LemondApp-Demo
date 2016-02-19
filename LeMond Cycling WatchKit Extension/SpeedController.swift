//
//  SpeedController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/27/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy


class SpeedController: WKInterfaceController {
    
    @IBOutlet weak var bgClockFace: WKInterfaceGroup!
    @IBOutlet weak var mainColor: WKInterfaceGroup!

    @IBOutlet weak var speedValue: WKInterfaceLabel!
    
    var cs = WatchUIColors()
    var usageMode = 1
    
    
    // interval timer
    var intervalTimer = NSTimer()
    
    /**
    Update Speed
    */
    func updateSpeed() {
        var speed:String = "0.0"
        // Something after a delay
        speed = (WatchCoreDataProxy.sharedInstance.receiveSpeed() as? String)!
        print("Reading Speed \(speed)")
        speedValue.setText(speed)
    }

    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
    }
    
    /**
    This method is called when watch view controller is about to be visible to user
    */
    override func willActivate() {
        super.willActivate()
        print("Displaying Speed")
        
//        bgClockFace.setBackgroundImageNamed("BasicDial.png")
//        
//        mainColor.setBackgroundImageNamed("YellowDial")
//        mainColor.startAnimatingWithImagesInRange( NSMakeRange(0, 50), duration: 0.6, repeatCount: 1)
        
        
        let interval:NSTimeInterval = 1.0
        if(!intervalTimer.valid){
            intervalTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
        }
        
        updateSpeed()
        
    }
    
    /**
    This method is called when watch view controller is no longer visible
    */
    override func didDeactivate() {
        super.didDeactivate()
        intervalTimer.invalidate()
    }
    
}