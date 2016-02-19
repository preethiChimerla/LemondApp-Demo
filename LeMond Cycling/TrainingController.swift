

//
//  TrainingController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import WatchCoreDataProxy

struct SavedRides {
    var name: String!
    var desc: String!
    var date: NSDate!
    var time: NSTimeInterval!
    var rawDate: NSDate!
}

class TrainingController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SaveWorkoutProtocol, UIScrollViewDelegate{

    /**
    *  <#Description#>
    */
    @IBOutlet weak var historyScrollview: UIScrollView!
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var TRAINING: UIButton!
    var items:[SavedRides] = []
    var scrollView: UIScrollView!
    
    let basicCellIdentifier = "HistoryCell"
    
    var cc : ComputerController!
    
    @IBOutlet var leView: UIView!

    var color = UIColors()

    
    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func intervalTest(sender: AnyObject) {
    }
    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func recoveryTest(sender: AnyObject) {
    }
    
    func setWorkoutProtocol(c: ComputerController){
        cc = c
        cc.saveWorkoutDelegate = self
    }

    /**
    <#Description#>
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
        
        let value = UIInterfaceOrientation.PortraitUpsideDown.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")

        // Adjust background colorst
        color.setStandard()
        leView.backgroundColor = color.background
        historyScrollview.backgroundColor = color.background
        tableView.backgroundColor = color.background

        // Configure
        configureTableView()
        refreshData()
        tableView.tableFooterView = UIView(frame: CGRectZero)

    }
    
    /**
    <#Description#>
    */
    func refreshData() {
        // Pull Data from DB
        
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"
        items = []
        var rideData = WatchCoreDataProxy.sharedInstance.fetchSavedRides()

        for b in rideData{
            // Convert the string to date.
            var  dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            var sf: String = ""
            var sd: String = ""
            
            let mi = ("\(b[3])" as NSString).doubleValue
            var tim = ("\(b[1])" as NSString).doubleValue

            var cc = SavedRides()
            cc.name = b[0] as! String
            
            var Tym = "Seconds"
            
            if ( tim > 60 ){
                tim = tim / 60
                Tym = "Minutes"
                
                
            } else if (tim > 360){
                tim = tim / 3600
                 Tym = "Hours"
                
            } else {
                 
            }
            
            sd = NSString(format:"%.2f", tim) as String
            
            if ComputerRuntimeVariables.MetricMode == 0 {
                sf = NSString(format:"%.2f", mi) as String
                
                // Pushes it down to it's value
                cc.desc = " \(sf) Miles | \(sd) \(Tym)"
            } else {
                sf = NSString(format:"%.2f", mi * 1.609) as String
                
                cc.desc = "\(sf) KM | \(sd) Seconds"
            }
            cc.date = b[2] as! NSDate
            cc.rawDate = b[2] as! NSDate
            items.insert(cc, atIndex:0)
        }

    }
    
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isLandscapeOrientation() {
            return 120.0
        } else {
            return 150.0
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
        
    }
    
    // Start delete func(s)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            // handle delete (by removing the data from your array and updating the tableview)
            
            self.tableView.reloadData()
            let item = items[indexPath.row] as SavedRides
            let iDate = item.date
            
            items.removeAtIndex(indexPath.row)
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            print("date in delete table row \(iDate)")
            var rideData = WatchCoreDataProxy.sharedInstance.fetchSavedRides()
            
            WatchCoreDataProxy.sharedInstance.deleteRide(iDate)
        }
    }
    // ENDOF Start delete func(s)
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> HistoryCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! HistoryCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(cell:HistoryCell, indexPath:NSIndexPath) {
        
        let item = items[indexPath.row] as SavedRides
        let iDate = item.date
        
//        println("date in training controller \(iDate)")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.dateFormat = "MMMM dd, YYYY 'at' hh:mm:ss a"
        let ff = dateFormatter.stringFromDate(iDate)
        
        cell.titleLabel.text = ff ?? "[No Title]"
        cell.selectionStyle = .None
    }
    
    func setSubtitleForCell(cell:HistoryCell, indexPath:NSIndexPath) {
        let item = items[indexPath.row] as SavedRides
        let subtitle: NSString? = item.desc
        
        if let subtitle = subtitle {
            // Some subtitles are really long, so only display the first 200 characters
            if subtitle.length > 200 {
                cell.subtitleLabel.text = "\(subtitle.substringToIndex(200))..."
            } else {
                cell.subtitleLabel.text = subtitle as String
            }
        } else {
            cell.subtitleLabel.text = ""
        }
    }

    @IBAction func showTrainingBtn(sender: AnyObject) {

        performSegueWithIdentifier("showTraining", sender: nil)
        return

        if(ComputerRuntimeVariables.TrainingMode == false){
            performSegueWithIdentifier("showTraining", sender: nil)
        }else{
            performSegueWithIdentifier("ShowTrainingHome", sender: nil)
        }
    }

    /**
    Move the view to the RideDetails

    - parameter segue:  <#segue description#>
    - parameter sender: <#sender description#>
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // set the index
        
        if( segue.identifier != "showTraining" && segue.identifier != "ShowTrainingHome"){
            let indexPath = tableView.indexPathForSelectedRow
            // allocate the date
            let leDate = items[indexPath!.row].date
            // stage the
            let detailViewController = segue.destinationViewController as! RideDetailsController
            detailViewController.OrigDate = leDate!
        }
        super.prepareForSegue( segue, sender: sender)
    }

    /**
    <#Description#>

    - parameter symbol: <#symbol description#>
    */
    func workoutHasBeenSaved(symbol: Int) {
        refreshData()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
}