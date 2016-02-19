//
//  APIController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 4/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import Security

/**
* Authentication
*/

class APIController {


    //
    static var api = APIController()
    var disableToken = false



    // Login
    private var uuid = "ace2a150-2d8c-492a-9bbf-4558a25bed7a"
    private var fqdn = "https://lemond.cc/"
    private var loggedIn = 0;
    private var isErrorCode = 0;
    var ud = StoreUserDefaults()
    
    // Auth table
    var username: String!
    var password: String!


    
    
    var firstName: String!
    var lastName: String!
    var recipientName: String!
    var emailAddress: String!
    
    // Delegate
    var delegate: APIControllerProtocol?
    
    
    // Sometimes we need this to satisfy our dependency clauses
    init() {
    }
    
    
    // Set Password
    func setUsername(leName: String) {
        username = leName;
    }
    // Get Username
    func getUsername() -> String {
        return username;
    }
    
    // Set Password
    func setPassword(lePass: String) {
        password = lePass;
    }
    // Get Password
    func getPassword() -> String {
        return password;
    }
    
    /// Is Logged in
    /// True if we are
    func isLoggedIn() -> Bool {
        
        if (loggedIn > 0 && isErrorCode == 0) {
            return true;
        }
        return false;
    }
    
    
    /**
    Login normally
    */
    func loginStandard() {
        
        // If either the username or the password are null
        if (getUsername().characters.count == 0 || getPassword().characters.count == 0) {
            return;
        }

        self.postLogin(
            [
                "username": getUsername(),
                "password": getPassword(),
                "key": uuid
            ],
            url: fqdn + "m/login"
            ) {
                (succeeded: Bool, msg: String, data: NSDictionary) -> () in
                if (succeeded) {
                    self.loggedIn = 1;
                    self.isErrorCode = 0;
                    self.ud.Username = self.getUsername()
                    self.ud.Password = self.getPassword()
                } else {
                    self.loggedIn = 0;
                    self.isErrorCode = 1;
                }
                
                self.delegate?.didRecieveLoginResult(self.loggedIn)
                ComputerRuntimeVariables.LoginCount++
        }
        
    }
    
    /**
    Login with facebook
    */
    
    func loginFacebook(id: Int, auth: String, firstName: String, lastName: String, email:String ){
        
        self.postMethod(
            [
                "profileId" : "\(id)",
                "authtoken" : auth,
                "firstName" : firstName,
                "lastName"  : lastName,
                "email"     : email,
                "key"       : uuid
            ],
            url: fqdn + "m/fb/login"
            ) {
                (succeeded: Bool, msg: String) -> () in
                if (succeeded) {
                    
                    // validate the authtoken
                } else {
                    // skip that
                }
        }
    }
    
    /**
    <#Description#>
    */
    func validateFacebook(){

        let faceBookToken = TegKeychain.get("Auth_Facebook_Token")
        //println("Facebook Token \(faceBookToken)")
        if(faceBookToken == nil){
            return
        }

        let fUrl = fqdn + "m/fb/login/" + faceBookToken!
        // println(fUrl)

        ApiService.api.postMethod([
            "username": uuid,
            "password": faceBookToken!
            ],url: fUrl) {
                (succeeded: Bool, msg: String, parseJSON: NSDictionary) -> () in

                // let isCustomer = parseJSON["isCustomer"] as! Bool
                // println("is Customer \(isCustomer)")

                if(succeeded){
                    print(parseJSON)
                }else{
                    // yep we failed
                    print("failed FB Auth request")
                }
        }
    }

    /**
    Register user
    */
    func registerUser() {
        
        self.postMethodSignup(
            [
                "firstName": firstName,
                "lastName": lastName,
                "emailAddress": emailAddress, // <-- username
                "password": password,
                "key": uuid
            ],
            url: fqdn + "m/register"
            ) {
                (succeeded: Bool, msg: String, parseJSON: NSDictionary) -> () in
                
                var s = 0
                var leMsg = ""
                for (e, m) in parseJSON {
                    if(e as! String == "success"){
                        s = m as! Int
                    }
                    if(e as! String == "error"){
                        leMsg = m as! String
                    }
                }
                
                self.delegate?.didRecieveRegisterResult(s, message: leMsg)
                
        }
    }
    
    /**
    Retrive password
    */
    func retrivePassword() {
        let un = getUsername()
        self.getRetrivePassword(
            fqdn + "c/fp/\(un)"
            ) {
                (succeeded: Bool, msg: String) -> () in

                if (succeeded) {
                    self.loggedIn = 1;
                    self.isErrorCode = 0;
                } else {
                    self.loggedIn = 0;
                    self.isErrorCode = 1;
                }
            
        }
    }

    /**
    Training Enabled.
    */
    func isTrainingEnabled(){
        // Invoke the training method
        ApiService.api.getMethod( fqdn + "m/training" ){
            (succeeded: Bool, msg: String, parseJSON: NSDictionary) -> () in
            print(" Training Success-> \(succeeded) ")
            if(succeeded == true){
                ComputerRuntimeVariables.TrainingMode = true
            }else{
                ComputerRuntimeVariables.TrainingMode = false
            }
        }
    }

    
    /**
    Login Request
    
    - parameter params:        <#params description#>
    - parameter url:           <#url description#>
    - parameter postCompleted: <#postCompleted description#>
    */
    func postLogin(params: Dictionary<String, String>, url: String, postCompleted: (succeeded:Bool, msg:String, parseJSON: NSDictionary) -> ()) {

        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"



        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch let error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

//        if(disableToken == false){
//            let token = TegKeychain.get("Auth_Token")!
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in

            _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let _: NSError?

            var json:NSDictionary!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            }catch{
                // print(error)
            }
            _ = "No message"
            let blank =  NSDictionary()

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (error != nil) {
                _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
            } else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {

                        if (success) {
                            let userCalendar = NSCalendar.currentCalendar()
                            let expiry = userCalendar.dateByAddingUnit(.Day, value: 30, toDate: NSDate(), options: [])!

                            var leID = parseJSON["id"] as? String
                            TegKeychain.set("Auth_Token", value: leID!)
                            TegKeychain.set("Auth_Token_Expiry", value: String(format: "%d", Float(expiry.timeIntervalSince1970)))
                        }
                        postCompleted(succeeded: success, msg: "Logged in.", parseJSON: parseJSON)
                    }
                    return
                } else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
                }
            }
        })
        
        task.resume()


    }
    
    /**
    <#Description#>

    - parameter params:        <#params description#>
    - parameter url:           <#url description#>
    - parameter postCompleted: <#postCompleted description#>
    - parameter msg:           <#msg description#>
    */
    func postMethod(params: Dictionary<String, String>, url: String, postCompleted: (succeeded:Bool, msg:String) -> ()) {


        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"



        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch let error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

//        if(disableToken == false){
//            let token = TegKeychain.get("Auth_Token")!
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in

            _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let _: NSError?

            var json:NSDictionary!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            }catch{
                // print(error)
            }
            _ = "No message"
            let blank =  NSDictionary()

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (error != nil) {
                _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                postCompleted(succeeded: false, msg: "Error")
            } else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it

                    if let success = parseJSON["success"] as? Bool {
                        //println(parseJSON)
                        postCompleted(succeeded: success, msg: "Logged in.")

                    }

                    return
                } else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    postCompleted(succeeded: false, msg: "Error")
                }
            }
        })
        
        task.resume()

//
//        // OLD
//
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch var error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {
//            data, response, error -> Void in
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            var err: NSError?
//
//
//            var json:NSDictionary
//            do{
//                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary!
//            }catch{
//            }
//
//            
//            var msg = "No message"
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if (err != nil) {
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                postCompleted(succeeded: false, msg: "Error")
//                
//            } else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    if let success = parseJSON["success"] as? Bool {
//                        //println(parseJSON)
//                        postCompleted(succeeded: success, msg: "Logged in.")
//                        
//                    }
//                    return
//                } else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    postCompleted(succeeded: false, msg: "Error")
//                    
//                }
//            }
//        })
//        
//        task.resume()
    }

    /**
    <#Description#>

    - parameter params:        <#params description#>
    - parameter url:           <#url description#>
    - parameter postCompleted: <#postCompleted description#>
    - parameter msg:           <#msg description#>
    - parameter parseJSON:     <#parseJSON description#>
    */
    func postMethodSignup(params: Dictionary<String, String>, url: String, postCompleted: (succeeded:Bool, msg:String, parseJSON: NSDictionary) -> ()) {



        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"



        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch let error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

//        if(disableToken == false){
//            let token = TegKeychain.get("Auth_Token")!
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in

            _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let _: NSError?

            var json:NSDictionary!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            }catch{
                // print(error)
            }
            _ = "No message"
            let blank =  NSDictionary()

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (error != nil) {
                _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
            } else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {
                        postCompleted(succeeded: success, msg: "", parseJSON: parseJSON )
                    }
                    return
                } else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
                }
            }
        })
        
        task.resume()
    }
    
    
    /**
    <#Description#>

    - parameter url:           <#url description#>
    - parameter postCompleted: <#postCompleted description#>
    - parameter msg:           <#msg description#>
    */
    func getRetrivePassword(url: String, getCompleted: (succeeded:Bool, msg:String) -> ()) {


        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"

        // JWT Token auth
        if( disableToken == false && TegKeychain.get("Auth_Token") != nil){
            let token = TegKeychain.get("Auth_Token")!
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in

            let blank =  NSDictionary()

            // print("Error \(error)")

            if(response == nil){
                getCompleted(succeeded: false, msg: "Error")
            }else{
                var json:NSDictionary!
                do{
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }catch{
                    // print(error)
                }

                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if (error != nil) {
                    _ = NSString(data: data!, encoding: NSUTF8StringEncoding)

                    getCompleted(succeeded: false, msg: "Error")
                } else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                        getCompleted(succeeded: true, msg: "success")
                        return
                    } else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        getCompleted(succeeded: false, msg: "Error")
                    }
                }
            }
        })
        task.resume()

//
//
//        // OLD
//
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        
//        var err: NSError?
//        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {
//            data, response, error -> Void in
//            
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            var err: NSError?
//            var json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            var msg = "No message"
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if (err != nil) {
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                postCompleted(succeeded: false, msg: "Error")
//            
//            } else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    if let success = parseJSON["success"] as? Bool {
//                        if (success) {
//                            
//                            // Do something else
//                            
//                        }
//                        postCompleted(succeeded: success, msg: "")
//                    }
//                    return
//                } else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    postCompleted(succeeded: false, msg: "Error")
//                }
//            }
//        })
//        
//        task.resume()
    }

    
}
