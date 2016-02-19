//  RideDetailsController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/22/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData
import WatchCoreDataProxy

class RideDetailsController: UIViewController {
    
    var delegate: RideDetailsProtocol?

    var sscs:CGRect!
    var Name = ""
    var OrigDate:NSDate = NSDate()

    var labelLeadingMarginInitialConstant: CGFloat!
    var overlayBackground: ShareWorkoutBackground!


    @IBOutlet var TrialRideDate: UILabel!
    @IBOutlet var trailLocation: UILabel!
    @IBOutlet var totalMiles: UILabel!
    
    @IBOutlet var TotalRideTime: UILabel!
    @IBOutlet var mainView: RideDetails!
    @IBOutlet var uiChart: ElevationChart!
    
    @IBOutlet var AverageSpeed: UILabel!
    @IBOutlet var AveragePower: UILabel!
    @IBOutlet var AverageCadence: UILabel!
    @IBOutlet var AverageHearRate: UILabel!
    
    @IBOutlet var TopSpeed: UILabel!
    @IBOutlet var TopPower: UILabel!
    @IBOutlet var TopCadence: UILabel!
    @IBOutlet var TopHeartRate: UILabel!
    
    // adding elevation chart
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationMenu: UINavigationItem!
    @IBOutlet var TotalCalrisBurned: UILabel!

    
    /**
    <#Description#>
    
    - returns: <#return value description#>
    */
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    /**
    <#Description#>
    
    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    /**
    Loading content for the Ride details
    */
    override func viewDidLoad() {

        super.viewDidLoad()

        mainView.cl = self
        
//        let value = UIInterfaceOrientation.PortraitUpsideDown.rawValue
//        UIDevice.currentDevice().setValue(value, forKey: "orientation")

        // Pass off to the background draw(er)
        
        sscs = view.bounds
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"

        // Start to draw out all the lines by hand
        var nl = UIView()
        nl.backgroundColor = UIColor.whiteColor()

        // Detect where the map starts and stops...

        // Get the top of the miles
        let leYofMeMiles = totalMiles.frame.origin.y

        mainView.OrigDate = OrigDate
        // Pass the map starts and stops off to the Background
        var cbd = ObjectBounds()
        cbd.width = Double(totalMiles.frame.width)
        cbd.height = Double(totalMiles.frame.height)
        cbd.x = Double(totalMiles.frame.origin.x)
        cbd.y = Double(totalMiles.frame.origin.y)
        mainView.totalMilesBounds = cbd
        //mainView.reDraw()

        var lat = 0.0
        var long = 0.0

        // Pull database connection
        // Pull Data from DB
        var rideData:LeMondRide = WatchCoreDataProxy.sharedInstance.fetchSavedRideData(OrigDate)
        let hData = rideData.valueForKey("rideData") as! NSSet

        // Set the Date, et al
        let leDate = rideData.valueForKey("date") as! NSDate


        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a" // superset of OP's format
        let str = dateFormatter.stringFromDate(leDate)
        TrialRideDate.text = str
        trailLocation.text = "  "

        
        let time = rideData.valueForKey("time") as! NSNumber
        let avgS = rideData.valueForKey("speedAverage") as! NSNumber
        let distance = avgS.doubleValue * time.doubleValue / 3600
        let leTime = secondsToHoursMinutesSeconds(time.integerValue)
        
        
        // println("me travelled this distance \(distance)")
        if ComputerRuntimeVariables.MetricMode == 0 {
            totalMiles.text = String(format: "%.2f", distance)
        } else if ComputerRuntimeVariables.MetricMode == 1 {
            totalMiles.text = String(format: "%.2f", distance * 1.609)
        }
        
        
        // println("total miles i won  \(totalMiles.text)")
        TotalRideTime.text = String(format:"%02d:%02d:%02d",leTime.0,leTime.1,leTime.2)
        
        //add back button
        let backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        backBtn.tintColor = UIColor.whiteColor()
        navigationMenu.leftBarButtonItem = backBtn
        
        //add more button with popup
        let morebutton = UIBarButtonItem(title: "More", style: UIBarButtonItemStyle.Plain, target: self, action:  "callShowMoreMenuDelegate:")
        morebutton.tintColor = UIColor.whiteColor()
        navigationMenu.rightBarButtonItem = morebutton


    }

    /**
    Will Appear

    - parameter animated: <#animated description#>
    */
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarHidden = true
    }



    /**
    Go back

    - parameter sender: <#sender description#>
    */
    func backButton(sender: UIButton!) {
        // self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarHidden = false
    }

    /**
    Show more Menu

    - parameter sender: <#sender description#>
    */
    func callShowMoreMenuDelegate(sender: UIButton!){
        delegate?.showMoreMenu(sscs)
    }
    
    /**
    Seconds to Hours / Min ... Seconds

    - parameter seconds: <#seconds description#>

    - returns: <#return value description#>
    */
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
