//
//  LoginController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 4/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController, UITextFieldDelegate, APIControllerProtocol{
    
    var cs = UIColors()
    var auth = APIController()
    var originalHeight = 0;
    var ud = StoreUserDefaults()
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var authNotification: UILabel!

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
    
    /**
    did load init
    
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cs.setStandard()
        authNotification.textColor = cs.barHeartrate
        authNotification.text = ""
        // Do any additional setup after loading the view, typically from a nib.
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        
        // Store our Delegate
        auth.delegate = self
        
        txtUsername.text = ud.Username
        txtPassword.text = ud.Password
    
        // Swipe Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    /**
    Dismiss View or notify user
    
    - parameter results: <#results description#>
    */
    func didRecieveLoginResult(results: Int) {
        
        if (results == 1) {
            dispatch_async(dispatch_get_main_queue(), {
                // Pop back...
                // self.dismissViewControllerAnimated(true, completion: {});
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("LeMondMain") 
                self.presentViewController(vc, animated: true, completion: nil)
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                // Show error Message
                self.authNotification.text = "Incorrect Username or Password"
            })
        }
    }
    
    func didRecieveRegisterResult(results: Int, message: String) {
        
    }
    
    
    /**
    Go Back
    
    - parameter sender: <#sender description#>
    */
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
                self.dismissViewControllerAnimated(true, completion: nil)
                // self.performSegueWithIdentifier("backToGettingStarted", sender: self);
                
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped down")
            default:
                break
            }
        }
    }
    
    /**
    Go Back
    */
    func goBackToGettingStarted() -> Void {
        print("Got here for tapping")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    Keyboard was shown
    */
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    /**
    keyboard will hide.
    */
    func deregisterFromKeyboardNotifications() -> Void {
        print("Deregistering!")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
    Move contraint on keyboard show.
    
    - parameter notification: <#notification description#>
    */
    func keyboardWasShown(notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        
        self.bottomConstraint.constant = keyboardFrame.size.height + 10
        // Animate Contraints
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            let orig = self.view.center
            // self.loginFbButton.center = CGPoint(x: orig.x, y: abs(keyboardFrame.size.height - orig.y))
        })
    }
    
    
    /**
    
    - parameter sender: <#sender description#>
    */
    func keyboardWillHide(sender: NSNotification) {
        
        print("Hiding Keyboar")
        UIView.animateWithDuration(0.1, animations: {
            () -> Void in
            self.bottomConstraint.constant = 10
        })
    }
    
    // On touching the background... Hide keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Login
    @IBAction func signInPressed(sender: AnyObject) {
        
        let un = txtUsername.text
        let pw = txtPassword.text
        
        
        // Validate email address ... ensure it's an email address
        if( isValidEmail(un!) == false){
            self.authNotification.text = "Email address is not valid"
            self.shakeAnimation(txtUsername)
            return
        }
        
        // Ensure the passport
        if ( pw!.length() < 3) {
            self.authNotification.text = "Password should be at least 3 characters"
            self.shakeAnimation(txtPassword)
            return
        }
        
        auth.setUsername(un!)
        auth.setPassword(pw!)
        
        // Show username and Password.
        print("Attempting to login")
        auth.loginStandard()
    }
    
    func shakeAnimation(sender: AnyObject) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(sender.center.x - 5, sender.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(sender.center.x + 5, sender.center.y))
        sender.layer.addAnimation(animation, forKey: "position")
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    @IBAction func backButton(sender: AnyObject) {
    }
    
    @IBAction func forgottenPasswordPressed(sender: AnyObject) {
    }
    
   
}