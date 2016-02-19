//
//  GettingStarted.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/1/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//


import Foundation
import UIKit


class GettingStartedController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate  {
    
    var loginFbButton : FBSDKLoginButton = FBSDKLoginButton()
    var auth = APIController()


    /**
    Disable Rotation on this screen.

    - returns: <#return value description#>
    */
    override func shouldAutorotate() -> Bool {
        return false
    }

    /**
    Disable Rotation on this screen.

    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Load up our Login
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
        } else {
            self.view.addSubview(loginFbButton)
            loginFbButton.center = self.view.center
            loginFbButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginFbButton.delegate = self
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    // Login Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                
                let token = result.token.tokenString
                // Set token.
                TegKeychain.set("Auth_Facebook_Token", value: token)
                
                // Do work
                returnUserData(token)
                ComputerRuntimeVariables.LoginCount++
                dispatch_async(dispatch_get_main_queue(), {
                    // Pop back...
                    // self.dismissViewControllerAnimated(true, completion: {});
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("LeMondMain") 
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
        }
    }
    
    //
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    
    func returnUserData(token : String)
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let userId : NSString = result.valueForKey("id") as! NSString
                let firstName : NSString = result.valueForKey("first_name") as! NSString
                let lastName : NSString = result.valueForKey("last_name") as! NSString
                let userEmail : NSString = result.valueForKey("email") as! NSString
                
                let id = Int((userId as String))
                
                // Get our login auth
                self.auth.loginFacebook(id!,
                    auth: token ,
                    firstName: firstName as String,
                    lastName: lastName as String,
                    email:userEmail as String)
                
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
}