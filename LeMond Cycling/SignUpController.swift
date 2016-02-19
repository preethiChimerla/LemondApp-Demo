//
//  SignUpController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/1/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class SignUpController: UIViewController, UITextFieldDelegate, APIControllerProtocol {
    
    var auth = APIController()
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var SignupBackButton: UIBarButtonItem!
    @IBOutlet var Submit: UIButton!
    
    @IBOutlet weak var firstNameTxt: TextField!
    @IBOutlet weak var lastNameTxt: TextField!
    @IBOutlet weak var emailAddressTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var authNotification: UILabel!
    @IBOutlet weak var confirmPasswordTxt: TextField!

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
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authNotification.textColor = UIColor.redColor()
        authNotification.text = ""
        // Keyboard appears
        emailAddressTxt.delegate = self
        passwordTxt.delegate = self
        
        // Store our Delegate
        auth.delegate = self
        
        // Swipe Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
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
                self.authNotification.text = "Incorrect Username"
            })
        }
    }
    
    
    func didRecieveRegisterResult(results: Int, message: String) {
        
        if (results == 1) {
            
            
            // simulate the login via the login controller ... or its calls...
            let un = emailAddressTxt.text
            let pw = passwordTxt.text
            
            auth.setUsername(un!)
            auth.setPassword(pw!)
            auth.loginStandard()
            
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                // Show error Message
                //self.authNotification.text = message
                if message.lowercaseString.rangeOfString("username") != nil {
                    self.authNotification.text = "Username already exist"
                    self.shakeAnimation(self.emailAddressTxt)
                }
                
            })
        }
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
    
    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
    Sign UP
    
    - parameter sender: <#sender description#>
    */
    @IBAction func signUpButton(sender: AnyObject) {
        
        auth.firstName = firstNameTxt.text
        auth.lastName = lastNameTxt.text
        auth.password = passwordTxt.text
        auth.emailAddress = emailAddressTxt.text
        
        // make sure the first name has at least 2 characters.
        if (auth.firstName.length() < 2) {
            self.authNotification.text = "First name should be at least 2 characters"
            self.shakeAnimation(firstNameTxt)
            return
            
        }
        // maek sure the last name has at least 2 characters.
        if (auth.lastName.length() < 2) {
            self.authNotification.text = "Last name should be at least 2 characters"
            self.shakeAnimation(lastNameTxt)
            return
            
        }
        
        // validate email
        if (isValidEmail(emailAddressTxt.text!) == false) {
            self.authNotification.text = "Email address is not valid"
            self.shakeAnimation(emailAddressTxt)
            return
        }
        
        //  check passwd, ensure they are the same..
        if (confirmPasswordTxt.text != auth.password) {
            self.authNotification.text = "Passwords don't match"
            self.shakeAnimation(passwordTxt)
            self.shakeAnimation(confirmPasswordTxt)
            return
        }
        // check password length is at least 3
        if (auth.password.length() < 3) {
            self.authNotification.text = "Password should be at least 3 characters"
            self.shakeAnimation(passwordTxt)
            return
        }
        
        auth.registerUser()
        
    }

    /**
    Validate the email address

    - parameter testStr: <#testStr description#>

    - returns: <#return value description#>
    */
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    
    
    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
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
    Go back to getting started.
    
    - parameter gesture: <#gesture description#>
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
    Move contraint on keyboard show.
    
    - parameter notification: <#notification description#>
    */
    func keyboardWasShown(notification: NSNotification) {
        
        //        println("Loading Keyboard.")
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: {
            () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 10
        })
    }
    
    /**
    
    
    - parameter sender: <#sender description#>
    */
    func keyboardWillHide(sender: NSNotification) {
        // self.view.frame.origin.y += 150
        UIView.animateWithDuration(0.1, animations: {
            () -> Void in
            self.bottomConstraint.constant = 10
        })
    }
    
    @IBAction func backButton(sender: AnyObject) {
    }
    // On touching the background... Hide keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
