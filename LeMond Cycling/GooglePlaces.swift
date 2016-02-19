//
//  GooglePlaces.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 7/7/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit

protocol GooglePlacesDelegate {

    func googlePlacesSearchResult(_: [MKMapItem])

}

class GooglePlaces {

    let URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let LOCATION = "location="
    let RADIUS = "radius="
    var KEY = "key="

    var delegate : GooglePlacesDelegate? = nil

    // ------------------------------------------------------------------------------------------
    // init requires google.plist with key "places-key"
    // ------------------------------------------------------------------------------------------

    init() {
        let path = NSBundle.mainBundle().pathForResource("google", ofType: "plist")
        let google = NSDictionary(contentsOfFile: path!)
        let apiKey:String = (google!["places-key"] as? String)!


        if( !apiKey.isEmpty ){
            self.KEY = "\(self.KEY)\(apiKey)"
        }else {
            // TODO: Exception handling
            print("Exception: places-key is not set in google.plist")
        }
    }

    // ------------------------------------------------------------------------------------------
    // Google Places search with callback
    // ------------------------------------------------------------------------------------------

    func search(
        location : CLLocationCoordinate2D,
        radius : Int,
        query : String,
        callback : (items : [MKMapItem]?, errorDescription : String?) -> Void) {

            var urlEncodedQuery = query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            var urlString = "\(URL)\(LOCATION)\(location.latitude),\(location.longitude)&\(RADIUS)\(radius)&\(KEY)&name=\(urlEncodedQuery!)"

            print(urlString)

            var url = NSURL(string: urlString)
            var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

            session.dataTaskWithURL(url!, completionHandler: { (data : NSData?, response : NSURLResponse?, error : NSError?) -> Void in

                print(GooglePlaces.parseFromData(data!))
                print(response)
                print(error)

                if error != nil {
                    callback(items: nil, errorDescription: error!.localizedDescription)
                }

                if let statusCode = response as? NSHTTPURLResponse {
                    if statusCode.statusCode != 200 {
                        callback(items: nil, errorDescription: "Could not continue.  HTTP Status Code was \(statusCode)")
                    }
                }

                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    callback(items: GooglePlaces.parseFromData(data!), errorDescription: nil)
                })

            }).resume()

    }


    // ------------------------------------------------------------------------------------------
    // Google Places search with delegate
    // ------------------------------------------------------------------------------------------

    func searchWithDelegate(
        location : CLLocationCoordinate2D,
        radius : Int,
        query : String) {

            self.search(location, radius: radius, query: query) { (items, errorDescription) -> Void in
                if self.delegate != nil {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.delegate!.googlePlacesSearchResult(items!)
                    })
                }
            }

    }

    // ------------------------------------------------------------------------------------------
    // Parse JSON into array of MKMapItem
    // ------------------------------------------------------------------------------------------

    class func parseFromData(data : NSData) -> [MKMapItem] {
        var mapItems = [MKMapItem]()

        let json = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary

        let results = json["results"] as? Array<NSDictionary>
        print("results = \(results!.count)")

        for result in results! {

            let name = result["name"] as! String

            var coordinate : CLLocationCoordinate2D!

            if let geometry = result["geometry"] as? NSDictionary {
                if let location = geometry["location"] as? NSDictionary {
                    let lat = location["lat"] as! CLLocationDegrees
                    let long = location["lng"] as! CLLocationDegrees
                    coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

                    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = name
                    mapItems.append(mapItem)
                }
            }
        }
        
        return mapItems
    }
    
}
