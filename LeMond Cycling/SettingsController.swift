//
//  SettingsController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UITableViewController {

    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func signOutPressed(sender: AnyObject) {
        TegKeychain.delete("Auth_Token")
        TegKeychain.delete("Auth_Token_Expiry")

        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginMain") 
        self.presentViewController(vc, animated: true, completion: nil)
    }


    /**
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "closeSettings") //Use a selector
        navigationItem.leftBarButtonItem = refreshButton


    }

    /**
    Close Settings
    
    - parameter sender: <#sender description#>
    */
    func closeSettings() {

//        self.navigationController?.popViewControllerAnimated(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    func authStrava (){

        // OAuth2.0
        let oauthswift = OAuth2Swift(
            consumerKey:    LeMondConfig.StravaSecret,
            consumerSecret: LeMondConfig.StravaAccessToken,
            authorizeUrl:   "https://www.strava.com/oauth/authorize",
            responseType:   "token"
        )
        oauthswift.authorizeWithCallbackURL(

            // https://lemond.cc/m/auth/strava
            NSURL( string: "http://dev.lemond.cc/m/auth/strava")!,
            scope: "view_private,write",
            state: "",
            success: {
                credential, response, parameters in print(credential.oauth_token)
            },
            failure: {
                (error:NSError!) -> Void in
                print(error.localizedDescription)
            }
        )
    }


    /**
    Override for detecting signout.
    
    - parameter tableView: <#tableView description#>
    - parameter indexPath: <#indexPath description#>
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // println(" table index \(indexPath.section) \(indexPath.row)")
        if (indexPath.section == 1 && indexPath.row == 3) {
            // Sign Out
            TegKeychain.delete("Auth_Token")
            TegKeychain.delete("Auth_Token_Expiry")
            TegKeychain.delete("Auth_Facebook_Token")

            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginMain") 
            self.presentViewController(vc, animated: true, completion: nil)
        }
        if(indexPath.section == 1 && indexPath.row == 2){
            authStrava ()
        }
    }
    
}