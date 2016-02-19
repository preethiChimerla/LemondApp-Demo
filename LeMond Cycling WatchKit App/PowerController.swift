//
//  WatchCircleView.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy

class PowerController: WKInterfaceController {
     
    
    //interval timer
    var intervalTimer = NSTimer()
    
    @IBOutlet weak var bgClockFace: WKInterfaceGroup!
    @IBOutlet weak var mainColorProgress: WKInterfaceGroup!
    @IBOutlet weak var powerValue: WKInterfaceLabel!
    
    
    /**
    <#Description#>
    
    - parameter context: <#context description#>
    */
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
        print("Displaying Power")
    }
    
    
    /**
    This method is called when watch view controller is about to be visible to user
    */
    override func willActivate() {
        super.willActivate()
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
//
//        println("Changing the background to powerDial")
//        // clockFace.setBackgroundImageNamed("BasicDial0@2x.png") // Our watch face
//        // clockFace.setBackgroundColor(UIColor.orangeColor())
//        
//        bgClockFace.setBackgroundImageNamed("BasicDial")
//        
//        mainColorProgress.setBackgroundImageNamed("CyanDial")
//        // mainColorProgress.startAnimatingWithImagesInRange( NSMakeRange(0, 50), duration: 0.6, repeatCount: 1)
//        

        
        let interval:NSTimeInterval = 1.0
        if(!intervalTimer.valid){
            intervalTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "updatePower", userInfo: nil, repeats: true)
        }
        updatePower();
    }
    
    /**
    Update Power
    */
    func updatePower() {
        var power:String = "0.0"
        // Something after a delay
        power = (WatchCoreDataProxy.sharedInstance.receivePower()! as? String)!
        powerValue.setText(power)
        
        
        let cRow = Int( ( (power as NSString).doubleValue / 400 ) * 100 )
        mainColorProgress.setBackgroundImageNamed("CyanDial\(cRow)@2x")
    }
    
    /**
    This method is called when watch view controller is no longer visible
    */
    override func didDeactivate() {
        super.didDeactivate()
        intervalTimer.invalidate()
    }
    
    
}