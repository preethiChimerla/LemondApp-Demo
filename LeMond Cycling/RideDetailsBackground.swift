//
//  RideDetailsBackground.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/23/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import WatchCoreDataProxy


class ObjectBounds {
    var x: Double = 0.0
    var y: Double = 0.0
    var width:Double = 0.0
    var height:Double = 0.0
}

class RideDetailsBackground : UIView, MKMapViewDelegate {
    
    var OrigDate: NSDate!
    
    var alititudePoints:[Double] = []
    var lat = 0.0
    var long = 0.0
    var cs = UIColors()
    var mapBounds: ObjectBounds!
    var totalMilesBounds: ObjectBounds!
    var AvgSpeed = UILabel()
    var AvgPower = UILabel()
    var AvgHearRate = UILabel()
    var AvgCadence = UILabel()
    
    var Speed = UILabel()
    var Power = UILabel()
    var HearRate = UILabel()
    var Cadence = UILabel()
    
    var TopSpeed = UILabel()
    var TopPower = UILabel()
    var TopHearRate = UILabel()
    var TopCadence = UILabel()
    
    var TopSpd = UILabel()
    var TopPow = UILabel()
    var TopHeart = UILabel()
    var TopCad = UILabel()
    
    var TotalCalrisBurned = UILabel()
    var CalBurned = UILabel()
    var mapView: MKMapView!
    var RideElevation = UILabel()
    var uiChart = ElevationChart()

    override func drawRect(rect: CGRect) {
        // Setup the Default colors
        cs.setStandard()
        
        if(totalMilesBounds != nil){
            var context = UIGraphicsGetCurrentContext()
            
            
           // var aboveMilesY = 0 // totalMilesBounds.y - 10
            
            
            var startX = rect.origin.x + (rect.width * 0.07)
            var endX = rect.origin.x + rect.width - (rect.width * 0.07)
            var horizonYstart = CGRectGetMidY(rect) + (rect.height * 0.13)
            var horizonYend = CGRectGetMidY(rect) + (rect.height * 0.41)
            var UpperHoriYstart = CGFloat(120)
            
            println("jbd svsdb xc\(UpperHoriYstart)")
            var UpperHoriYEnd = CGFloat(170)
            
            var xx  = rect.origin.x + (rect.width)
            var yy = rect.origin.y  + (rect.height * 0.75)
            var w1 = 50
            var h1 = 50
            
            
            println("rectangle width\(rect.width)")
            println("rectangle height\(rect.height)")
            
            // Just below the Name or Date? (done)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX, CGFloat(120))
            CGContextAddLineToPoint(context, endX, CGFloat(120))
            CGContextStrokePath(context)
            
            //just above map and below total miles and total ride time (done)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,  CGFloat(170))
            CGContextAddLineToPoint(context, endX, CGFloat(170))
            CGContextStrokePath(context)
            
            // just above ride Elevation chart (done)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX, CGFloat(323))
            CGContextAddLineToPoint(context, endX, CGFloat(323))
            CGContextStrokePath(context)
            
            //line above speed data feed 
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,CGFloat(rect.height * 0.63))
            CGContextAddLineToPoint(context, endX, CGFloat(rect.height * 0.63))
            CGContextStrokePath(context)

            //line above power data feed
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,CGFloat(rect.height * 0.7))
            CGContextAddLineToPoint(context, endX,CGFloat(rect.height * 0.7))
            CGContextStrokePath(context)

            //line above cadence data feed
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX, CGFloat(rect.height * 0.767))
            CGContextAddLineToPoint(context, endX, CGFloat(rect.height * 0.767))
            CGContextStrokePath(context)

            //line above heartrate data feed
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,CGFloat(rect.height * 0.835))
            CGContextAddLineToPoint(context, endX,CGFloat(rect.height * 0.835))
            CGContextStrokePath(context)

            //line below heartrate data feed (done)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,CGFloat(rect.height * 0.91))
            CGContextAddLineToPoint(context, endX,CGFloat(rect.height * 0.91))
            CGContextStrokePath(context)

            //line below calories burned
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, startX,CGFloat(rect.height * 0.97))
            CGContextAddLineToPoint(context, endX,CGFloat(rect.height * 0.97))
            CGContextStrokePath(context)
            
            //draw Horizontal line at the starting
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, CGRectGetMidX(rect) + CGFloat(5), UpperHoriYstart)
            CGContextAddLineToPoint(context, CGRectGetMidX(rect) + CGFloat(5), UpperHoriYEnd)
            CGContextStrokePath(context)
            
            //draw horizontal line at the ending
            CGContextSetLineWidth(context, 2.0)
            CGContextSetStrokeColorWithColor(context, cs.subNumberText.CGColor)
            CGContextMoveToPoint(context, CGRectGetMidX(rect) + CGFloat(4), horizonYstart)
            CGContextAddLineToPoint(context, CGRectGetMidX(rect) + CGFloat(4), horizonYend)
            CGContextStrokePath(context)
            
            /////**** adding all uilabels of avf and top speeds ... ****/////
            WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"

            
            var rideData:LeMondRide = WatchCoreDataProxy.sharedInstance.fetchSavedRideData(OrigDate)
            let hData = rideData.valueForKey("rideData") as! NSSet

            // get data sets - Parse for nil first
            let AverageSpdVal = rideData.valueForKey("speedAverage") as? NSNumber
            let AveragePowVal =  rideData.valueForKey("wattAverage") as? NSNumber
            let AverageCadVal =  rideData.valueForKey("cadenceAverage") as? NSNumber
            let AverageHRateVal = rideData.valueForKey("heartRateAverage") as? NSNumber

            let TopSpeedVal =  rideData.valueForKey("speedPeak") as? NSNumber
            let TopPowerVal =  rideData.valueForKey("wattPeak") as? NSNumber
            let TopCadenceVal =  rideData.valueForKey("cadencePeak") as? NSNumber
            let TopHeartRateVal = rideData.valueForKey("heartRatePeak") as? NSNumber
            let TotalCalrisBurnedVal = rideData.valueForKey("calories") as? NSNumber

            var AverageSpdText:String!
            if(AverageSpdVal != nil){
                AverageSpdText = String(format: "%.1f", (AverageSpdVal!).doubleValue)
            }else{
                AverageSpdText = "0.0"
            }

            var AveragepowText:String!
            if(AveragePowVal != nil){
                AveragepowText = String(format: "%.1f", (AveragePowVal!).doubleValue)
            }else{
                AveragepowText = "0.0"
            }

            var AverageCadText :String!
            if(AverageCadVal != nil){
                AverageCadText = String(format: "%.1f", (AverageCadVal!).doubleValue)
            }else{
                AverageCadText = "0.0"
            }

            var AverageHRateText :String!
            if(AverageHRateVal != nil){
                AverageHRateText = String(format: "%.1f", (AverageHRateVal!).doubleValue)
            }else{
                AverageHRateText = "0.0"
            }

            var TopSpeedtext:String!
            if(TopSpeedVal != nil){
                TopSpeedtext = String(format: "%.1f", (TopSpeedVal!).doubleValue)
            }else{
                TopSpeedtext = "0.0"
            }

            var TopPowertext:String!
            if(TopPowerVal != nil){
                TopPowertext = String(format: "%.1f",(TopPowerVal!).doubleValue)
            }else{
                TopPowertext = "0.0"
            }


            var TopCadencetext:String!
            if(TopCadenceVal != nil){
                TopCadencetext = String(format: "%.1f", (TopCadenceVal!).doubleValue)
            }else{
                TopCadencetext = "0.0"
            }
            
            
            var TopHeartRatetext : String!
            if(TopHeartRateVal != nil){
                TopHeartRatetext = String(format: "%.1f", (TopHeartRateVal!).doubleValue)
            }else{
                TopHeartRatetext = "0.0"
            }

            var TotalCalrisBurnedtext : String!
            if(TotalCalrisBurnedVal != nil){
                TotalCalrisBurnedtext = String(format: "%.1f", (TotalCalrisBurnedVal!).doubleValue)
            }else{
                TotalCalrisBurnedtext = "0.0"
            }


            AvgSpeed.text = "AVG\nMPH"
            AvgSpeed.textColor = UIColor.yellowColor()
            AvgSpeed.textAlignment = NSTextAlignment.Left
            AvgSpeed.numberOfLines = 2
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                AvgSpeed.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            } else {
                AvgSpeed.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            AvgSpeed.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.63),
                width: CGFloat(w1),
                height: CGFloat(h1))
            self.addSubview(AvgSpeed)
            
            
            AvgPower.text = "AVG\nWATTS"
            AvgPower.textColor = UIColor.cyanColor()
            AvgPower.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                AvgPower.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            } else {
                AvgPower.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            AvgPower.numberOfLines = 2
            AvgPower.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.70),
                width: CGFloat(w1 + 20 ),
                height: CGFloat(h1))
            self.addSubview(AvgPower)
            
            
            AvgCadence.text = "AVG\nRPM"
            AvgCadence.textColor = UIColor.greenColor()
            AvgCadence.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                AvgCadence.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                AvgCadence.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            AvgCadence.numberOfLines = 2
            AvgCadence.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.77),
                width: CGFloat(w1),
                height: CGFloat(h1))
            self.addSubview(AvgCadence)
            
            AvgHearRate.text = "AVG\nBPM"
            AvgHearRate.textColor = UIColor.redColor()
            AvgHearRate.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                AvgHearRate.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                AvgHearRate.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            AvgHearRate.numberOfLines = 2
            AvgHearRate.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.84),
                width: CGFloat(w1),
                height: CGFloat(h1))
            self.addSubview(AvgHearRate)
            
            Speed.text = AverageSpdText
            Speed.textColor = UIColor.whiteColor()
            Speed.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                Speed.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                Speed.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            Speed.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.24),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.63),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(Speed)
            
            Power.text = AveragepowText
            Power.textColor = UIColor.whiteColor()
            Power.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                Power.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
              Power.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            Power.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.24),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.70),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(Power)
            
            HearRate.text = AverageCadText
            HearRate.textColor = UIColor.whiteColor()
            HearRate.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                HearRate.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                HearRate.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            HearRate.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.24),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.77),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(HearRate)
            
            Cadence.text = AverageHRateText
            Cadence.textColor = UIColor.whiteColor()
            Cadence.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                Cadence.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                Cadence.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            Cadence.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.24),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.84),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(Cadence)
            
            TopSpeed.text = "TOP\nMPH"
            TopSpeed.textColor = UIColor.yellowColor()
            TopSpeed.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopSpeed.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                TopSpeed.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            AvgSpeed.numberOfLines = 2
            TopSpeed.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.52),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.63),
                width: CGFloat(60),
                height: CGFloat(50))
            self.addSubview(TopSpeed)
            
            TopPower.text = "TOP\nWATTS"
            TopPower.textColor = UIColor.cyanColor()
            TopPower.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopPower.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                TopPower.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            TopPower.numberOfLines = 2
            TopPower.frame = CGRect(
                x:CGFloat(rect.origin.x) + CGFloat(rect.width * 0.52),
                y:CGFloat(rect.origin.y) + CGFloat(rect.height * 0.70),
                width: CGFloat(w1 + 20 ),
                height: CGFloat(h1))
            self.addSubview(TopPower)
            
            TopCadence.text = "TOP\nBPM"
            TopCadence.textColor = UIColor.greenColor()
            TopCadence.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopCadence.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                TopCadence.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            TopCadence.numberOfLines = 2
            TopCadence.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.52),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.77),
                width: CGFloat(w1),
                height: CGFloat(h1))
            self.addSubview(TopCadence)
            
            TopHearRate.text = "TOP\nRPM"
            TopHearRate.textColor = UIColor.redColor()
            TopHearRate.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopHearRate.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                TopHearRate.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            TopHearRate.numberOfLines = 2
            TopHearRate.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.52),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.84),
                width: CGFloat(w1),
                height: CGFloat(h1))
            self.addSubview(TopHearRate)
            
            TopSpd.text = TopSpeedtext
            TopSpd.textColor = UIColor.whiteColor()
            TopSpd.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopSpd.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                TopSpd.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            TopSpd.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.68),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.63),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(TopSpd)
            
            TopPow.text = TopPowertext
            TopPow.textColor = UIColor.whiteColor()
            TopPow.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopPow.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                TopPow.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            TopPow.frame = CGRect(
                x:CGFloat(rect.origin.x) + CGFloat(rect.width * 0.68),
                y:CGFloat(rect.origin.y) + CGFloat(rect.height * 0.70),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(TopPow)
            
            
            TopCad.text = TopCadencetext
            TopCad.textColor = UIColor.whiteColor()
            TopCad.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopCad.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                TopCad.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            TopCad.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.68),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.77),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(TopCad)
            
            TopHeart.text = TopHeartRatetext
            TopHeart.textColor = UIColor.whiteColor()
            TopHeart.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TopHeart.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                TopHeart.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            TopHeart.frame = CGRect(
                x:CGFloat(rect.origin.x) + CGFloat(rect.width * 0.68),
                y:CGFloat(rect.origin.y) + CGFloat(rect.height * 0.84),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(TopHeart)

            
            TotalCalrisBurned.text = TopCadencetext
            TotalCalrisBurned.textColor = UIColor.whiteColor()
            TotalCalrisBurned.textAlignment = NSTextAlignment.Left
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                TotalCalrisBurned.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 24)
            }else {
                TotalCalrisBurned.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)
            }
            TotalCalrisBurned.frame = CGRect(
                x:CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y:CGFloat(rect.origin.y) + CGFloat(rect.height * 0.90),
                width: CGFloat(rect.width * 0.25),
                height: CGFloat(rect.height * 0.07))
            self.addSubview(TotalCalrisBurned)
            
            CalBurned.text = "CALORIES BURNED"
            CalBurned.textColor = UIColor.grayColor()
            CalBurned.textAlignment = NSTextAlignment.Right
            if(DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P){
                CalBurned.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 15)
            }else {
                CalBurned.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            }
            CalBurned.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.33),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.9),
                width: CGFloat(rect.width * 0.6),
                height: CGFloat(h1))
            self.addSubview(CalBurned)
            
            //seting up mapview
            mapView = MKMapView()
            mapView.frame = CGRect(x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.26),
                width: CGFloat(rect.width * 0.86),
                height: CGFloat(rect.height * 0.22))
            mapView.mapType = MKMapType.Standard
            mapView.zoomEnabled = true
            mapView.scrollEnabled = true
            self.addSubview(mapView)
            
            RideElevation.text = "RIDE ELEVATION"
            RideElevation.textColor = UIColor.whiteColor()
            RideElevation.textAlignment = NSTextAlignment.Center
            RideElevation.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            RideElevation.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.2),
                y: CGFloat(rect.origin.y) + CGFloat(rect.height * 0.465),
                width: CGFloat(rect.width * 0.6),
                height: CGFloat(h1))
            self.addSubview(RideElevation)
            
            //** Adding Elevation Chart **/
            uiChart.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.07),
                y:  CGFloat(rect.origin.y) + CGFloat(rect.height * 0.52),
                width: CGFloat(rect.width * 0.86),
                height: CGFloat(rect.height * 0.1)
            )
            uiChart.alpha = 1
            //uiChart.backgroundColor = cs.background
            uiChart.backgroundColor = UIColor.greenColor()
            self.addSubview(uiChart)
            for  blah in hData  {
                let rData = blah as! LeMondRideData
                
                alititudePoints.append((rData.elevation).doubleValue)
                if (lat == 0.0){
                    lat = (rData.latitude).doubleValue
                    long = (rData.longitude).doubleValue
                }
            }
            uiChart.points = alititudePoints
            uiChart.refesh()
            
            
            // Now send a request off to Google places
            var gp = GooglePlaces()
            var cl = CLLocationCoordinate2D(latitude: lat, longitude: long)
            gp.search( cl, radius: 900, query: "", callback: gpcb)
        }
        
        
    }
    
    func reDraw(){
        self.setNeedsDisplay()
    }
    
    /**
    gpbc
    
    :param: items            <#items description#>
    :param: errorDescription <#errorDescription description#>
    */
    func gpcb(items: [MKMapItem]?, errorDescription: String?){
        // our response
        println(items)
        println(errorDescription)
    }
}
