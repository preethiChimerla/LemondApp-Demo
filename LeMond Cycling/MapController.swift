//
//  MapController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AddressBook
import AVFoundation


class MapController: UIViewController, MKMapViewDelegate, NavigationProtocol {

    var trackLocation = false
    var lat: Double!
    var lon: Double!
    var coordinate:[CLLocationCoordinate2D] = []
    var speedChange:Double!
    var cc : ComputerController!
    var clc = CoreLocationController()
    var city = ""
    var state = ""
    var country = ""

    var currentCoordinate:CLLocationCoordinate2D!
    var request:MKDirectionsRequest = MKDirectionsRequest()
    var count = 0

    var SourceMapItem:MKMapItem?
    var DestMapItem:MKMapItem?
    var temp:[Double] = []

    var delegate: MainButtonsProtocol?

    //Problematic initialization!!!!!
    var roadName = [String](count: 100, repeatedValue: "")
    var roadCord = [CLLocation](count: 100, repeatedValue: CLLocation(latitude: 37.3, longitude: -120.2))


    var stopNavg = StopNavgButton()
    var windGoButton = WeatherButton()
    var mapComputer = MapCircleView()
    var findCurrentLoc = LocationFinder()
    var SpeedCircle = SpeedCircleViewMap()
    var navgButton = MapGoButton()

    @IBOutlet weak var map: MKMapView!

    func setNavigationProtocol(c: ComputerController) {
        cc = c
        cc.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        trackLocation = true

        // Add map view
        map.frame = view.bounds


        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        map.addGestureRecognizer(panGesture)


        let value = UIInterfaceOrientation.PortraitUpsideDown.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")

        // Add weather button
        windGoButton.frame = CGRectMake((ScreenSize.SCREEN_WIDTH / 2 - 20), 20, 100, 100)
        windGoButton.addTarget(self, action: "displayWind:", forControlEvents: UIControlEvents.TouchUpInside)

        // Add speed circle
        mapComputer.frame = CGRectMake((ScreenSize.SCREEN_WIDTH / 2 - 50), (ScreenSize.SCREEN_HEIGHT - 110), 100, 100)
        mapComputer.addTarget(self, action: "returnToComputer:", forControlEvents: UIControlEvents.TouchUpInside)

        // Add speed animation
        SpeedCircle.oldkInit(CGRectMake(0, (ScreenSize.SCREEN_HEIGHT - 10), 100, 100))

        // Add find current location button
        findCurrentLoc.frame = CGRectMake(20,(ScreenSize.SCREEN_HEIGHT - 73), 26, 26)
        findCurrentLoc.addTarget(self, action: "findCurrentLocation:", forControlEvents: UIControlEvents.TouchUpInside)

        // Add navigation button
        navgButton.frame = CGRectMake((ScreenSize.SCREEN_WIDTH - 40),(ScreenSize.SCREEN_HEIGHT - 40), 50, 50)
        navgButton.addTarget(self, action:"startRoute:", forControlEvents:UIControlEvents.TouchUpInside)

        stopNavg.frame = CGRectMake((ScreenSize.SCREEN_WIDTH - 40),(ScreenSize.SCREEN_HEIGHT - 40), 50, 50)
        stopNavg.addTarget(self, action:"stopNavigation:", forControlEvents:UIControlEvents.TouchUpInside)

        // view.addSubview(map)
        view.addSubview(windGoButton)
        view.addSubview(findCurrentLoc)
        view.addSubview(mapComputer)
        view.addSubview(SpeedCircle)
        view.addSubview(navgButton)
        view.addSubview(stopNavg)

        navgButton.hidden = true
        stopNavg.hidden = true
    }

    // Draw line along route
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        //println("rendererForOverlay");
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay);
            pr.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.5);
            pr.lineWidth = 5;
            return pr;
        }

        return nil
    }


    /**
    <#Description#>

    - parameter speed: <#speed description#>
    */
    func updateSpeedMap(speed: Double) {

        // sanitize the output
        var ss = speed
        if(speed < 0){
            ss = 0.0
        }
        mapComputer.updateSpeed(ss)
    }


    /**
    This activates as soon as app runs

    - parameter sLat: <#sLat description#>
    - parameter sLon: <#sLon description#>
    */
    func updateLatLong(sLat: Double, sLon: Double) {
        lat = sLat
        lon = sLon

        // Draw line on route when start btn pressed
        if( ComputerRuntimeVariables.ButtonMode == 1 && ComputerRuntimeVariables.LocationTracker.count > 1 ){
            var sourceIndex = ComputerRuntimeVariables.LocationTracker.count - 1
            var destinationIndex = ComputerRuntimeVariables.LocationTracker.count - 2
            let c1 = ComputerRuntimeVariables.LocationTracker[sourceIndex].coordinate
            let c2 = ComputerRuntimeVariables.LocationTracker[destinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: 2)
            map.addOverlay(polyline)
            a.removeAll(keepCapacity: true)
            // Lets pop two off the end of the array - or perhaps just one?
            ComputerRuntimeVariables.LocationTracker.removeAtIndex(0)
        }

        // Start tracking when clicks the indCurrentLocation btn
        if (trackLocation) {
            updateMapToCurrentLocation()
            // Update speed
            if(ComputerRuntimeVariables.OldSpeed != nil ){

                let oldSpeed = ComputerRuntimeVariables.OldSpeed / 60
                let newSpeed = ComputerRuntimeVariables.Speed / 60
                // Animate the drawing of the circle over the course of 1 second
                speedChange = newSpeed - oldSpeed
                SpeedCircle.animateCircle(1.0, from: oldSpeed, to: newSpeed)
            }
        }
        if (trackLocation == false) {

            if(ComputerRuntimeVariables.OldSpeed != nil) {

                let oldSpeed = ComputerRuntimeVariables.OldSpeed / 60
                let newSpeed = ComputerRuntimeVariables.Speed / 60
                // Animate the drawing of the circle over the course of 1 second
                speedChange = newSpeed - oldSpeed
                SpeedCircle.animateCircle(1.0, from: oldSpeed, to: newSpeed)
            }
        }

        // Navigation
        if (ComputerRuntimeVariables.NavigationStatus == 1) {

            // Remove route between two pins
            map.removeOverlays(map.overlays)

            // Draw line using current location as source, update in realtime

            var Splacemark = MKPlacemark(coordinate: currentCoordinate, addressDictionary: nil)
            SourceMapItem = MKMapItem(placemark: Splacemark)

            let Dplacemark = MKPlacemark(coordinate: coordinate[coordinate.count - 1], addressDictionary: nil)
            DestMapItem = MKMapItem(placemark: Dplacemark)

            request.source = SourceMapItem
            request.destination = DestMapItem
            request.transportType = MKDirectionsTransportType.Walking
            request.requestsAlternateRoutes = false

            var directions = MKDirections(request: request)

            directions.calculateDirectionsWithCompletionHandler ({
                (response: MKDirectionsResponse?, error: NSError?) in

                if error != nil {
                    return

                } else {
                    for route in response!.routes {
                        // Draw route
                        self.map.addOverlay(route.polyline,
                            level: MKOverlayLevel.AboveRoads)

                        // Store polyline points cooridnates and street name

                        var pointCount = route.polyline.pointCount
                        var coordsPointer = UnsafeMutablePointer<CLLocationCoordinate2D>.alloc(pointCount)
                        route.polyline.getCoordinates(coordsPointer, range: NSMakeRange(0, pointCount))

                        for i in 0..<pointCount {

                            var location = CLLocation(latitude: coordsPointer[i].latitude, longitude: coordsPointer[i].longitude)

                            // FYI: location, placeMark.location and currentCoordinate are all different

                            let geoCoder = CLGeocoder()
                            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                                let placeArray = placemarks as? [CLPlacemark]!
                                var placeMark: CLPlacemark!
                                placeMark = placeArray?[0]
                                // Store polypoint coordinates in order
                                if let streetCord = placeMark.location {
                                    self.storeStreetLocation(streetCord, n: i)
                                }
                                // Store polypoint street name in order
                                if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                                    self.storeStreetName(street as! String, n: i)
                                    self.count++
                                }

                            })

                        }

                        coordsPointer.dealloc(pointCount)
                        self.temp.append(route.distance)

                        // Store route.distance
                        self.temp.append(route.distance)

                        // Check lat and long to decide turns, need to add headings to complete accurracy!
                        if self.count != 0 {

                            if self.roadName[0] == self.roadName[1] {

                                // Proceed
                                ComputerRuntimeVariables.NavigationDirection = 3

                                // U turn
                                if (self.temp.count > 2 && (self.temp[self.temp.count-2] < route.distance)) {
                                    ComputerRuntimeVariables.NavigationDirection = 4

                                }

                            } else {

                                if (self.roadCord[1].coordinate.latitude < self.roadCord[2].coordinate.latitude) || (self.roadCord[1].coordinate.longitude - self.roadCord[0].coordinate.longitude > 0) {
                                    // Turn left
                                    ComputerRuntimeVariables.NavigationDirection = 1


                                } else if (self.roadCord[1].coordinate.latitude > self.roadCord[2].coordinate.latitude) || (self.roadCord[1].coordinate.longitude - self.roadCord[0].coordinate.longitude < 0) {
                                    // Turn right
                                    ComputerRuntimeVariables.NavigationDirection = 2

                                }

                            }

                        }

                    }
                }
            })
        }
    }

    func storeStreetLocation(location:CLLocation, n:Int) {
        self.roadCord[n] = location
    }

    func storeStreetName(name:String , n:Int) {
        self.roadName[n] = name
    }


    /**
    Setting visible area
    */
    func updateMapToCurrentLocation() {

        if(lat == nil) {
            locationAlert()
        } else {
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            currentCoordinate = center
            ComputerRuntimeVariables.CurrentCoordinate = currentCoordinate
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            map.setRegion(region, animated: false)

        }
        if (currentCoordinate != nil) {
            // Fetch city, state and country name for weather
            let location = CLLocation(latitude: currentCoordinate!.latitude, longitude: currentCoordinate!.longitude)
            let geo = CLGeocoder()


            geo.reverseGeocodeLocation(location, completionHandler: {
                (result: [CLPlacemark]?, err: NSError?) -> Void in
                if err == nil {
                    if let placemark = result!.last as CLPlacemark? {
                        self.country = placemark.addressDictionary!["CountryCode"] as! String
                        self.city = placemark.addressDictionary!["SubAdministrativeArea"] as! String
                        self.state = placemark.addressDictionary!["State"] as! String
                        self.willActivate(self.city, state: self.state, country: self.country)
                    }
                }
            })

//
//            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//
//                let placeArray = placemarks as [CLPlacemark]!
//                if let placeMark:CLPlacemark! = placeArray?[0] {
//                    self.country = placeMark!.addressDictionary!["CountryCode"] as! String
//                    self.city = placeMark!.addressDictionary!["SubAdministrativeArea"] as! String
//                    self.state = placeMark!.addressDictionary!["State"] as! String
//                    self.willActivate(self.city, state: self.state, country: self.country)
//                }
//            })
        }
    }

    /**
    Weather

    - parameter city:    <#city description#>
    - parameter state:   <#state description#>
    - parameter country: <#country description#>
    */
    func willActivate(city: String, state: String, country: String) {

        let place = AWFPlace(city: city, state: state, country: country)

        let loader = AWFObservationsLoader()

        loader.getObservationForPlace(place, options: nil, completion: { (observations, error) -> Void in
            if observations != nil {
                if observations.count > 0 {

                    let observation = observations[0] as! AWFObservation
                    self.clc.temperature = observation.tempF
                    self.clc.windSpeed = observation.windSpeedMPH
                    self.clc.windDirection = observation.windDirection

                } else {
                    print("No observations")
                    if let e = error {
                        print("error:  \(e)")
                    }
                }
            }
        })
    }




    /**
    Find Current Location

    - parameter sender: <#sender description#>
    */
    @IBAction func findCurrentLocation(sender: LocationFinder!) {

        // Stop navigation if was navigating
        ComputerRuntimeVariables.NavigationStatus = 0

        updateMapToCurrentLocation()
        trackLocation = true
        hideLocationFinder()

        // Empty the added pin coordinate array
        coordinate = []

        // Cleaning map so that can modify pin dropping location
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        navgButton.hidden = true

    }

    /**
    Handle Pinch

    - parameter recognizer: <#recognizer description#>
    */
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        dispatch_async(dispatch_get_main_queue(), {
            print("Handle Pinch")
            self.trackLocation = false
            self.hideLocationFinder()
        })
    }

    /**
    Hanlde Pan

    - parameter recognizer: <#recognizer description#>
    */
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        dispatch_async(dispatch_get_main_queue(), {
            print("Handle Pan")
            self.trackLocation = false
            self.hideLocationFinder()
        })
    }

    /**
    Add Pin to Map

    - parameter sender: <#sender description#>
    */
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        // Not allowed to route when moving
        if(ComputerRuntimeVariables.Speed > 3 ){
            pinAlert()
            return
        }

        // Show the Go Button
        navgButton.hidden = false

        trackLocation = false
        showLocationFinder()

        if sender.state != UIGestureRecognizerState.Began { return }
        let touchLocation = sender.locationInView(map)
        let newPinCoordinate = map.convertPoint(touchLocation, toCoordinateFromView: map)
        let MyPins = MKPointAnnotation()
        MyPins.coordinate = newPinCoordinate
        map.addAnnotation(MyPins)
        coordinate.append(newPinCoordinate)

        // Require at least two pin to route
        if (coordinate.count == 1) {
            return
        }

        let Splacemark = MKPlacemark(coordinate: coordinate[coordinate.count - 2], addressDictionary: nil)
        SourceMapItem = MKMapItem(placemark: Splacemark)

        let Dplacemark = MKPlacemark(coordinate: coordinate[coordinate.count - 1], addressDictionary: nil)
        DestMapItem = MKMapItem(placemark: Dplacemark)

        // Route

        request.source = SourceMapItem
        request.destination = DestMapItem
        request.transportType = MKDirectionsTransportType.Walking

        // Open to getting more than one route
        request.requestsAlternateRoutes = false

        // Draw line
        let directions = MKDirections(request: request)

        directions.calculateDirectionsWithCompletionHandler ({
            (response: MKDirectionsResponse?, error: NSError?) in

            if error != nil {
                self.map.removeAnnotation(MyPins)
                self.coordinate.removeLast()
                return

            } else {
                for route in response!.routes {
                    self.map.addOverlay(route.polyline,
                        level: MKOverlayLevel.AboveRoads)
                }
            }
        })

    }

    /**
    Don't allow alteration of the course while in motion
    */
    func pinAlert() {
        let pinAlert = UIAlertView()
        pinAlert.message = "Please stop before setting routes"
        pinAlert.delegate = self
        pinAlert.show()

        // Dismiss after 1 sec
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            pinAlert.dismissWithClickedButtonIndex(-1, animated: true)
        })

    }

    /**
    Location Alert
    */
    func locationAlert() {
        let pinAlert = UIAlertView()
        pinAlert.message = "Please turn on GPS"
        pinAlert.delegate = self
        pinAlert.show()

        // Dismiss after 1 sec
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            pinAlert.dismissWithClickedButtonIndex(-1, animated: true)
        })
    }


    func navigation(status: Int) {

    }
    /**
    Start navigation and add stop navigation button
    **/
    @IBAction func startRoute(sender: MapGoButton!) {

        // Start navigation
        ComputerRuntimeVariables.NavigationStatus = 1

        // Update map to current location
        trackLocation = true
        showLocationFinder()

        // Go to main screen
        self.delegate?.showComputerMain()

        // Switch button
        stopNavg.hidden = false
        navgButton.hidden = true
    }

    /**
    Disable Rotation on this screen.

    - returns: <#return value description#>
    */
    override func shouldAutorotate() -> Bool {
        return true
    }

    /**
    Disable Rotation on this screen.
    
    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    /**
    Return to Computer
    
    - parameter sender: <#sender description#>
    */
    @IBAction func returnToComputer(sender: MapCircleView!) {
        self.delegate?.showComputerMain()
    }
    
    /**
    
    
    - parameter sender: <#sender description#>
    */
    @IBAction func displayWind(sender: WeatherButton!) {
        
        self.delegate?.showWeather()
        
    }
    
    /**
    Stop navigation and hide navigation buttons
    
    - parameter sender: <#sender description#>
    */
    @IBAction func stopNavigation(sender: StopNavgButton!) {
        
        // Cleaning map
        map.removeOverlays(map.overlays)
        map.removeAnnotations(map.annotations)
        stopNavg.hidden = true
        navgButton.hidden = true
        
        // Empty pin coordinate array
        coordinate = []
        
        // Empty route.distance array
        temp = []
        
        // Stop navigation
        ComputerRuntimeVariables.NavigationStatus = 0
        
    }
    
    
    func hideLocationFinder(){
        UIView.animateWithDuration(0.1, animations: {
            self.findCurrentLoc.alpha = 0.0
        })
    }
    
    func showLocationFinder(){
        UIView.animateWithDuration(0.1, animations: {
            self.findCurrentLoc.alpha = 1.0
        })
    }
}
