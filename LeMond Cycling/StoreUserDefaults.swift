//
//  StoreUserDefaults.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/5/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation


class StoreUserDefaults {
    
    /// <#Description#>
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var saveLanguageDelegate: SettingsLanguageProtocol?
    
    // ////
    // Base Stuff
    // ////
    
    var AppDidExitProperly: Bool! {
        get {
            var returnValue: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("AppDidExitProperly") as? Bool
            if returnValue == nil {
                returnValue = true
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "AppDidExitProperly")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // ///////
    // Done Base Stuff
    // ///////
    
    var UserAge: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserAge") as? String
            if returnValue == nil {
                returnValue = "32"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserAge")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var UserHeight: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserHeight") as? String
            if returnValue == nil {
                returnValue = "6.1"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserHeight")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var UserWeight: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserWeight") as? String
            if returnValue == nil {
                returnValue = "180"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserWeight")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // User's Gender
    var UserGender: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserGender") as? String
            if returnValue == nil {
                returnValue = "1"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserGender")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    //**Storing Bike Data ***//
    var UserBikeWeight: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserBikeWeight") as? String
            if returnValue == nil {
                returnValue = "12"
            }
            
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserBikeWeight")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var UserWheelSize: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserWheelSize") as? String
            if returnValue == nil {
                returnValue = "700"
            }
            return returnValue!
        }
        set(newValue) {
            //println("Storing \(newValue)")
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserWheelSize")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var UserTirePressure: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserTirePressure") as? String
            if returnValue == nil {
                returnValue = "110"
            }
            return returnValue!
        }
        set(newValue) {
            //println("Storing \(newValue)")
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "UserTirePressure")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var UserwheelType: String {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("UserwheelType") as? String
            if returnValue == nil {
                returnValue = "Standard"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "UserwheelType")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    //***Storing Profile Data *****//
    
    var prefferedName: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("prefferedName") as? String
            if returnValue == nil {
                returnValue = ""
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue as String, forKey: "prefferedName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var FirstName: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("FirstName") as? String
            if returnValue == nil {
                returnValue = ""
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "FirstName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var LastName: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("LastName") as? String
            if returnValue == nil {
                returnValue = ""
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "LastName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    var LanguageName: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("LanguageName") as? String
            if returnValue == nil {
                returnValue = "English"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "LanguageName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var LanguageCode: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("LanguageCode") as? String
            if returnValue == nil {
                returnValue = "EN"
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "LanguageCode")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var Imperial: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("Imperial") as? String
            
            if returnValue == nil {
                returnValue = "Imperial"
            }
            
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "Imperial")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    // checing if user logined through strava ?? ..
    var stravaAuthorized: Bool! {
        get {
            var returnValue: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("stravaAuthorized") as? Bool
            if returnValue == nil {
                returnValue = false
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "stravaAuthorized")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    // user was authorized through facebook ?? ..
    var facebookAuthorized: Bool! {
        get {
            var returnValue: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("FacebookAuthorized") as? Bool
            if returnValue == nil {
                returnValue = false
            }
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "FacebookAuthorized")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var Username: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("Username") as? String
            
            if returnValue == nil {
                returnValue = ""
            }
            
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "Username")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var Password: String! {
        get {
            var returnValue: String? = NSUserDefaults.standardUserDefaults().objectForKey("Password") as? String
            
            if returnValue == nil {
                returnValue = ""
            }
            
            return returnValue!
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "Password")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}