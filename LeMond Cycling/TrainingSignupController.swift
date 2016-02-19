//
//  PaidTrainingController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 7/15/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import CoreData
import WatchCoreDataProxy

struct featureSetRow{
    var title: String!
    var desc: String!
    var image: UIImage!
}

class TrainingSignupController : UIViewController {

    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    
    @IBOutlet weak var totalview: UIView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var PageController: UIPageControl!
    @IBOutlet weak var naviationBar: UINavigationBar!

    var Btn1 = UIButton()
    var Btn2 = UIButton()

    @IBOutlet var navigateMenuBar: UINavigationItem!

    var leFeatureSet:[featureSetRow] = []
    var leWidth :CGFloat = 0

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

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    /**
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.PortraitUpsideDown.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        ScrollView.frame = self.view.frame
        automaticallyAdjustsScrollViewInsets = false


        // make the height taller!
        naviationBar.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 66)

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        leWidth = screenSize.width

        // add back button
        let backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        backBtn.tintColor = UIColor.whiteColor()
        navigateMenuBar.leftBarButtonItem = backBtn
        
        self.ScrollView.pagingEnabled = true

        let defaultOffset = CGFloat(90.0)


        //***setting u the pageviews**//

        
        let x1 = (ScreenSize.SCREEN_WIDTH)
        let y1 = (ScreenSize.SCREEN_HEIGHT)
        let leView1 = TraineeSessionView()
        leView1.graphicToShow = 1
        leView1.TitleName = "Predictive Feedback"
        leView1.DescName = "Never worry about how to improve your game, we’ll let you know what you need to do."
        // println("scroll view width\(ScrollView.frame.size.width)")
        // println("scroll view height\(ScrollView.frame.size.height)")
        leView1.frame = CGRectMake((x1 * 0.186), (y1 * 0.25), 240, 240)
        leView1.backgroundColor = UIColor.clearColor()
        ScrollView.addSubview(leView1)

        let leView2 = TraineeSessionView()
        leView2.graphicToShow = 2
        leView2.TitleName = "Quantitative Analysis"
        leView2.DescName = "Get the real results just as your coach would, easily explained just as any pro would want to hear."

        leView2.frame = CGRectMake(CGFloat(ScreenSize.SCREEN_WIDTH * 1) + CGFloat(70.0), (y1 * 0.25), 240, 240)
        leView2.backgroundColor = UIColor.clearColor()
        ScrollView.addSubview(leView2)

        let leView3 = TraineeSessionView()
        leView3.graphicToShow = 3
        leView3.TitleName = "Pro Training Programs"
        leView3.DescName = "Use the same programs the Pro’s use.  Backed by world class Physiologists."
        leView3.frame = CGRectMake(CGFloat(ScreenSize.SCREEN_WIDTH * 2 ) + CGFloat(70.0), (y1 * 0.25), 240, 240)
        leView3.backgroundColor = UIColor.clearColor()
        ScrollView.addSubview(leView3)

        let leView4 = TraineeSessionView()
        leView4.graphicToShow = 4
        leView4.TitleName = "Group Finder"
        leView4.DescName = "Riding with a pack and lost your crew?  We've got you covered with our Group Finder."
        leView4.frame = CGRectMake(CGFloat(ScreenSize.SCREEN_WIDTH * 3 ) + CGFloat(70.0), (y1 * 0.25), 240, 240)
        leView4.backgroundColor = UIColor.clearColor()
        ScrollView.addSubview(leView4)
        ScrollView.contentSize = CGSizeMake(CGFloat(ScreenSize.SCREEN_WIDTH * 4), 592)

        Btn1.frame = CGRectMake(CGFloat(2.0), (y1 - 85), (ScreenSize.SCREEN_WIDTH * 0.5), 85)
        Btn1.setTitle("9.99 USD Per Month", forState:  UIControlState.Normal)
        //Btn1.titleLabel!.font =  UIFont(name: "UnitedSansSemiCond-Heavy", size: 20.0)
        Btn1.tag = 158979
        Btn1.backgroundColor = UIColor.grayColor()
        Btn1.addTarget(self, action: "PerMonth_Subscripton", forControlEvents: UIControlEvents.TouchUpInside)
        totalview.addSubview(Btn1)

        Btn2.frame = CGRectMake(CGFloat(x1 * 0.5) + CGFloat(5.0), (y1 - 85), (ScreenSize.SCREEN_WIDTH * 0.48), 85)
        Btn2.setTitle("99.99 USD A Year", forState:  UIControlState.Normal)
        //Btn2.titleLabel!.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20.0)
        Btn2.tag = 158970
        Btn2.backgroundColor = UIColor.grayColor()
        Btn2.addTarget(self, action: "PerYear_Subscripton", forControlEvents: UIControlEvents.TouchUpInside)
        totalview.addSubview(Btn2)

    }

    /**
    Scroll View Did End Decelerating

    - parameter scrollView: <#scrollView description#>
    */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        let xOffset: CGFloat = ScrollView.contentOffset.x
        //Change the pageControl dots depending on the page / offset values
        let x1 = ScreenSize.SCREEN_WIDTH
        if (xOffset < 1.0) {
            PageController.currentPage = 0
        } else if (xOffset < (x1 + 1 )) {
            PageController.currentPage = 1
        } else if(xOffset < (x1 * 2) + 1){
            PageController.currentPage = 2
        } else if(xOffset < (x1 * 3) + 1) {
            PageController.currentPage = 3
        }


    }
    
    /**
    Go back
    
    - parameter sender: <#sender description#>
    */
    func backButton(sender: UIButton!) {
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    /**
    Did layout Sub View
    */
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                self.view.bringSubviewToFront(subView)
            }
        }
        super.viewDidLayoutSubviews()
    }
    

}