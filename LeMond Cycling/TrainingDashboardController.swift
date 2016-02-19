//
//  TrainingDashboardController.swift
//  charts
//
//  Created by preethi Reddy on 7/21/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
//import Charts

class TrainingDashboardController : UIViewController { // , ChartViewDelegate {
    
    @IBOutlet var navigatebar: UINavigationBar!
    @IBOutlet var navigationMenu: UINavigationItem!
//    @IBOutlet var barChartView: BarChartView!
    @IBOutlet var SaveButton: UIBarButtonItem!
    @IBOutlet var ClearView: ClearChartView!
    
    var days: [String]!
    
    @IBAction func SaveButtonAction(sender: AnyObject) {
//        barChartView.saveToCameraRoll()
    }

    /**
    Go back
    
    - parameter sender: x(date) and y values
    */
    func setChart(dataPoints: [String], values: [Double]) {
//        
//        // adds horizontal lines to the chart
//        let ll = ChartLimitLine(limit: 10.0, label: "Target")
//        barChartView.rightAxis.addLimitLine(ll)
//        
//        // to make the x-axis labels appear down
//        barChartView.xAxis.labelPosition = .Bottom
//        barChartView.backgroundColor = UIColor.whiteColor()
//        
//        // adds animation to the bar chart
//        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
//
//        barChartView.noDataText = "You need to provide data for the chart."
//        var dataEntries: [BarChartDataEntry] = []
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
//            dataEntries.append(dataEntry)
//        }
//        
//        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Time")
//        let chartData = BarChartData(xVals: days, dataSet: chartDataSet)
//        barChartView.data = chartData
    }

    /**
    <#Description#>

    - returns: <#return value description#>
    */
    override func shouldAutorotate() -> Bool {
        return true
    }

    /**
    <#Description#>

    - returns: <#return value description#>
    */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    /**
    View Did Load
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        barChartView.delegate = self

        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
        var leWidth :CGFloat = 0
        
        //        barChartView.delegate = self
        
        // barChartView.noDataText = "You need to provide data for the chart."
        days = ["Monday", "Tuesday", "Wednsday", "Thursday", "Friday", "Saturday", "Sunday"]
        let unitsSold = [ 2.0, 4.0, 6.0, 3.0, 12.0, 16.0, 18.0 ]
        let unitsBrought = [ 1.0, 3.0, 5.0, 10.0, 18.0, 20.0 ]
        
        
        // make the height taller!
        // navigatebar.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 66)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        leWidth = screenSize.width
        
        // add back button
        let backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        backBtn.tintColor = UIColor.whiteColor()
        navigationMenu.leftBarButtonItem = backBtn
        
        setChart(days, values: unitsSold)

        // setChart(days, values: unitsBrought)
    }
    
    /**
    Go back
    
    - parameter sender: <#sender description#>
    */
    func backButton(sender: UIButton!) {
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
}
