 //
 //  AppDelegate.swift
 //  LeMond Cycling
 //
 //  Created by Nicolas Wegener on 4/8/15.
 //  Copyright (c) 2015 LeMond. All rights reserved.
 //

 import UIKit
 import CoreData
 import Fabric
 import Crashlytics

 @UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreLocationController: CoreLocationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {

        // Weather SDK setup
        AerisEngine.engineWithKey("ZWdMIdsd9vkB3nbavFQpd", secret: "205vi1Ie8scxmQZYXY3tZD3pnd80HbbuGJQV4Hhn")
        //AerisEngine.enableDebug()
        // core location ...
        self.coreLocationController = CoreLocationController()

        let tokenExpiry = TegKeychain.get("Auth_Token_Expiry")
        let token = TegKeychain.get("Auth_Token")
        let faceBookToken = TegKeychain.get("Auth_Facebook_Token")

        // is Logined In?
        if (token == nil && faceBookToken == nil) {
            self.window?.rootViewController = UIStoryboard(name: "Login", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UIViewController!
        }else{
            // Validtae Login
            let cs = APIController()
            cs.validateFacebook()
            // Is Training Enabled.
            cs.isTrainingEnabled()
        }


        // Add Prefrence to look for this.
        //        UIApplication.sharedApplication().idleTimerDisabled = true

        // return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //        switch(getMajorSystemVersion()) {
        //        case 8:
        //            let pushSettings: UIUserNotificationSettings = UIUserNotificationSettings(
        //                forTypes:
        //                UIUserNotificationType.Alert |
        //                    UIUserNotificationType.Badge |
        //                    UIUserNotificationType.Sound,
        //                categories: nil)
        //            UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
        //            UIApplication.sharedApplication().registerForRemoteNotifications()
        //            // case 9:
        //        default:
        //            return true
        //        }
        let awfulAction = UIMutableUserNotificationAction()
        awfulAction.identifier = "AwfulAction"
        awfulAction.title = "AWFUL"
        awfulAction.activationMode = UIUserNotificationActivationMode.Background
        awfulAction.destructive = false

        let okAction = UIMutableUserNotificationAction()
        okAction.identifier = "OkAction"
        okAction.title = "OK"
        okAction.activationMode = UIUserNotificationActivationMode.Background
        okAction.destructive = false

        let greatAction = UIMutableUserNotificationAction()
        greatAction.identifier = "GreatAction"
        greatAction.title = "GREAT"
        greatAction.activationMode = UIUserNotificationActivationMode.Background
        greatAction.destructive = false

        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = "CounterCategory"
        counterCategory.setActions([awfulAction, okAction, greatAction], forContext: UIUserNotificationActionContext.Default)
        counterCategory.setActions([awfulAction, okAction, greatAction], forContext: UIUserNotificationActionContext.Minimal)

        Fabric.with([Crashlytics()])
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application( application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.

    }

    func applicationSignificantTimeChange(application: UIApplication) {

    }

    func getMajorSystemVersion() -> Int {
        return Int(String(Array(UIDevice.currentDevice().systemVersion.characters)[0]))!
    }
    
 }
