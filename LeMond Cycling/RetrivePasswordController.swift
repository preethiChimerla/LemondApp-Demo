//
//  LoginController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 4/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

// copied from loginController for now

class RetrivePasswordController: UIViewController, UITextFieldDelegate {
    
    var cs = UIColors()
    var auth = APIController()
    var originalHeight = 0;
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtUsername: UITextField!
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
        txtUsername.delegate = self
        
        // Swipe Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
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
    
    // On touching the background... Hide keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(sender: AnyObject) {
    }
    
    // Validate email
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    //
    @IBAction func submitPressed(sender: AnyObject) {
        var un = txtUsername.text;
        auth.setUsername(un!)
        if (isValidEmail(un!) == false) {
            self.authNotification.text = "Email address is not valid"
            self.shakeAnimation(txtUsername)
            return
        }
        //self.authNotification.text = "An email has been sent to you"
        Alert()
        auth.retrivePassword()
    }
    
    func Alert() {
        let Alert = UIAlertView()
        Alert.message = "An email has been sent to you"
        Alert.delegate = self
        Alert.show()
        
        // Dismiss after 1 sec
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            Alert.dismissWithClickedButtonIndex(-1, animated: true)
        })
        
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
    
}