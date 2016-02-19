//
//  LocalizationController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit


// UITableViewDelegate, UITableViewDataSource, 
class LocalizationController: UITableViewController, UITextFieldDelegate, SettingsLanguageProtocol {
    
    let MetricsData = ["Imeprial", "Metric"]
    let store = StoreUserDefaults()
    
    @IBOutlet weak var Language: UILabel!
    @IBOutlet var Metrics: UISegmentedControl!
    var chosenLanguage = ""
    
    var cc:LanguageController!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenLanguage = store.LanguageName
        let chosenLanguageCode = store.LanguageCode
        let chosenMetric = store.Imperial
        
        Metrics.selectedSegmentIndex = (chosenMetric as NSString).integerValue
        Language.text = chosenLanguage
    }
    
    func upadteLanguage(symbol: String){
        
        chosenLanguage = store.LanguageName
        Language.text = chosenLanguage
    }
    
    @IBAction func Metrics(sender: AnyObject) {
        store.Imperial = "\(Metrics.selectedSegmentIndex)"
        let index = (store.Imperial as NSString).integerValue
        if index == 0 {
            ComputerRuntimeVariables.MetricMode = 0
        } else if index == 1 {
            ComputerRuntimeVariables.MetricMode = 1
        }
        
    }
    
    
    /**
    Override for detecting signout.
    
    - parameter tableView: <#tableView description#>
    - parameter indexPath: <#indexPath description#>
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // println(" table index \(indexPath.section) \(indexPath.row)")
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            self.performSegueWithIdentifier("showLanguageSelector", sender: nil)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLanguageSelector" {
            
            // stage the
            let cntl = segue.destinationViewController as! LanguageController
            cc = cntl
            cc.saveLanguageDelegate = self
            
            super.prepareForSegue( segue, sender: sender)
        }
        
    }
    
}
