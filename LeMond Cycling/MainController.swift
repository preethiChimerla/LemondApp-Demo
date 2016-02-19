//
//  MainController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 4/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MainController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate, LocationProtocol, MainButtonsProtocol, SwiftPromptsProtocol {
    
    var userStore = StoreUserDefaults()
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var navbarView: UIView!
    
    var navTitleLabel1: UIButton!
    var navTitleLabel2: UIButton!
    var navTitleLabel3: UIButton!
    
    var view1: UIView!
    var view2 = ComputerController()
    var mapVcs = MapController()
    var weatherVcs = WeatherController()
    var prompt = SwiftPromptsView()
    // Auth
    var auth = APIController()
    
    // Speed
    var speedReceived: Double = 0
    var currentTime: String!
    var speedChange: Double!
    
    
    // Core Location Controller
    var cl = CoreLocationController()
    
    var currentSetBounds = 2
    
    var shoppingList: NSMutableArray!
    
    
    /**
    <#Description#>
    */
    func settingspopup() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SettingsBase") 
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func showWeather(){
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, 0.0), animated: true)
        currentSetBounds = 0
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    func showMap(){
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height)), animated: true)
        currentSetBounds = 1
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    /**
    Delegate from Map Controller
    Move the scrollview back to the computer.
    */
    func showComputerMain() {
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height * 2)), animated: true)
        currentSetBounds = 2
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
    }
    
    // Go Back
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:

                view2.switchModeUp()
            case UISwipeGestureRecognizerDirection.Right:

                view2.switchModeDown()
            case UISwipeGestureRecognizerDirection.Up:
                // flip to training
                // Change status bar text color to white
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
                print("Caught Up")
                if(currentSetBounds == 0){
                    
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height)), animated: true)
                    currentSetBounds = 1
                }else if(currentSetBounds == 1){
                    
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height) * 2), animated: true)
                    currentSetBounds = 2
                }else if(currentSetBounds == 2){
                    
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height) * 3), animated: true)
                    currentSetBounds = 3
                }
            case UISwipeGestureRecognizerDirection.Down:
                // flip to map
                print("Caught Down")
                if(currentSetBounds == 1){
                    // Change status bar text color to black
                    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, 0.0), animated: true)
                    currentSetBounds = 0
                }else if(currentSetBounds == 2){
                    // Change status bar text color to white
                    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height)), animated: true)
                    currentSetBounds = 1
                }else if(currentSetBounds == 3){
                    // Change status bar text color to white
                    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
                    scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height * 2)), animated: true)
                    currentSetBounds = 2
                }
            default:
                break
            }
        }
    }
    
    func viewDidDisappear() {
        print("View Disapeared")
    }
    
    /**
    make that bar light!
    
    - returns: <#return value description#>
    */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    // On load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        AppState.currentRuntime++
        
        // Delegate
        cl.delegate = self
        view2.delegate = self
        
        // Set default colors
        var cs = UIColors()
        cs.setStandard()
        
        // Core Location Services
        let manager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestAlwaysAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
        // Swipe Controller
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        // Swipe Controller UP and Down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        self.view.backgroundColor = cs.background
        
        // Creating some shorthand for these values
        let wBounds = self.view.bounds.width
        let hBounds = self.view.bounds.height
        
        // This houses all of the UIViews / content
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.frame = self.view.frame
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.scrollEnabled = false
        self.view.addSubview(scrollView)
        
        self.scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.height * 3)
        
        // Putting a subview in the navigationbar to hold the titles and page dots
        navbarView = UIView()
        // self.navigationController?.navigationBar.addSubview(navbarView)
        // self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.hidden = true
        
        // Paging control is added to a subview in the uinavigationcontroller
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: 35, width: 0, height: 0)
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.325, green: 0.667, blue: 0.922, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        
        
        // Titles for the nav controller (also added to a subview in the uinavigationcontroller)
        // Setting size for the titles. FYI changing width will break the paging fades/movement
        let titleSize = CGRect(x: 0, y: 8, width: (wBounds / 2), height: 10) // wBounds
        
        navTitleLabel1 = UIButton()
        navTitleLabel1.frame = titleSize
        navTitleLabel1.setTitle("TRAIN", forState: UIControlState.Normal)
        navTitleLabel1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navTitleLabel1.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 17)
        navTitleLabel1.addTarget(self, action: "moveToTrain:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.navbarView.addSubview(navTitleLabel1)
        
        navTitleLabel2 = UIButton()
        navTitleLabel2.frame = titleSize
        navTitleLabel2.setTitle("RIDE", forState: UIControlState.Normal)
        navTitleLabel2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navTitleLabel2.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 17)
        navTitleLabel2.addTarget(self, action: "moveToRide:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.navbarView.addSubview(navTitleLabel2)
        
        navTitleLabel3 = UIButton()
        navTitleLabel3.frame = titleSize
        // navTitleLabel3.backgroundColor = UIColor.orangeColor()
        navTitleLabel3.setTitle("MAP", forState: UIControlState.Normal)
        navTitleLabel3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navTitleLabel3.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 17)
        navTitleLabel3.addTarget(self, action: "moveToMap:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.navbarView.addSubview(navTitleLabel3)
        // self.navbarView.backgroundColor = cs.topNav

        
        // Views for the scrolling view
        // This is where the content of your views goes (or you can subclass these and add them to ScrollView)
        
        
        // Main Computer
        // Notice the x position increases per number of views
        view2.setLeUsageMode(1)
        view2.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        view2.frame = CGRectMake(0, hBounds * 2, wBounds, hBounds)
        self.scrollView.addSubview(view2)
        self.scrollView.bringSubviewToFront(view2)
        
        // Weather View
        let weatherStoryboard = UIStoryboard(name: "Weather", bundle: nil)
        weatherVcs = weatherStoryboard.instantiateViewControllerWithIdentifier("WeatherStoryboard") as! WeatherController
        self.addChildViewController(weatherVcs)
        weatherVcs.delegate = self
        weatherVcs.view.frame = CGRectMake(0, 0, wBounds, hBounds)
      
        self.scrollView.addSubview(weatherVcs.view)
        self.scrollView.bringSubviewToFront(weatherVcs.view)
        
        // Map View
        let mapStoryboard = UIStoryboard(name: "Map", bundle: nil)
        mapVcs = mapStoryboard.instantiateViewControllerWithIdentifier("MapStoryboard") as! MapController
        self.addChildViewController(mapVcs)
        mapVcs.delegate = self
        mapVcs.view.frame = CGRectMake(0, hBounds, wBounds, hBounds)
        //mapVcs.setNavigationProtocol(view2)
        self.scrollView.addSubview(mapVcs.view)
        self.scrollView.bringSubviewToFront(mapVcs.view)
        
        
        // Training
        let storyboard = UIStoryboard(name: "Training", bundle: nil)
        let vcs = storyboard.instantiateViewControllerWithIdentifier("TrainingStoryboard") as! TrainingController
        self.addChildViewController(vcs)
        vcs.view.frame = CGRectMake(0, hBounds * 3, wBounds, hBounds)
        vcs.setWorkoutProtocol(view2)
        self.scrollView.addSubview(vcs.view)
        self.scrollView.bringSubviewToFront(vcs.view)


        
        if ( ComputerRuntimeVariables.LoginCount >= 1 ) {
            scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, ((self.view.bounds.size.height * 2) + 0)), animated: false)
        } else {
            scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, ((self.view.bounds.size.height * 2) + 20)), animated: false)
        } // */
        
        // Metric
        let index = (userStore.Imperial as NSString).integerValue
        if index == 0 {
            ComputerRuntimeVariables.MetricMode = 0
        } else if index == 1 {
            ComputerRuntimeVariables.MetricMode = 1
        }

        ColorLog.red("Main - viewDidLoad")
    }
    
    
    
    // Move to Train
    func moveToTrain(sender: UIButton!) {
        scrollView.setContentOffset(CGPointMake(0, scrollView.contentOffset.y), animated: true)
    }
    
    // Move to Ride
    func moveToRide(sender: UIButton!) {
        scrollView.setContentOffset(CGPointMake((self.view.bounds.size.width), scrollView.contentOffset.y), animated: true)
    }
    
    // Move to Map
    func moveToMap(sender: UIButton!) {
        scrollView.setContentOffset(CGPointMake((self.view.bounds.size.width * 2), scrollView.contentOffset.y), animated: true)
    }
    
    // Move to Computer
    func moveToComputer(sender: UIButton) {
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, (self.view.bounds.size.height)), animated: true)
    }
    
    
    // Show sub views
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // The gray top part of the header.
        // navbarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30)
        // navbarView.backgroundColor = UIColor.clearColor()
    }
    
    /**
    Scroll View Did Scroll
    
    - parameter scrollView: <#scrollView description#>
    */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // println("Offset: \(scrollView.contentOffset.x) ")
        let xOffset: CGFloat = scrollView.contentOffset.x
        
        // Setup some math to position the elements where we need them when the view is scrolled
        let topPos = 13
        
        let wBounds = self.view.bounds.width
        let wwBounds = (self.view.bounds.width / 3)
        var hBounds = self.view.bounds.height
        // print("hbounds value in scroll view \(hBounds)")
        let widthOffset = wBounds / 100
        let offsetPosition = (0 - xOffset / widthOffset) + (wBounds - (wBounds - wwBounds))
        
        // Apply the positioning values created above to the frame's position based on user's scroll
        
        navTitleLabel1.frame = CGRectMake(offsetPosition, CGFloat(topPos), wwBounds, 20)
        navTitleLabel2.frame = CGRectMake(offsetPosition + 100, CGFloat(topPos), wwBounds, 20)
        navTitleLabel3.frame = CGRectMake(offsetPosition + 200, CGFloat(topPos), wwBounds, 20)
        
        
        navTitleLabel1.alpha = (1 - xOffset / wBounds) + 0.5
        if (xOffset <= wBounds) {
            navTitleLabel2.alpha = (xOffset / wBounds) + 0.5
        } else {
            navTitleLabel2.alpha = (1 - (xOffset - wBounds) / wBounds) + 0.5
        }
        navTitleLabel3.alpha = ((xOffset - wBounds) / wBounds) + 0.5
        
    }
    
    /**
    Scroll View Did End Decelerating
    
    - parameter scrollView: <#scrollView description#>
    */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let xOffset: CGFloat = scrollView.contentOffset.x
        
        //Change the pageControl dots depending on the page / offset values
        
        if (xOffset < 1.0) {
            pageControl.currentPage = 0
        } else if (xOffset < self.view.bounds.width + 1) {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 2
        }
        
    }
    
    /**
    Start Stop Timer
    
    - parameter leTime: <#leTime description#>
    */
    func startstopTimer(leTime: String) {
        currentTime = leTime
    }
    
    /**
    Speed Update
    
    - parameter speed: <#speed description#>
    */
    func didRecieveSpeedUpdate(speed: Double) {
        var ss = speed
        if ss < 0 {
            ss = 0.0
        }
        ComputerRuntimeVariables.Speed = ss
        mapVcs.updateSpeedMap(ss)
        
        // Add a time limit
        if (ComputerRuntimeVariables.ButtonMode == 2 && ComputerRuntimeVariables.TrainingMode == true) {
            if(ComputerRuntimeVariables.OldSpeed != nil ){
                let oldSpeed = ComputerRuntimeVariables.OldSpeed
                let newSpeed = ComputerRuntimeVariables.Speed
                speedChange = newSpeed - oldSpeed
            }

            if abs(speedChange) > 0 && abs(speedChange) < 3 {
                ComputerRuntimeVariables.TrainingPromptCount++
                if(ComputerRuntimeVariables.TrainingPromptCount > 4){
                    showPrompt()
                }
            }else{
                ComputerRuntimeVariables.TrainingPromptCount = 0
            }
        }
    }
    
    /**
    Calories Update
    
    - parameter calories: <#calories description#>
    */
    func didReceiveCalorieUpdate(calories: Double) {
        
    }
    
    /**
    Power Update
    
    - parameter power: <#power description#>
    */
    func didReceivePowerUpdate(power: Double) {
        var pp = power
        if pp < 0 {
            pp = 0.0
        }
        ComputerRuntimeVariables.Power = pp
    }
    
    /**
    Grade Protocol
    
    - parameter Grade: <#Grade description#>
    */
    func didReceiveGradeUpdate(Grade: Double) {
    }
    
    /**
    Received Distance Update
    
    - parameter Distance: <#Distance description#>
    */
    func didReceiveDistanceUpdate(Distance: Double) {
        
    }
    
    /**
    <#Description#>
    
    - parameter altitude: <#altitude description#>
    */
    func didReceiveAltitude(altitude: Double) {
    }
    
    /**
    <#Description#>
    
    - parameter lat:      <#lat description#>
    - parameter lon:      <#lon description#>
    - parameter altitude: <#altitude description#>
    */
    func didReceiveLatLonGrade(lat: Double, lon: Double, altitude: Double) {
    }
    
    
    /**
    <#Description#>
    
    - parameter lat: <#lat description#>
    - parameter lon: <#lon description#>
    */
    func updateMapWithLatLon(lat: Double, lon: Double) {
        mapVcs.updateLatLong(lat, sLon: lon)
        weatherVcs.updateLatLong(lat, sLon: lon)
    }
    
    func showPrompt() {
        if ComputerRuntimeVariables.PromptCheck == 0 {
            //Create an instance of SwiftPromptsView and assign its delegate
            prompt = SwiftPromptsView(frame: self.view.bounds)
            prompt.delegate = self
            
            //Set the properties for the background
            prompt.setColorWithTransparency(UIColor.clearColor())
            
            //Set the properties of the prompt
            prompt.setPromptHeader("LeMond Training")
            prompt.setPromptContentText("Would you like to take 5 min test?")
            prompt.setPromptTopBarVisibility(true)
            prompt.setPromptBottomBarVisibility(false)
            prompt.setPromptTopLineVisibility(false)
            prompt.setPromptBottomLineVisibility(true)
            prompt.setPromptHeaderBarColor(UIColor(red: 100.0/255.0, green: 212.0/255.0, blue: 72.0/255.0, alpha: 1.0))
            prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
            prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
            prompt.setPromptButtonDividerColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
            prompt.enableDoubleButtonsOnPrompt()
            prompt.setMainButtonText("Yes")
            prompt.setSecondButtonText("Not now")
            
            self.view.addSubview(prompt)
            ComputerRuntimeVariables.PromptCheck++
        }
        if ComputerRuntimeVariables.PromptLink == 1 {
            if(ComputerRuntimeVariables.PromptView == 0){
                performSegueWithIdentifier("SpeedTest", sender: self)
            }
            ComputerRuntimeVariables.PromptView++
        }
        
        
    }

    // Delegate functions for the prompt
    
    func clickedOnTheMainButton() {
        
        prompt.dismissPrompt()
    }
    
    func clickedOnTheSecondButton() {
        prompt.dismissPrompt()
    }
    
    func promptWasDismissed() {
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    /**
    <#Description#>
    
    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    
}