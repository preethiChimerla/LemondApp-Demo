//
//  RDVicinity.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 7/28/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import MapKit

extension RideDetailsController {

    func determinLocality (pm:  CLPlacemark){

        let geo = CLGeocoder()

        geo.reverseGeocodeLocation(pm.location!, completionHandler: {
            (result: [CLPlacemark]?, err: NSError?) -> Void in
            if err == nil {
                if let placemark = result!.last as CLPlacemark! {
                    // TODO add a delegate to call this back to the Ride Details.
                     //self.delegate?.updateVenueLocality(placeId, name:placemark.locality)
                }
            }
        })
    }
}