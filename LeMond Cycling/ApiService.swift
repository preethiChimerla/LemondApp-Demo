//
//  ApiService.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 7/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation

class ApiService {

    static var api = ApiService()

    /**
    Our Get Method

    - parameter url:          <#url description#>
    - parameter getCompleted: <#getCompleted description#>
    - parameter msg:          <#msg description#>
    - parameter parseJSON:    <#parseJSON description#>
    */
    func getMethod(url: String, getCompleted: (succeeded:Bool, msg:String, parseJSON: NSDictionary) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"

        var err: NSError?
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.addValue("application/json", forHTTPHeaderField: "Accept")

        var task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            var err: NSError?

            var json:NSDictionary!
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            }catch{
                // print(error)
            }


            var msg = "No message"
            let blank =  NSDictionary()

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (err != nil) {
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)

                getCompleted(succeeded: false, msg: "Error", parseJSON: blank)
            } else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {

                        getCompleted(succeeded: success, msg: "success", parseJSON: parseJSON)
                    }
                    return
                } else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    getCompleted(succeeded: false, msg: "Error", parseJSON: blank)
                }
            }
        })

        task.resume()
    }

    /**
    Our Post Method

    - parameter params:        <#params description#>
    - parameter url:           <#url description#>
    - parameter postCompleted: <#postCompleted description#>
    - parameter msg:           <#msg description#>
    - parameter parseJSON:     <#parseJSON description#>
    */
    func postMethod(params: Dictionary<String, String>, url: String, postCompleted: (succeeded:Bool, msg:String, parseJSON: NSDictionary) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        var task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            var err: NSError?

            var json:NSDictionary!
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            }catch{
            }

            var msg = "No message"
            let blank =  NSDictionary()

            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if (err != nil) {
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
            } else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {
                        postCompleted(succeeded: success, msg: "Logged in.", parseJSON: parseJSON)
                    }
                    return
                } else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    postCompleted(succeeded: false, msg: "Error", parseJSON: blank)
                }
            }
        })
        
        task.resume()
    }
    
}