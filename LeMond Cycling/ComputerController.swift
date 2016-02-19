//
//  LeMondComputerController.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit
import WatchCoreDataProxy
import CoreData
import CoreLocation
import AVFoundation

class ComputerController: UIView, LocationProtocol, CadenceDelegate, HeartRateDelegate {

    var ccc = 0.0

    var delegate: MainButtonsProtocol?
    var saveWorkoutDelegate: SaveWorkoutProtocol?
    var navigationDelegate: NavigationProtocol?

    var fillColor = UIColor.redColor()
    var modeColor = UIColor.whiteColor()
    var direction = ""
    // Voice navigation
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")


    // Heart Rate
    var heartRateConnector = HeartRateConnector()
    // var cadenceConnector = CadenceConnector()

    // 1...4 || or 10, whereas that shows all icons
    // shows each clock face as it's usage type.

    var cadenceButton = UIButton()
    var speedButton = UIButton()
    var powerButton = UIButton()
    var HeartrateButton = UIButton()

    var cl = CoreLocationController()
    
    var cs = UIColors()
    var iconSize = 50

    var mainNumber = UILabel()
    var mainSubNumber = UILabel()
    var mainAboveNumber = UILabel()

    // Animated Circle
    // let circleLayer: CAShapeLayer!

    var topLeftNumber = UILabel()
    var topLeftSubNumber = UILabel()
    let topLeftImage = UIImageView()

    var topRightNumber = UILabel()
    var topRightSubNumber = UILabel()
    var topRightImage = UIImageView()

    var bottomLeftNumber = UILabel()
    var bottomLeftSubNumber = UILabel()
    var bottomLeftImage = UIImageView()

    var bottomRightNumber = UILabel()
    var bottomRightSubNumber = UILabel()
    var bottomRightImage = UIImageView()

    var navUpArrow: UIView = UpArrow()
    var navLeftArrow: UIView = LeftArrow()
    var navRightArrow: UIView = RightArrow()
    var navDownArrow: UIView = DownArrow()

    // Elevation Description
    var elevationNumber = UILabel()
    var elevationReading = UILabel()
    var eleNewNumber = UILabel()
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var EleLabel: UILabel!
    var uiChart = ElevationChart()

    var labelLeadingMarginInitialConstant: CGFloat!

    // Total Miles
    var descTotalMilesUp = UILabel()
    var totalMiles = UILabel()

    // Time of day
    var descTimeOfDayUp = UILabel()
    var timeOfDay = UILabel()

    // Miles
    var miles = UILabel()
    var descMiles = UILabel()

    // Time
    var time = UILabel()
    var descTime = UILabel()

    // NSUserDefaults Store

    // Timer
    var startTime = NSTimeInterval()
    var timer: NSTimer = NSTimer()
    var pauseBuffer = NSTimeInterval()
    var pauseStart = NSTimeInterval()
    var pauseTimer: NSTimer = NSTimer()


    // END OF NSUserDefaults Store

    // CA Shape Layer
    var circleLayer: CAShapeLayer!

    var circleViewSpeed = SpeedCircleView()
    var circleViewPower = PowerCircleView()
    var circleViewCadence = CadenceCircleView()
    var circleViewHeartrate = HeartrateCircleView()


    // Start / Stop Button
    var startStopButton = UIButton()
    var stopTimerButton = UIButton()
    var pulseAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity");
    var pulseAnimationStarted = false

    // SettingsButton
    var SettingButton = UIButton()
    var SettingButtonBack = UIButton()
    var SettingButtonImage = UIImageView()

    // Option Window - After stop
    var overlayBackground: SaveWorkoutBackground!
    var containerBox: SaveWorkoutOverlay!
    var discardButton: DiscardWorkoutButton!
    var saveButton: SaveWorkoutButton!
    var returnButton: ReturnWorkoutButton!

    // 0 will be set for watch
    // 1 will be set for iphone
    var displayMode = 1

    // Update Frequency For Dials
    let updateFrequency = 1
    var currentUpdate = 0


    // Saved Ride Info
    var storedName = "Unnamed"

    var updateElevationChartFrequency = 0
    //numbers as text labels on Main Dial
    var DialText = UILabel()
    var metricMode: Int = 0 // defaut to imperial

    // Local notification
    var localNotification:UILocalNotification = UILocalNotification()

    // localNotification.repeatInterval = NSCalendarUnit.CalendarUnitNanosecond

    /**
    Set the Usage Mode

    - parameter mode: 1 thorugh 4 and then 10 for all.
    */
    func setLeUsageMode(mode: Int) {
        ComputerRuntimeVariables.UsageMode = mode
    }

    /**
    The Magic

    - parameter rect: <#rect description#>
    */
    override func drawRect(rect: CGRect) {

        cs.setStandard()
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        // Set the background Color
        CGContextSetFillColorWithColor(context, cs.background.CGColor)
        // Fill background to "Redraw"
        CGContextFillRect(context, rect)

        CGContextSetLineWidth(context, 1.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [-0.0, 0.0, 1.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        var clockNumber = 0.0

        // Set the Main Color(s)
        var leColor = UIColor.whiteColor()
        if (ComputerRuntimeVariables.UsageMode == 1 || ComputerRuntimeVariables.UsageMode == 10) {
            leColor = cs.barSpeed
        } else if (ComputerRuntimeVariables.UsageMode == 2) {
            leColor = cs.barPower
        } else if (ComputerRuntimeVariables.UsageMode == 3) {
            leColor = cs.barHeartrate
        } else if (ComputerRuntimeVariables.UsageMode == 4) {
            leColor = cs.barCadence
        }
        if(leColor == cs.barPower){
            var clockIncrement = 33.334
        } else {
            var clockIncrement = 33.334
        }
        // decide on radius
        var rad: CGFloat
        var i: Int
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            rad = CGRectGetWidth(rect) / 3.3
        } else {
            rad = CGRectGetWidth(rect) / 3
        }
        // circleview numbers in terms of power which is 1 to 400

        for i in 1 ... 60 {
            // save the original position and origin
            CGContextSaveGState(context)

            // make translation
            CGContextTranslateCTM(context, CGRectGetMidX(rect), (CGRectGetMidY(rect) / 1.9))
            // make rotation
            CGContextRotateCTM(context, degree2radian(CGFloat(i) * 6))

            if i % 5 == 0 {
                // if an hour position we want a line slightly longer
                drawSecondMarker(ctx: context!, x: rad - 30, y: 0, radius: rad - 10, color: leColor, size: 1.5)
                if(leColor == cs.barPower){
                    var clockIncrement = 33.334
                    drawSecondNumericalMarker(ctx: context!, x: rad - 10, y: 0, radius: rad - 2, color: leColor, number: clockNumber, inc: i)
                    clockNumber += clockIncrement
                }
                else{
                    var clockIncrement = 5.0
                    drawSecondNumericalMarker(ctx: context!, x: rad - 10, y: 0, radius: rad - 2, color: leColor, number: clockNumber, inc: i)
                    clockNumber += clockIncrement
                }

            } else {
                drawSecondMarker(ctx: context!, x: rad - 10, y: 0, radius: rad, color: leColor, size: 1.5)
            }
            // restore state before next translation
            CGContextRestoreGState(context)
        }

        // This plots the numbers on the screen
        //        drawNumberText(rect, ctx: context, x: rect.width , y: rect.height * 1.228, radius: (rect.width / 2.18) , sides: 12, color: leColor)


        // we decided to put dashes here instead of speed.
        var rpm = "--"
        var bpm = "--"
        var spd = "--"
        var watts = "--"

        if ( ComputerRuntimeVariables.Speed > 0.0 && ComputerRuntimeVariables.Speed.isNormal) {
            spd = String(format: "%.1f", ComputerRuntimeVariables.Speed)
        }

        if ( ComputerRuntimeVariables.Power > 0.0 && ComputerRuntimeVariables.Power.isNormal) {
            let leWatts:UInt32 = UInt32(Float(ComputerRuntimeVariables.Power))
            watts = String(format: "%2d", leWatts)
        }


        // Now Identify Numbers

        if (ComputerRuntimeVariables.UsageMode == 1 || ComputerRuntimeVariables.UsageMode == 10) {

            addMainNumber(rect: rect, leText: spd)

            addMainNumberTextAbove(rect: rect, leText: "SPEED", leColor: leColor)
            if (ComputerRuntimeVariables.MetricMode == 1) {
                addSubMainNumberTextBelow(rect: rect, leText: "KMPH", leColor: leColor)
            }

            if (ComputerRuntimeVariables.MetricMode == 0) {
                addSubMainNumberTextBelow(rect: rect, leText: "MPH", leColor: leColor)
            }

            if ComputerRuntimeVariables.OldSpeed == nil {
                ComputerRuntimeVariables.OldSpeed = 0
            }


            // Calc Speed vs Old Speed
            let oldSpeed = ComputerRuntimeVariables.OldSpeed / 60
            let newSpeed = ComputerRuntimeVariables.Speed / 60


            addAnimatedCircleSpeed(rect: rect, from: oldSpeed, to: newSpeed)
            ComputerRuntimeVariables.OldSpeed = ComputerRuntimeVariables.Speed
        } else if (ComputerRuntimeVariables.UsageMode == 2) {
            addMainNumber(rect: rect, leText: watts)
            addMainNumberTextAbove(rect: rect, leText: "POWER", leColor: leColor)
            addSubMainNumberTextBelow(rect: rect, leText: "WATTS", leColor: leColor)

            if ComputerRuntimeVariables.OldPower == nil {
                ComputerRuntimeVariables.OldPower = 0
            }

            // Calc Power vs Old Power
            let oldPower = ComputerRuntimeVariables.OldPower / 400
            let newPower = ComputerRuntimeVariables.Power / 400
            addAnimatedCirclePower(rect: rect, from: oldPower, to: newPower)
            ComputerRuntimeVariables.OldPower = ComputerRuntimeVariables.Power
        } else if (ComputerRuntimeVariables.UsageMode == 3) {
            addMainNumber(rect: rect, leText: bpm)
            addMainNumberTextAbove(rect: rect, leText: "HEARTRATE", leColor: leColor)
            addSubMainNumberTextBelow(rect: rect, leText: "BPM", leColor: leColor)


            // Computation
            if ComputerRuntimeVariables.OldHeartrate == nil {
                ComputerRuntimeVariables.OldHeartrate = 0
            }

            // Calc Heartrate vs Old Heartrate
            let oldHeartrate = ComputerRuntimeVariables.OldHeartrate / 170
            let newHeartrate = ComputerRuntimeVariables.Heartrate / 170
            addAnimatedCircleHeartrate(rect: rect, from: oldHeartrate, to: newHeartrate)
            ComputerRuntimeVariables.OldHeartrate = ComputerRuntimeVariables.Heartrate

        } else if (ComputerRuntimeVariables.UsageMode == 4) {
            addMainNumber(rect: rect, leText: rpm)
            addMainNumberTextAbove(rect: rect, leText: "CADENCE", leColor: leColor)
            addSubMainNumberTextBelow(rect: rect, leText: "RPM", leColor: leColor)

            // Computation
            if ComputerRuntimeVariables.OldCadence == nil {
                ComputerRuntimeVariables.OldCadence = 0
            }

            // Calc Cadence vs Old Cadence
            let oldCadence = ComputerRuntimeVariables.OldCadence / 215
            let newCadence = ComputerRuntimeVariables.Cadence / 215
            addAnimatedCircleCadence(rect: rect, from: oldCadence, to: newCadence)
            ComputerRuntimeVariables.OldCadence = ComputerRuntimeVariables.Cadence
        }


        // Now Identify Corners
        // TR
        addTopLeft(rect: rect, leText: rpm, leTitle: "RPM", mode: ComputerRuntimeVariables.UsageMode)
        addNavigProceed(rect: rect, mode: ComputerRuntimeVariables.NavigationStatus)
        // TL
        addTopRight(rect: rect, leText: bpm, leTitle: "BPM", mode: ComputerRuntimeVariables.UsageMode)
        // BL
        if ( ComputerRuntimeVariables.MetricMode == 1) {
            addBottomLeft(rect: rect, leText: spd, leTitle: "kMPH", mode: ComputerRuntimeVariables.UsageMode)
        } else if (ComputerRuntimeVariables.MetricMode == 0) {
            addBottomLeft(rect: rect, leText: spd, leTitle: "MPH", mode: ComputerRuntimeVariables.UsageMode)
        }
        // BR
        addBottomRight(rect: rect, leText: watts, leTitle: "WATTS", mode: ComputerRuntimeVariables.UsageMode)


        // Add Lines Below...
        drawBottomLines(ctx: context!, leRect: rect)
        addBottomTextBoxes(rect: rect)
        addMainButton(rect: rect)
        addSettingButton(rect: rect)
        addStopButton(rect: rect)


        //        println("Testing ::    started = \(ComputerRuntimeVariables.HasStarted) && mode = \(ComputerRuntimeVariables.ButtonMode)")
        if (ComputerRuntimeVariables.HasStarted == true && ComputerRuntimeVariables.ButtonMode == 3) {
            showSaveMenu(rect: rect)
        } else {
            removeSaveMenu(rect: rect)
        }
    }


    /**
    Remove all circles
    */
    func removeAllCirlceBars() {
        for i in 2021 ... 2024 {
            let bg = self.viewWithTag(i)
            if (bg != nil) {
                bg!.removeFromSuperview()
            }
        }
    }

    /**
    Power Circle View
    */
    func addAnimatedCirclePower(rect rect: CGRect, from: Double, to: Double) {
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.24) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                circleViewPower = PowerCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))

                circleViewPower.tag = 2021
                self.addSubview(circleViewPower)

                // Animate the drawing of the circle over the course of 1 second
                circleViewPower.animateCircle(1.0, from: from, to: to)
            }
        } else {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.3) // CGFloat(200)
            let circleHeight = circleWidth
            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                if (DeviceType.IS_IPHONE_6) {
                    circleViewPower = PowerCircleView(frame: CGRectMake(59, 303, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_5) {
                    circleViewPower = PowerCircleView(frame: CGRectMake(50, 260, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_6P) {
                    circleViewPower = PowerCircleView(frame: CGRectMake(64, 338, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
                    circleViewPower = PowerCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))
                }
                circleViewPower.tag = 2022
                self.addSubview(circleViewPower)

                // Animate the drawing of the circle over the course of 1 second
                circleViewPower.animateCircle(1.0, from: from, to: to)
            }


        }
    }


    /**
    Speed Circle View
    */
    func addAnimatedCircleSpeed(rect rect: CGRect, from: Double, to: Double) {
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.24) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                circleViewSpeed = SpeedCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))

                circleViewSpeed.tag = 2022
                self.addSubview(circleViewSpeed)

                // Animate the drawing of the circle over the course of 1 second
                circleViewSpeed.animateCircle(2, from: from, to: to)
            }
        } else {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.3) // CGFloat(200)
            let circleHeight = circleWidth
            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                if (DeviceType.IS_IPHONE_6) {
                    circleViewSpeed = SpeedCircleView(frame: CGRectMake(59, 303, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_5) {
                    circleViewSpeed = SpeedCircleView(frame: CGRectMake(50, 258, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_6P) {
                    circleViewSpeed = SpeedCircleView(frame: CGRectMake(64, 334, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
                    circleViewSpeed = SpeedCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))
                }
                circleViewSpeed.tag = 2022
                self.addSubview(circleViewSpeed)

                // Animate the drawing of the circle over the course of 1 second
                circleViewSpeed.animateCircle(1.0, from: from, to: to)
            }
        }
    }

    /**
    Cadence Circle View
    */
    func addAnimatedCircleCadence(rect rect: CGRect, from: Double, to: Double) {
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.24) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                circleViewCadence = CadenceCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))

                circleViewCadence.tag = 2023
                self.addSubview(circleViewCadence)

                // Animate the drawing of the circle over the course of 1 second
                circleViewCadence.animateCircle(1.0, from: from, to: to)
            }
        } else {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.3) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                if (DeviceType.IS_IPHONE_6) {
                    circleViewCadence = CadenceCircleView(frame: CGRectMake(59, 303, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_5) {
                    circleViewCadence = CadenceCircleView(frame: CGRectMake(50, 261, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_6P) {
                    circleViewCadence = CadenceCircleView(frame: CGRectMake(64, 338, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
                    circleViewCadence = CadenceCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))
                }

                circleViewCadence.tag = 2023
                self.addSubview(circleViewCadence)

                // Animate the drawing of the circle over the course of 1 second
                circleViewCadence.animateCircle(1.0, from: from, to: to)
            }
        }
    }

    /**
    HeartRate Circle View
    */
    func addAnimatedCircleHeartrate(rect rect: CGRect, from: Double, to: Double) {
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.24) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                circleViewHeartrate = HeartrateCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))

                circleViewHeartrate.tag = 2024
                self.addSubview(circleViewHeartrate)

                // Animate the drawing of the circle over the course of 1 second
                circleViewHeartrate.animateCircle(1.0, from: from, to: to)
            }
        } else {
            let circleWidth = CGFloat(CGRectGetMidY(rect) / 1.3) // CGFloat(200)
            let circleHeight = circleWidth

            removeAllCirlceBars()

            if (ComputerRuntimeVariables.ButtonMode != 3) {
                // Create a new CircleView
                if (DeviceType.IS_IPHONE_6) {
                    circleViewHeartrate = HeartrateCircleView(frame: CGRectMake(59, 303, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_5) {
                    circleViewHeartrate = HeartrateCircleView(frame: CGRectMake(50, 261, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_6P) {
                    circleViewHeartrate = HeartrateCircleView(frame: CGRectMake(64, 338, circleWidth, circleHeight))
                } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
                    circleViewHeartrate = HeartrateCircleView(frame: CGRectMake(62, 220, circleWidth, circleHeight))
                }

                circleViewHeartrate.tag = 2024
                self.addSubview(circleViewHeartrate)

                // Animate the drawing of the circle over the course of 1 second
                circleViewHeartrate.animateCircle(1.0, from: from, to: to)
            }
        }
    }


    /**
    <#Description#>
    */
    func switchModeUp() -> Void {
        if (ComputerRuntimeVariables.UsageMode < 6) {
            ComputerRuntimeVariables.UsageMode++
        }
        if (ComputerRuntimeVariables.UsageMode == 5) {
            ComputerRuntimeVariables.UsageMode = 1
        }

        clearAllDials()
        self.setNeedsDisplay()
    }

    /**
    <#Description#>
    */
    func switchModeDown() -> Void {
        if (ComputerRuntimeVariables.UsageMode > 0) {
            ComputerRuntimeVariables.UsageMode--
        }

        if (ComputerRuntimeVariables.UsageMode == 0 || ComputerRuntimeVariables.UsageMode > 4) {
            ComputerRuntimeVariables.UsageMode = 4
        }

        clearAllDials()
        self.setNeedsDisplay()
    }

    /**
    Delegate - Did Recieve Speed Update

    - parameter speed: <#speed description#>
    */
    func didRecieveSpeedUpdate(speed: Double) {
        var s = 0.0
        if (speed > 0) {
            s = speed
        }

        let ff = String(format: "%.1f", s)
        WatchCoreDataProxy.sharedInstance.sendSpeedToWatch(ff)

        bottomLeftNumber.text = ff // Bottom Left Number
        if (ComputerRuntimeVariables.UsageMode == 1) {
            ComputerRuntimeVariables.Speed = s
            mainNumber.text = ff
            if (speed > 21.99) {
                mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 65)
            } else {
                mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 70) // UnitedSansSemiCond-Bold
            }
            // Update the screen dials
            if (currentUpdate == updateFrequency) {
                self.setNeedsDisplay()
                currentUpdate = 0
                clearAllDials()
            }
            currentUpdate++
        }
    }


    /**
    Delegate - Did Recieve Power Update

    - parameter power: <#power description#>
    */
    func didReceivePowerUpdate(power: Double) {

        var lePower = 0.0
        if (!power.isNaN) {
            lePower = power
        }

        let ff = String(format: "%.1f", lePower)
        WatchCoreDataProxy.sharedInstance.sendPowerToWatch(ff)
        bottomRightNumber.text = ff // Bottom Right Number
        if (ComputerRuntimeVariables.UsageMode == 2) {
            ComputerRuntimeVariables.Power = lePower
            mainNumber.text = ff
            let cur = mainNumber.font.pointSize
            if (lePower > 100) {
                if (cur != 75) {
                    if (DeviceType.IS_IPHONE_6) {
                        UIView.animateWithDuration(2, animations: {
                            () -> Void in
                            if (DeviceType.IS_IPHONE_4_OR_LESS) {
                                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 45)
                            } else {
                                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 60)
                            }
                        })
                    } else if (DeviceType.IS_IPHONE_5) {
                        UIView.animateWithDuration(2, animations: {
                            () -> Void in
                            if (lePower > 999) {
                                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 55)
                            } else {
                                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 65)
                            }
                        })
                    }
                }
            } else {
                if (cur != 90) {
                    if (DeviceType.IS_IPHONE_6) {
                        UIView.animateWithDuration(2, animations: {
                            () -> Void in
                            self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 70) // UnitedSansSemiCond-Bold
                        })
                    } else if (DeviceType.IS_IPHONE_5) {
                        UIView.animateWithDuration(2, animations: {
                            () -> Void in
                            self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 70) // UnitedSansSemiCond-Bold
                        })
                    } else if (DeviceType.IS_IPHONE_6P) {
                        UIView.animateWithDuration(2, animations: {
                            () -> Void in
                            self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 80) // UnitedSansSemiCond-Bold
                        })

                    }
                }
            }
            // Update the screen dials
            if (currentUpdate == updateFrequency) {
                self.setNeedsDisplay()
                currentUpdate = 0
                clearAllDials()
            }
            currentUpdate++
        }
    }


    /**
    Delegate - Receive Grade update

    - parameter Grade: <#Grade description#>
    */
    func didReceiveGradeUpdate(Grade: Double) {
        var leGrade = 0.0
        if (!Grade.isNaN) {
            leGrade = Grade
        }
        //        println("updating grade on the screen\(leGrade)")
    }

    /**
    Received Distance Update

    - parameter Distance: <#Distance description#>
    */
    func didReceiveDistanceUpdate(Distance: Double) {
        if (ComputerRuntimeVariables.ButtonMode == 1) {
            // Addit on - Cummlative
            ComputerRuntimeVariables.CumulativeDistance += Distance
            // update the screen
            totalMiles.text = String(format: "%.2f", ComputerRuntimeVariables.CumulativeDistance)
        }
    }

    /**
    Delegate - Recieved Calorie Update

    - parameter calories: <#calories description#>
    */
    func didReceiveCalorieUpdate(cal: Double) {
        if (ComputerRuntimeVariables.ButtonMode == 1) {
            ComputerRuntimeVariables.CumulativeCalories += cal
            let cc = String(format: "%.2f", ComputerRuntimeVariables.CumulativeCalories)
            timeOfDay.text = cc
            WatchCoreDataProxy.sharedInstance.sendCaloriesToWatch(cc)
        }
    }


    func didReceiveAltitude(altitude: Double) {

    }


    /*
    Description

    :param: lat <#lat description#>
    :param: lon <#lon description#>
    */
    func updateMapWithLatLon(lat: Double, lon: Double) {

    }

    /**
    Receive Lat/Lon/Grade

    - parameter lat:      <#lat description#>
    - parameter lon:      <#lon description#>
    - parameter altitude: <#altitude description#>
    */
    func didReceiveLatLonGrade(lat: Double, lon: Double, altitude: Double) {

    }

    /**
    Clear All Dials
    */
    func clearAllDials() {
        circleViewSpeed.removeFromSuperview()
        circleViewPower.removeFromSuperview()
        // append the other dials
    }

    /**
    Big Main Number

    - parameter rect:   <#rect description#>
    - parameter leText: <#leText description#>
    */
    func addMainNumber(rect rect: CGRect, leText: String) -> Void {
        let w = 190
        let h = 140

        let xx = Float(CGRectGetMidX(rect)) - Float(w / 2)
        let yy = Float(CGRectGetMidY(rect) / 2) - Float(CGFloat(h) / 2.5)

        mainNumber.text = leText
        mainNumber.tag = 292
        mainNumber.textColor = UIColor.whiteColor()
        mainNumber.textAlignment = NSTextAlignment.Center
        mainNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(292) == nil) {
            self.addSubview(mainNumber)
            if (DeviceType.IS_IPHONE_4_OR_LESS) {
                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 65)
            } else {
                self.mainNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 70)
            }
        }
    }


    /**
    Text Above

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leColor: <#leColor description#>
    */
    func addMainNumberTextAbove(rect rect: CGRect, leText: String, leColor: UIColor) -> Void {
        let w = 190
        let h = 140

        let xx = Float(CGRectGetMidX(rect)) - Float(w / 2)
        let yy = Float(CGRectGetMidY(rect) / 3) - Float(CGFloat(h) / 2.5)

        mainAboveNumber.text = leText
        mainAboveNumber.tag = 291
        mainAboveNumber.textColor = leColor
        mainAboveNumber.textAlignment = NSTextAlignment.Center
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            mainAboveNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 18) //speed font
        } else {
            mainAboveNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 20) //speed font
        }
        mainAboveNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(291) == nil) {
            self.addSubview(mainAboveNumber)
        }
    }


    /**
    Text Below

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leColor: <#leColor description#>
    */
    func addSubMainNumberTextBelow(rect rect: CGRect, leText: String, leColor: UIColor) -> Void {

        let w = 190
        let h = 140

        let xx = Float(CGRectGetMidX(rect)) - Float(w / 2)
        let yy = Float(CGRectGetMidY(rect) / 1.5) - Float(h / 2)

        mainSubNumber.text = leText
        mainSubNumber.tag = 290
        mainSubNumber.textColor = UIColor.whiteColor()
        mainSubNumber.textAlignment = NSTextAlignment.Center
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            mainSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 16)//font for mph of speed
            mainSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy) + CGFloat(2), width: CGFloat(w), height: CGFloat(h))
        } else {
            mainSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 20)//font for mph of speed
            mainSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        }

        if (self.viewWithTag(290) == nil) {
            self.addSubview(mainSubNumber)
        }
    }


    /**
    Top Left

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leTitle: <#leTitle description#>
    - parameter mode:    <#mode description#>
    */
    func addTopLeft(rect rect: CGRect, leText: String, leTitle: String, mode: Int) -> Void {

        let w = 70
        let h = 22

        let icon = iconSize

        let xx = rect.origin.x + (rect.width * 0.08)
        let yy = rect.origin.y + (rect.width * 0.08)

        let newYpos = (CGFloat(yy) + CGFloat(h))

        //var mainNumber = UILabel()
        topLeftNumber.text = leText
        topLeftNumber.tag = 280
        topLeftNumber.textColor = UIColor.whiteColor()
        topLeftNumber.textAlignment = NSTextAlignment.Left
        topLeftNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25) //font for RPM 0.0
        topLeftNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(280) == nil) {
            self.addSubview(topLeftNumber)
        }


        topLeftSubNumber.text = leTitle
        topLeftSubNumber.tag = 281
        topLeftSubNumber.textColor = cs.subNumberText
        topLeftSubNumber.textAlignment = NSTextAlignment.Left
        topLeftSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10) //font for RPM
        topLeftSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(281) == nil) {
            self.addSubview(topLeftSubNumber)
        }


        topLeftImage.image = UIImage(named: "cadence-icon")
        topLeftImage.tag = 282
        topLeftImage.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(icon), height: CGFloat(icon))
        self.addSubview(topLeftImage)

        // add button cadence
        cadenceButton.frame = CGRect(
            x: CGFloat(xx),
            y: CGFloat(yy),
            width: CGFloat(icon),
            height: CGFloat(icon)
        )
        cadenceButton.setTitle("", forState: UIControlState.Normal)
        cadenceButton.tag = 283
        cadenceButton.addTarget(self, action: "changeUsageModeToCadence:", forControlEvents: UIControlEvents.TouchUpInside)
        if (self.viewWithTag(283) == nil) {
            self.addSubview(cadenceButton)
        }

        if (ComputerRuntimeVariables.UsageMode == 4 || ComputerRuntimeVariables.UsageMode == 10) {
            topLeftNumber.hidden = true
            topLeftSubNumber.hidden = true
            topLeftImage.hidden = false
        } else {
            topLeftNumber.hidden = false
            topLeftSubNumber.hidden = false
            topLeftImage.hidden = true
        }

    }

    func changeUsageModeToCadence(sender: UIButton!) {
        ComputerRuntimeVariables.UsageMode = 4
        self.setNeedsDisplay()
    }

    /**
    Navigation arrow

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leTitle: <#leTitle description#>
    - parameter mode:    <#mode description#>
    */
    func addNavigProceed(rect rect: CGRect, mode: Int) -> Void {

        let w = 70
        let h = 22

        let icon = iconSize

        let xx = rect.origin.x + rect.width * 0.435
        let yy = rect.origin.y + (rect.width * 0.06)
        let xl = rect.origin.x + (rect.width * 0.08)
        let yl = rect.origin.y + (rect.width * 0.425)
        let xr = rect.origin.x + (rect.width * 0.85)
        let yd = rect.origin.y + (rect.width * 0.825)

        navUpArrow.alpha = 1.0
        navUpArrow.tag = 100
        navUpArrow.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(icon), height: CGFloat(icon))
        navUpArrow.backgroundColor = UIColor.clearColor()

        navLeftArrow.alpha = 1.0
        navLeftArrow.tag = 101
        navLeftArrow.frame = CGRect(x: CGFloat(xl), y: CGFloat(yl) - CGFloat(5), width: CGFloat(icon ), height: CGFloat(icon))
        navLeftArrow.backgroundColor = UIColor.clearColor()

        navRightArrow.alpha = 1.0
        navRightArrow.tag = 102
        navRightArrow.frame = CGRect(x: CGFloat(xr), y: CGFloat(yl), width: CGFloat(icon), height: CGFloat(icon))
        navRightArrow.backgroundColor = UIColor.clearColor()

        navDownArrow.alpha = 1.0
        navDownArrow.tag = 103
        navDownArrow.frame = CGRect(x: CGFloat(xx), y: CGFloat(yd), width: CGFloat(icon), height: CGFloat(icon))
        navDownArrow.backgroundColor = UIColor.clearColor()

        self.addSubview(navUpArrow)
        self.addSubview(navLeftArrow)
        self.addSubview(navRightArrow)
        self.addSubview(navDownArrow)
        if mode == 0  {
            navUpArrow.hidden = true
            navLeftArrow.hidden = true
            navRightArrow.hidden = true
            navDownArrow.hidden = true
        } else {
            if (ComputerRuntimeVariables.NavigationDirection == 3) {

                navUpArrow.hidden = false
                navLeftArrow.hidden = true
                navRightArrow.hidden = true
                navDownArrow.hidden = true
                direction = "please proceed"
            } else if (ComputerRuntimeVariables.NavigationDirection == 2) {

                navUpArrow.hidden = true
                navLeftArrow.hidden = true
                navDownArrow.hidden = true
                navRightArrow.hidden = false
                direction = "please turn right"
            } else if (ComputerRuntimeVariables.NavigationDirection == 1) {

                navLeftArrow.hidden = false
                navUpArrow.hidden = true
                navRightArrow.hidden = true
                navDownArrow.hidden = true
                direction = "please turn left"
            } else if (ComputerRuntimeVariables.NavigationDirection == 4) {

                navLeftArrow.hidden = true
                navUpArrow.hidden = true
                navRightArrow.hidden = true
                navDownArrow.hidden = false
                direction = "please make a legal u turn"
            }

            //Voice navigation has latency
            self.myUtterance = AVSpeechUtterance(string: self.direction)
            self.myUtterance.rate = 0.1
            //self.synth.speakUtterance(self.myUtterance)

        }

    }

    //
    /**
    Top Right

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leTitle: <#leTitle description#>
    - parameter mode:    <#mode description#>
    */
    func addTopRight(rect rect: CGRect, leText: String, leTitle: String, mode: Int) -> Void {

        let w = 70
        let h = 22

        let icon = iconSize

        let xx = (rect.origin.x + rect.width) - (rect.width * 0.08) - CGFloat(w)
        let xxx = (rect.origin.x + rect.width) - (rect.width * 0.08) - CGFloat(icon)
        let yy = rect.origin.y + (rect.width * 0.08)

        let newYpos = (CGFloat(yy) + CGFloat(h))


        topRightNumber.text = leText
        topRightNumber.tag = 270
        topRightNumber.textColor = UIColor.whiteColor()
        topRightNumber.textAlignment = NSTextAlignment.Right
        topRightNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25) // font for BPM 0.0
        topRightNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(270) == nil) {
            self.addSubview(topRightNumber)
        }

        topRightSubNumber.text = leTitle
        topRightSubNumber.tag = 271
        topRightSubNumber.textColor = cs.subNumberText
        topRightSubNumber.textAlignment = NSTextAlignment.Right
        topRightSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10) //font for BPM
        topRightSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos), width: CGFloat(w), height: CGFloat(h))
        if (self.viewWithTag(271) == nil) {
            self.addSubview(topRightSubNumber)
        }

        topRightImage.image = UIImage(named: "heartrate-icon")
        topRightImage.tag = 272
        topRightImage.frame = CGRect(x: CGFloat(xxx), y: CGFloat(yy), width: CGFloat(icon), height: CGFloat(icon))
        if (self.viewWithTag(272) == nil) {
            self.addSubview(topRightImage)
        }


        // add button HeartRate
        HeartrateButton.frame = CGRect(
            x: CGFloat(xxx),
            y: CGFloat(yy),
            width: CGFloat(icon),
            height: CGFloat(icon)
        )
        HeartrateButton.tag = 273
        HeartrateButton.setTitle("", forState: UIControlState.Normal)
        HeartrateButton.addTarget(self, action: "changeUsageModeToHeartRate:", forControlEvents: UIControlEvents.TouchUpInside)
        if (self.viewWithTag(273) == nil) {
            self.addSubview(HeartrateButton)
        }


        if (ComputerRuntimeVariables.UsageMode == 3 || ComputerRuntimeVariables.UsageMode == 10) {
            topRightNumber.hidden = true
            topRightSubNumber.hidden = true
            topRightImage.hidden = false
        } else {
            topRightNumber.hidden = false
            topRightSubNumber.hidden = false
            topRightImage.hidden = true
        }

    }


    /**
    Change Usage Mode

    - parameter sender: <#sender description#>
    */
    func changeUsageModeToHeartRate(sender: UIButton!) {
        ComputerRuntimeVariables.UsageMode = 3
        self.setNeedsDisplay()
    }


    /**
    Bottom Left

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leTitle: <#leTitle description#>
    - parameter mode:    <#mode description#>
    */
    func addBottomLeft(rect rect: CGRect, leText: String, leTitle: String, mode: Int) -> Void {
        let w = 70
        let h = 22

        let icon = iconSize

        let xx = rect.origin.x + (rect.width * 0.08)
        let yy = rect.origin.y + (rect.width * 0.08) + CGFloat(CGRectGetMidY(rect) / 1.35)
        let yyy = rect.origin.y + (rect.width * 0.08) + CGFloat(CGRectGetMidY(rect) / 1.35) - CGFloat((CGFloat(icon) / 7))

        let newYpos = (CGFloat(yy) + CGFloat(h))


        bottomLeftNumber.text = leText
        bottomLeftNumber.tag = 260
        bottomLeftNumber.textColor = UIColor.whiteColor()
        bottomLeftNumber.textAlignment = NSTextAlignment.Left
        bottomLeftNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25) // font for MPH 0.0
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomLeftNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos) - CGFloat(5), width: CGFloat(w), height: CGFloat(h))
        } else {
            bottomLeftNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos), width: CGFloat(w), height: CGFloat(h))
        }
        if (self.viewWithTag(260) == nil) {
            self.addSubview(bottomLeftNumber)
        }

        bottomLeftSubNumber.text = leTitle
        bottomLeftSubNumber.tag = 261
        bottomLeftSubNumber.textColor = cs.subNumberText
        bottomLeftSubNumber.textAlignment = NSTextAlignment.Left
        bottomLeftSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10) //font for MPH
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomLeftSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy) - CGFloat(5), width: CGFloat(w), height: CGFloat(h))
        } else {
            bottomLeftSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        }
        if (self.viewWithTag(261) == nil) {
            self.addSubview(bottomLeftSubNumber)
        }

        bottomLeftImage.image = UIImage(named: "speed-icon")
        bottomLeftImage.tag = 262
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomLeftImage.frame = CGRect(x: CGFloat(xx), y: CGFloat(yyy) - CGFloat(5), width: CGFloat(icon), height: CGFloat(icon))
        } else {
            bottomLeftImage.frame = CGRect(x: CGFloat(xx), y: CGFloat(yyy), width: CGFloat(icon), height: CGFloat(icon))
        }
        if (self.viewWithTag(262) == nil) {
            self.addSubview(bottomLeftImage)
        }

        // add button Speed
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            speedButton.frame = CGRect(
                x: CGFloat(xx),
                y: CGFloat(yyy) - CGFloat(5),
                width: CGFloat(icon),
                height: CGFloat(icon)
            )
        } else {
            speedButton.frame = CGRect(
                x: CGFloat(xx),
                y: CGFloat(yyy),
                width: CGFloat(icon),
                height: CGFloat(icon)
            )
        }
        speedButton.tag = 263
        speedButton.setTitle("", forState: UIControlState.Normal)
        speedButton.addTarget(self, action: "changeUsageModeToSpeed:", forControlEvents: UIControlEvents.TouchUpInside)
        if (self.viewWithTag(263) == nil) {
            self.addSubview(speedButton)
        }


        if (ComputerRuntimeVariables.UsageMode == 1 || ComputerRuntimeVariables.UsageMode == 10) {
            bottomLeftNumber.hidden = true
            bottomLeftSubNumber.hidden = true
            bottomLeftImage.hidden = false
        } else {
            bottomLeftNumber.hidden = false
            bottomLeftSubNumber.hidden = false
            bottomLeftImage.hidden = true
        }
    }

    /**
    <#Description#>

    - parameter sender: <#sender description#>
    */
    func changeUsageModeToSpeed(sender: UIButton!) {
        ComputerRuntimeVariables.UsageMode = 1
        self.setNeedsDisplay()
    }


    /**
    Bottom Right

    - parameter rect:    <#rect description#>
    - parameter leText:  <#leText description#>
    - parameter leTitle: <#leTitle description#>
    - parameter mode:    <#mode description#>
    */
    func addBottomRight(rect rect: CGRect, leText: String, leTitle: String, mode: Int) -> Void {
        let w = 70
        let h = 22

        let icon = iconSize

        let xx = (rect.origin.x + rect.width) - (rect.width * 0.08) - CGFloat(w)
        let yy = rect.origin.y + (rect.width * 0.08) + CGFloat(CGRectGetMidY(rect) / 1.35)

        // for the icon
        let xxx = (rect.origin.x + rect.width) - (rect.width * 0.08) - CGFloat(icon)
        let yyy = rect.origin.y + (rect.width * 0.08) + CGFloat(CGRectGetMidY(rect) / 1.35) - CGFloat((CGFloat(icon) / 7))

        let newYpos = (CGFloat(yy) + CGFloat(h))

        bottomRightNumber.tag = 253
        bottomRightNumber.text = leText
        bottomRightNumber.textColor = UIColor.whiteColor()
        bottomRightNumber.textAlignment = NSTextAlignment.Right
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomRightNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)// font for watts 0.0
            bottomRightNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos) - CGFloat(5), width: CGFloat(w), height: CGFloat(h))
        } else {
            bottomRightNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25)// font for watts 0.0
            bottomRightNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(newYpos), width: CGFloat(w), height: CGFloat(h))
        }
        if (self.viewWithTag(253) == nil) {
            self.addSubview(bottomRightNumber)
        }


        bottomRightSubNumber.text = leTitle
        bottomRightSubNumber.tag = 252
        bottomRightSubNumber.textColor = cs.subNumberText
        bottomRightSubNumber.textAlignment = NSTextAlignment.Right
        bottomRightSubNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10)// font for watts
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomRightSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy) - CGFloat(5), width: CGFloat(w), height: CGFloat(h))
        } else {
            bottomRightSubNumber.frame = CGRect(x: CGFloat(xx), y: CGFloat(yy), width: CGFloat(w), height: CGFloat(h))
        }
        if (self.viewWithTag(252) == nil) {
            self.addSubview(bottomRightSubNumber)
        }


        bottomRightImage.tag = 251
        bottomRightImage.image = UIImage(named: "power-icon")
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            bottomRightImage.frame = CGRect(x: CGFloat(xxx), y: CGFloat(yyy) - CGFloat(5), width: CGFloat(icon), height: CGFloat(icon))
        } else {
            bottomRightImage.frame = CGRect(x: CGFloat(xxx), y: CGFloat(yyy), width: CGFloat(icon), height: CGFloat(icon))
        }
        if (self.viewWithTag(251) == nil) {
            self.addSubview(bottomRightImage)
        }

        // add button Power
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            powerButton.frame = CGRect(
                x: CGFloat(xxx),
                y: CGFloat(yyy) - CGFloat(5),
                width: CGFloat(icon),
                height: CGFloat(icon))
        } else {
            powerButton.frame = CGRect(
                x: CGFloat(xxx),
                y: CGFloat(yyy),
                width: CGFloat(icon),
                height: CGFloat(icon))

        }

        //powerButton.backgroundColor = UIColor.yellowColor()
        powerButton.setTitle("", forState: UIControlState.Normal)
        powerButton.tag = 250
        powerButton.addTarget(self, action: "changeUsageModetoPower:", forControlEvents: UIControlEvents.TouchUpInside)
        if (self.viewWithTag(250) == nil) {
            self.addSubview(powerButton)
        }


        if (ComputerRuntimeVariables.UsageMode == 2 || ComputerRuntimeVariables.UsageMode == 10) {
            bottomRightNumber.hidden = true
            bottomRightSubNumber.hidden = true
            bottomRightImage.hidden = false
        } else {
            bottomRightNumber.hidden = false
            bottomRightSubNumber.hidden = false
            bottomRightImage.hidden = true
        }
    }

    /**
    <#Description#>

    - parameter sender: <#sender description#>
    */
    func changeUsageModetoPower(sender: UIButton!) {
        ComputerRuntimeVariables.UsageMode = 2
        self.setNeedsDisplay()
    }

    /**
    Init

    - parameter frame: <#frame description#>

    - returns: <#return value description#>
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.lemond.cc"

        cl.delegate = self

        if (AppState.currentRuntime > 0) {
            // Attempt to load the state
            // Need to see if the app was just opened ...

            // Restart the screen
            if (ComputerRuntimeVariables.ButtonMode != 0 && ComputerRuntimeVariables.HasStarted) {

                startTime = ComputerRuntimeVariables.StartTime
                pauseStart = ComputerRuntimeVariables.PauseTime
                pauseBuffer = ComputerRuntimeVariables.PauseBuffer

                if (ComputerRuntimeVariables.ButtonMode == 2) {
                    if !pauseTimer.valid {
                        pauseTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updatePauseTime", userInfo: nil, repeats: true)
                    }
                }

                if !timer.valid {
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
                }

            }
        }
    }

    /**
    Init

    - parameter aDecoder: <#aDecoder description#>

    - returns: <#return value description#>
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /**
    <#Description#>

    - parameter ctx:    <#ctx description#>
    - parameter leRect: <#leRect description#>
    */
    func drawBottomLines(ctx ctx: CGContextRef, leRect: CGRect) {

        let startX = leRect.origin.x + (leRect.width * 0.08)
        let endX = leRect.origin.x + leRect.width - (leRect.width * 0.08)

        let midY = CGRectGetMidY(leRect)
        let midYafterElevation = CGRectGetMidY(leRect) + (leRect.height * 0.15)
        let midYafterDataPoints = CGRectGetMidY(leRect) + (leRect.height * 0.24)

        let horizonYstart = CGRectGetMidY(leRect) + (leRect.height * 0.15)
        var horizonYend = CGRectGetMidY(leRect) + (leRect.height * 0.25)

        // Elevation Y
        CGContextSetLineWidth(ctx, 2.0)
        CGContextSetStrokeColorWithColor(ctx, cs.subNumberText.CGColor)
        CGContextMoveToPoint(ctx, startX, midY)
        CGContextAddLineToPoint(ctx, endX, midY)
        CGContextStrokePath(ctx)

        uiChart.frame = CGRect(
            x: CGFloat(leRect.origin.x + (leRect.width * 0.08)),
            y: CGFloat(CGRectGetMidY(leRect) + 28),
            width: CGFloat(leRect.width) - ((leRect.width * 0.08) * 2),
            height: abs(CGFloat(CGRectGetMidY(leRect) + 28) - midYafterElevation)
        )
        var cc1 = CGFloat(leRect.origin.x)
        var cy1 = CGRectGetMidY(leRect)
        var cw1 = leRect.width
        var ch1 = leRect.height / 40
        //var xx = (rect.origin.x + rect.width) - (rect.width * 0.08) - CGFloat(w)
        // println("chart parameters x:\(cc1) y:\(cy1) w:\(cw1) h:\(ch1)")
        uiChart.alpha = 1
        uiChart.backgroundColor = cs.background
        uiChart.tag = 3005
        if (self.viewWithTag(3005) == nil) {
            self.addSubview(uiChart)
        }

        // Just below the Elevation Chart
        CGContextMoveToPoint(ctx, startX, midYafterElevation)
        CGContextAddLineToPoint(ctx, endX, midYafterElevation)
        CGContextStrokePath(ctx)

        // After Data Points
        CGContextMoveToPoint(ctx, startX, midYafterDataPoints)
        CGContextAddLineToPoint(ctx, endX, midYafterDataPoints)
        CGContextStrokePath(ctx)

        // Horizontal Line
        CGContextMoveToPoint(ctx, CGRectGetMidX(leRect), horizonYstart)
        CGContextAddLineToPoint(ctx, CGRectGetMidX(leRect), midYafterDataPoints)
        CGContextStrokePath(ctx)
    }

    /**
    <#Description#>

    - parameter rect: <#rect description#>
    */
    func addBottomTextBoxes(rect rect: CGRect) {

        let w = 150
        let h = 44
        let dh = 44

        let icon = iconSize

        let xx = rect.origin.x + (rect.width * 0.08)
        let xN = rect.origin.x + (rect.width * 0.25)
        let yy = rect.origin.y + CGRectGetMidY(rect) - (rect.width * 0.010)
        let yyTimeMiles = rect.origin.y + (rect.height) - (rect.height * 0.26)

        let rotate = CGAffineTransformMakeRotation(CGFloat(M_PI_2))

        let yyMiles = (rect.height * 0.15) + CGRectGetMidY(rect)
        let xxTimeOfDay = rect.origin.x + CGRectGetMidX(rect) + (rect.width * 0.04)


        // Elevation Number
        elevationNumber.tag = 208
        elevationNumber.text = "ELEVATION"
        elevationNumber.textColor = cs.subNumberText
        elevationNumber.textAlignment = NSTextAlignment.Left
        elevationNumber.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 14)
        elevationNumber.frame = CGRect(
            x: rect.origin.x + (rect.width / 2 * 0.70),
            y: CGFloat(yy),
            width: CGFloat(w),
            height: CGFloat(h))
        if (self.viewWithTag(208) == nil) {
            self.addSubview(elevationNumber)
        }

        // Add elevation reading
        elevationReading.tag = 209
        if(ComputerRuntimeVariables.Altitude != nil){
            if (ComputerRuntimeVariables.MetricMode == 0) {
                // - converting meters to feet
                let milesalti = (ComputerRuntimeVariables.Altitude) * 3.28084
                elevationReading.text = String(format: "%.1f", milesalti)
            } else if (ComputerRuntimeVariables.MetricMode == 1){
                elevationReading.text = String(format: "%.1f", ComputerRuntimeVariables.Altitude)
            }
        }else{
            elevationReading.text = "0.0"
        }
        elevationReading.textColor = UIColor.whiteColor()
        elevationReading.textAlignment = NSTextAlignment.Right
        elevationReading.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 18)
        elevationReading.frame = CGRect(
            x: rect.origin.x + (rect.width  * 0.795),
            y: CGFloat(yy),
            width: CGFloat(50),
            height: CGFloat(h))
        if (self.viewWithTag(209) == nil) {
            self.addSubview(elevationReading)
        }

        // bottomRightNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 20)// font for watts 0.0
        //add elevation new number to left most
        if(ComputerRuntimeVariables.Grade != nil){
            eleNewNumber.text = String(format: "%.1f", ComputerRuntimeVariables.Grade)
        }else{
            eleNewNumber.text = "0.0"
        }
        eleNewNumber.tag = 309
        eleNewNumber.text = "0.0"
        eleNewNumber.textColor = UIColor.whiteColor()
        eleNewNumber.textAlignment = NSTextAlignment.Left
        eleNewNumber.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 18)
        eleNewNumber.frame = CGRect(
            x: rect.origin.x + (rect.width  * 0.08),
            y: rect.origin.y + (rect.height * 0.495),
            width: CGFloat(50),
            height: CGFloat(h))
        self.addSubview(eleNewNumber)


        descTotalMilesUp.tag = 207
        if (ComputerRuntimeVariables.MetricMode == 0) {
            descTotalMilesUp.text = "MILES"
        } else if (ComputerRuntimeVariables.MetricMode == 1) {
            descTotalMilesUp.text = "KM"
        }
        descTotalMilesUp.textColor = cs.subNumberText
        descTotalMilesUp.textAlignment = NSTextAlignment.Center
        descTotalMilesUp.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))

        if (DeviceType.IS_IPHONE_6) {
            descTotalMilesUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            descTotalMilesUp.frame = CGRect(
                x: rect.origin.x + rect.width / 2 * 0.54,
                y: CGRectGetMidY(rect) + (rect.height * 0.13),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_5) {
            descTotalMilesUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 11)
            descTotalMilesUp.frame = CGRect(
                x: rect.origin.x + rect.width / 2 * 0.48,
                y: CGRectGetMidY(rect) + (rect.height * 0.12),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_6P) {
            descTotalMilesUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 13)
            descTotalMilesUp.frame = CGRect(
                x: rect.origin.x + rect.width / 2 * 0.6,
                y: CGRectGetMidY(rect) + (rect.height * 0.14),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
            descTotalMilesUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10)
            descTotalMilesUp.frame = CGRect(
                x: rect.origin.x + rect.width / 2 * 0.49,
                y: CGRectGetMidY(rect) + (rect.height * 0.108),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        }

        if (self.viewWithTag(207) == nil) {
            self.addSubview(descTotalMilesUp)
        }

        if (ComputerRuntimeVariables.CumulativeDistance > 0) {
            if (ComputerRuntimeVariables.MetricMode == 0) {
                totalMiles.text = String(format: "%.2f", ComputerRuntimeVariables.CumulativeDistance)
            } else if (ComputerRuntimeVariables.MetricMode == 1) {
                totalMiles.text = String(format: "%.2f", ComputerRuntimeVariables.CumulativeDistance * 1.609)
            }
        } else {
            totalMiles.text = "00.0"
        }
        totalMiles.tag = 206
        totalMiles.textColor = UIColor.whiteColor()
        totalMiles.textAlignment = NSTextAlignment.Left
        if (DeviceType.IS_IPHONE_6P) {
            totalMiles.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 42)
        } else {
            totalMiles.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25)
        }
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            totalMiles.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.20),
                y: CGFloat(yyMiles) - CGFloat(5),
                width: CGFloat(w),
                height: CGFloat(h + 20)
            )
        } else {
            totalMiles.frame = CGRect(
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.20),
                y: CGFloat(yyMiles),
                width: CGFloat(w),
                height: CGFloat(h + 20)
            )
        }
        if (self.viewWithTag(206) == nil) {
            self.addSubview(totalMiles)
        }

        // Total Of Day
        descTimeOfDayUp.text = "CALS"
        descTimeOfDayUp.tag = 205
        descTimeOfDayUp.textColor = cs.subNumberText
        descTimeOfDayUp.textAlignment = NSTextAlignment.Center
        descTimeOfDayUp.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))

        if (DeviceType.IS_IPHONE_6) {
            descTimeOfDayUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            descTimeOfDayUp.frame = CGRect(
                x: rect.origin.x + CGRectGetMidX(rect) + (rect.width * 0.20),
                y: CGRectGetMidY(rect) + (rect.height * 0.13),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_5) {
            descTimeOfDayUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            descTimeOfDayUp.frame = CGRect(
                x: rect.origin.x + CGRectGetMidX(rect) + (rect.width * 0.17),
                y: CGRectGetMidY(rect) + (rect.height * 0.12),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_6P) {
            descTimeOfDayUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 13)
            descTimeOfDayUp.frame = CGRect(
                x: rect.origin.x + CGRectGetMidX(rect) + (rect.width * 0.23),
                y: CGRectGetMidY(rect) + (rect.height * 0.14),
                width: CGFloat(w),
                height: CGFloat(h + 40))
        } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
            descTimeOfDayUp.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 10)
            descTimeOfDayUp.frame = CGRect(
                x: rect.origin.x + CGRectGetMidX(rect) + (rect.width * 0.17),
                y: CGRectGetMidY(rect) + (rect.height * 0.11),
                width: CGFloat(w),
                height: CGFloat(h + 40))

        }

        if (self.viewWithTag(205) == nil) {
            self.addSubview(descTimeOfDayUp)
        }


        if (ComputerRuntimeVariables.CumulativeCalories > 0) {
            timeOfDay.text = String(format: "%.2f", ComputerRuntimeVariables.CumulativeCalories)
        } else {
            timeOfDay.text = "00.0"
        }
        timeOfDay.tag = 204
        timeOfDay.textColor = UIColor.whiteColor()
        timeOfDay.textAlignment = NSTextAlignment.Left
        if (DeviceType.IS_IPHONE_6P) {
            timeOfDay.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 42)
        } else {
            timeOfDay.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 25)
        }
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            timeOfDay.frame = CGRect(
                //x: CGFloat(100) + (CGFloat(w) / CGFloat(1.6)),
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.65),
                y: CGFloat(yyMiles) - CGFloat(2.5),
                width: CGFloat(w),
                height: CGFloat(h + 20))

        } else {
            timeOfDay.frame = CGRect(
                //x: CGFloat(100) + (CGFloat(w) / CGFloat(1.6)),
                x: CGFloat(rect.origin.x) + CGFloat(rect.width * 0.65),
                y: CGFloat(yyMiles),
                width: CGFloat(w),
                height: CGFloat(h + 20))
        }
        if (self.viewWithTag(204) == nil) {
            self.addSubview(timeOfDay)
        }

        // Description Time!
        descTime.text = "TIME"
        descTime.tag = 203
        descTime.textColor = cs.subNumberText
        descTime.numberOfLines = 1
        descTime.textAlignment = NSTextAlignment.Left
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            descTime.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
        } else {
            descTime.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 14)
        }
        if (DeviceType.IS_IPHONE_6) {
            descTime.frame = CGRect(
                //x: CGFloat(xxTimeOfDay)+CGFloat(rect.width/2*0.25),
                x: CGFloat(xxTimeOfDay) + CGFloat(rect.width / 2 * 0.45),
                //y: CGFloat(yyTimeMiles),
                y: (rect.origin.y) + (rect.height * 0.76),
                width: CGFloat(w + 50),
                height: CGFloat(dh + 60))
        } else if (DeviceType.IS_IPHONE_5) {
            descTime.frame = CGRect(
                //x: CGFloat(xxTimeOfDay)+CGFloat(rect.width/2*0.25),
                x: CGFloat(xxTimeOfDay) + CGFloat(rect.width / 2 * 0.5),
                //y: CGFloat(yyTimeMiles),
                y: (rect.origin.y) + (rect.height * 0.768),
                width: CGFloat(w + 50),
                height: CGFloat(dh + 60))
        } else if (DeviceType.IS_IPHONE_6P) {
            descTime.frame = CGRect(
                //x: CGFloat(xxTimeOfDay)+CGFloat(rect.width/2*0.25),
                x: CGFloat(xxTimeOfDay) + CGFloat(rect.width / 2 * 0.5),
                //y: CGFloat(yyTimeMiles),
                y: (rect.origin.y) + (rect.height * 0.768),
                width: CGFloat(w + 50),
                height: CGFloat(dh + 60))
        } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
            descTime.frame = CGRect(
                //x: CGFloat(xxTimeOfDay)+CGFloat(rect.width/2*0.25),
                x: CGFloat(xxTimeOfDay) + CGFloat(rect.width / 2 * 0.5),
                //y: CGFloat(yyTimeMiles),
                y: (rect.origin.y) + (rect.height * 0.75),
                width: CGFloat(w + 50),
                height: CGFloat(dh + 60))
        }

        if (self.viewWithTag(203) == nil) {
            self.addSubview(descTime)
        }

        // println("Currnet Runtime Variable -- CurrentTime, status: \(ComputerRuntimeVariables.CurrentTime)")
        if (ComputerRuntimeVariables.CurrentTime != nil) {
            // ||
            time.text = ComputerRuntimeVariables.CurrentTime
        } else {
            time.text = "00:00:00"
        }


        time.textColor = UIColor.whiteColor()

        time.textAlignment = NSTextAlignment.Left
        time.tag = 202
        if (DeviceType.IS_IPHONE_6) {
            time.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 52) // UnitedSansSemiCond-Heavy
            time.frame = CGRect(
                x: CGFloat(xN),
                y: CGFloat(yyTimeMiles) + CGFloat(12),
                width: CGFloat(abs(rect.width - ((rect.width * 0.08) * 2))),
                height: CGFloat(dh + 20)
            )
        } else if (DeviceType.IS_IPHONE_5) {
            time.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 52) // UnitedSansSemiCond-Heavy
            time.frame = CGRect(
                x: CGFloat(rect.origin.x) + (rect.width * 0.21),
                y: CGFloat(yyTimeMiles) + CGFloat(12),
                width: CGFloat(abs(rect.width - ((rect.width * 0.08) * 2))),
                height: CGFloat(dh + 20)
            )
        } else if (DeviceType.IS_IPHONE_6P) {
            time.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 62) // UnitedSansSemiCond-Heavy
            time.frame = CGRect(
                x: CGFloat(rect.origin.x) + (rect.width * 0.24),
                y: CGFloat(yyTimeMiles) + CGFloat(12),
                width: CGFloat(abs(rect.width - ((rect.width * 0.08) * 2))),
                height: CGFloat(dh + 20)
            )
        } else if (DeviceType.IS_IPHONE_4_OR_LESS) {
            time.font = UIFont(name: "UnitedSansSemiCond-Heavy", size: 50) // UnitedSansSemiCond-Heavy
            time.frame = CGRect(
                x: CGFloat(rect.origin.x) + (rect.width * 0.22),
                y: CGFloat(yyTimeMiles) + CGFloat(4),
                width: CGFloat(abs(rect.width - ((rect.width * 0.08) * 2))),
                height: CGFloat(dh + 20)
            )
        }
        if (self.viewWithTag(202) == nil) {
            self.addSubview(time)
        }

        // Now add our buttons
    }

    /**
    Add the bottom toggle button

    - parameter rect: <#rect description#>
    */
    func addMainButton(rect rect: CGRect) {

        pulseAnimation.duration = 1.0;
        pulseAnimation.toValue = NSNumber(float: 0.3);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;

        //var h = 80.0
        //var w1 = rect.width * 0.2 // init - completly ignore
        //w1 = rect.width - CGFloat(rect.width * 0.2456) // Old, big square
        var w1 = rect.width - CGFloat(rect.width * 0.70)
        let w2 = rect.width - CGFloat(rect.width * 0.82)

        // var h = abs(  (CGFloat(rect.origin.x) + w1) - rect.width )

        let x = abs((rect.width / 2) - (w2 / 2))
        //var y = rect.height - CGFloat( w1 * 0.80 ) //Old. height
        let y = rect.height - CGFloat(w2)

        //println("Adding StartBox -> w \(w1) y\(y)")
        startStopButton.frame = CGRect(
            x: CGFloat(x),
            y: CGFloat(y) - CGFloat(rect.width * 0.06),
            width: CGFloat(w2),
            height: CGFloat(w2)
        )
        if (ComputerRuntimeVariables.ButtonMode == 0) {
            // this is Stopped
            startStopButton.titleLabel?.adjustsFontSizeToFitWidth = true
            startStopButton.setTitle("START", forState: UIControlState.Normal)
            startStopButton.layer.removeAllAnimations()
            startStopButton.backgroundColor = cs.barCadence
            startStopButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            pulseAnimationStarted = false
        } else if (ComputerRuntimeVariables.ButtonMode == 1) {
            // Runing
            startStopButton.titleLabel?.adjustsFontSizeToFitWidth = true
            startStopButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
            startStopButton.setTitle("PAUSE", forState: UIControlState.Normal)
            startStopButton.layer.removeAllAnimations()
            startStopButton.backgroundColor = cs.topNav
            pulseAnimationStarted = false
        } else if (ComputerRuntimeVariables.ButtonMode == 2) {
            // Pause
            startStopButton.titleLabel?.adjustsFontSizeToFitWidth = true
            //                if(DeviceType.IS_IPHONE_6){
            //            startStopButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size:12)
            //            }
            //            else if(DeviceType.IS_IPHONE_5){
            //                startStopButton.titleLabel?.font = UIFont (name: "UnitedSansSemiExt-Bold", size:10)
            //            }

            startStopButton.setTitle("RESUME", forState: UIControlState.Normal)
            if (pulseAnimationStarted == false) {
                startStopButton.layer.addAnimation(pulseAnimation, forKey: nil)
                pulseAnimationStarted = true
            }
            startStopButton.backgroundColor = cs.heartrate
        } else if (ComputerRuntimeVariables.ButtonMode == 3) {
            // On Resume
            // Actually stay the same
            pulseAnimationStarted = false
        }
        startStopButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startStopButton.layer.cornerRadius = 0.5 * CGFloat(w2)
        startStopButton.tag = 201
        startStopButton.addTarget(self, action: "startStopComputer:", forControlEvents: UIControlEvents.TouchUpInside)
        if (self.viewWithTag(201) == nil) {
            self.addSubview(startStopButton)
        }
    }

    /*
    <#Description#>
    TODO need to finish

    :param: rect <#rect description#>
    */
    func addStopButton(rect rect: CGRect) {

        //var h = 80.0
        //var w1 = rect.width - CGFloat(rect.width * 0.25)
        //w1 = rect.width - CGFloat(rect.width * 0.2456)
        let w1 = rect.width - CGFloat(rect.width * 0.82)
        var h = abs((CGFloat(rect.origin.x) + w1) - rect.width)
        let y = rect.height - CGFloat(w1)

        //println("Adding StartBox -> w \(w1) y\(y)")
        stopTimerButton.frame = CGRect(
            x: CGFloat(CGFloat(rect.origin.x) + CGFloat(rect.width * 0.085)),
            y: CGFloat(y) - CGFloat(rect.width * 0.06),
            width: CGFloat(w1),
            height: CGFloat(w1)
        )
        stopTimerButton.setTitle("STOP", forState: UIControlState.Normal)
        stopTimerButton.tag = 224
        stopTimerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        stopTimerButton.backgroundColor = cs.heartrate
        stopTimerButton.layer.cornerRadius = 0.5 * CGFloat(w1)
        stopTimerButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 14)
        stopTimerButton.addTarget(self, action: "stopRunningComputer:", forControlEvents: UIControlEvents.TouchUpInside)

        if (ComputerRuntimeVariables.ButtonMode == 2) {
            stopTimerButton.alpha = 1
        } else {
            stopTimerButton.alpha = 0
        }

        if (self.viewWithTag(224) == nil) {
            self.addSubview(stopTimerButton)
        }
    }



    /**
    Add settings button at the bottom

    - parameter rect: <#rect description#>
    */
    func addSettingButton(rect rect: CGRect) {
        let w1 = rect.width - CGFloat(rect.width * 0.2456)
        let h = abs((CGFloat(rect.origin.x) + w1) - rect.width)
        let newWidth = abs((CGFloat(rect.origin.x) + w1) - rect.width)
        let y = rect.height - CGFloat(h)

        SettingButtonImage.frame = CGRect(
            x: CGFloat(rect.width * 0.83),
            y: CGFloat(rect.height * 0.89),
            width: CGFloat(newWidth - 60),
            height: CGFloat(newWidth - 60)
        )
        SettingButtonImage.contentMode = .ScaleAspectFit
        SettingButtonImage.alpha = 0.7
        SettingButtonImage.tag = 220
        SettingButtonImage.image = UIImage(named: "settingCog")



        // Button Trigger
        SettingButtonBack.frame = CGRect(x: CGFloat(rect.width * 0.77),
            y: CGFloat(y),
            width: CGFloat(newWidth),
            height: CGFloat(newWidth)
        )
        SettingButtonBack.tag = 221
        SettingButtonBack.addTarget(self, action: "showSettings:", forControlEvents: UIControlEvents.TouchUpInside)


        if (self.viewWithTag(220) == nil) {
            self.addSubview(SettingButtonImage)
        }
        if (self.viewWithTag(221) == nil) {
            self.addSubview(SettingButtonBack)
        }
    }


    /**
    pass onto our delegate

    - parameter sender: <#sender description#>
    */
    func showSettings(sender: UIButton!) {

        ComputerRuntimeVariables.StartTime = startTime
        ComputerRuntimeVariables.PauseTime = pauseStart
        ComputerRuntimeVariables.PauseBuffer = pauseBuffer

        self.delegate?.settingspopup()
    }

    /**
    <#Description#>

    - parameter sender: <#sender description#>
    */
    @IBAction func startStopComputer(sender: UIButton!) {

        if (ComputerRuntimeVariables.ButtonMode == 0) {
            // start the timer
            ComputerRuntimeVariables.HasStarted = true

            // Setup color
            startStopButton.backgroundColor = cs.topNav
            ComputerRuntimeVariables.ButtonMode = 1
            if (stopTimerButton.alpha == 1) {
                UIView.animateWithDuration(1.0, animations: {
                    self.stopTimerButton.alpha = 0;
                })
            }
            // The Start Timer
            if !timer.valid {
                // println("Initializing start timer")
                timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
                startTime = NSDate.timeIntervalSinceReferenceDate()
            }

        } else if (ComputerRuntimeVariables.ButtonMode == 1) {
            // pause the timer
            startStopButton.setTitle("RESUME", forState: UIControlState.Normal)
            startStopButton.layer.addAnimation(pulseAnimation, forKey: nil)
            startStopButton.backgroundColor = cs.heartrate
            if (stopTimerButton.alpha == 0) {
                UIView.animateWithDuration(1.0, animations: {
                    self.stopTimerButton.alpha = 1
                })
            }
            ComputerRuntimeVariables.ButtonMode = 2

            // The pausing timer
            if !pauseTimer.valid {
                pauseTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updatePauseTime", userInfo: nil, repeats: true)
            }
            pauseStart = NSDate.timeIntervalSinceReferenceDate()

        } else if (ComputerRuntimeVariables.ButtonMode == 2) {
            // restart the timer
            startStopButton.setTitle("PAUSE", forState: UIControlState.Normal)
            startStopButton.layer.removeAllAnimations()
            startStopButton.backgroundColor = cs.topNav
            if (stopTimerButton.alpha == 1) {
                UIView.animateWithDuration(1.0, animations: {
                    self.stopTimerButton.alpha = 0
                })
            }
            ComputerRuntimeVariables.ButtonMode = 1

            // Append to the buffer
            let leCurTime = NSDate.timeIntervalSinceReferenceDate()
            let elapsedPauseTime: NSTimeInterval = leCurTime - pauseStart
            pauseBuffer += elapsedPauseTime
        } else if (ComputerRuntimeVariables.ButtonMode == 3) {
            // Almost literally do nothing!
            ComputerRuntimeVariables.ButtonMode = 2
        }
    }

    /**
    Stop the Computer

    - parameter sender: <#sender description#>
    */
    func stopRunningComputer(sender: UIButton!) {
        //        println("Caught STOP Trigger")

        // Clear local notification
        UIApplication.sharedApplication().cancelLocalNotification(localNotification)
        ComputerRuntimeVariables.ButtonMode = 3
        self.setNeedsDisplay()

        dispatch_async(dispatch_get_main_queue(), {
            ComputerRuntimeVariables.ButtonMode = 3
            self.setNeedsDisplay()
        });

    }


    /**
    Update the time
    */
    func updateTime() {

        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var pauseTime = 0.00

        var elapsedPauseTime: NSTimeInterval = 0.00
        if (ComputerRuntimeVariables.ButtonMode == 2 || ComputerRuntimeVariables.ButtonMode == 3) {
            elapsedPauseTime = currentTime - pauseStart
        }

        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime - pauseBuffer - elapsedPauseTime
        ComputerRuntimeVariables.elapsedTime = elapsedTime

        // Our hours Calcuation.
        let hours = UInt8(elapsedTime / 3600)
        elapsedTime -= (NSTimeInterval(hours) * 3600)

        // calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)

        // calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)

        // find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)

        // println(" min \(minutes) sec \(seconds) ")
        var theCurrentTime = "";
        if (hours == 0) {
            theCurrentTime = String(format: "%02d:%02d.%02d", minutes, seconds, fraction)
        } else {
            theCurrentTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }

        time.text = theCurrentTime
        // time.textAlignment = NSTextAlignment.Left
        self.delegate?.startstopTimer(theCurrentTime)
        ComputerRuntimeVariables.CurrentTime = theCurrentTime
        if (ComputerRuntimeVariables.ButtonMode == 1) {
            if (updateElevationChartFrequency == 1) {
                updateElevationChart()
                updateElevationChartFrequency = 0
            }
            updateElevationChartFrequency++
        }
    }


    /**
    Update the Pause Time
    */
    func updatePauseTime() {
        if (ComputerRuntimeVariables.ButtonMode == 2) {
            let currentTime = NSDate.timeIntervalSinceReferenceDate()
            var elapsedPauseTime: NSTimeInterval = currentTime - pauseStart
        }
    }



    /**
    Calculate Degree 2 Radian

    - parameter a: Float which is a Degree

    - returns: a Float which is a Radian
    */
    func degree2radian(a: CGFloat) -> CGFloat {
        let b = CGFloat(M_PI) * a / 180
        return b
    }


    /**
    <#Description#>

    - parameter sides:      <#sides description#>
    - parameter x:          <#x description#>
    - parameter y:          <#y description#>
    - parameter radius:     <#radius description#>
    - parameter adjustment: <#adjustment description#>

    - returns: <#return value description#>
    */
    func circleCircumferencePoints(sides: Int, x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat = 0) -> [CGPoint] {
        let angle = degree2radian(360 / CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i) + degree2radian(adjustment))
            let ypo = cy - r * sin(angle * CGFloat(i) + degree2radian(adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i--;
        }
        return points
    }

    /**
    Draw Second Marker

    - parameter ctx:    <#ctx description#>
    - parameter x:      <#x description#>
    - parameter y:      <#y description#>
    - parameter radius: <#radius description#>
    - parameter color:  <#color description#>
    - parameter size:   <#size description#>
    */
    func drawSecondMarker(ctx ctx: CGContextRef, x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor, size: Float) {
        // generate a path
        let path = CGPathCreateMutable()
        // move to starting point on edge of circle
        CGPathMoveToPoint(path, nil, radius, y)
        // draw line of required length
        CGPathAddLineToPoint(path, nil, x, y)
        // close subpath
        CGPathCloseSubpath(path)
        // add the path to the context
        CGContextAddPath(ctx, path)
        // set the line width
        CGContextSetLineWidth(ctx, CGFloat(size))
        // set the line color
        CGContextSetStrokeColorWithColor(ctx, color.CGColor)
        // draw the line
        CGContextStrokePath(ctx)
    }

    /**
    <#Description#>

    - parameter ctx:    <#ctx description#>
    - parameter x:      <#x description#>
    - parameter y:      <#y description#>
    - parameter radius: <#radius description#>
    - parameter color:  <#color description#>
    - parameter number: <#number description#>
    */
    func drawSecondNumericalMarker(ctx ctx: CGContextRef, x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor, number: Double, inc: Int) {
        // generate a path
        let letterWidth:CGFloat = 20.0
        let letterHeight:CGFloat = 15.0

        // Sanitize the number
        let leNumber = Int(number)
        // println(" \(number) \(leNumber) ")

        let textRect = CGRectMake(x, y, letterWidth, letterHeight)
        let textTextContent = NSString(string: "\(leNumber)")

        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left

        let textFontAttributes = [NSFontAttributeName: UIFont(name: "UnitedSansSemiCond-Heavy", size: 10)!, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height


        // Move the pointer forward, calculating the
        // new percentage of travel along the path

        // save our state
        CGContextSaveGState(ctx)
        if(ComputerRuntimeVariables.UsageMode == 2){
            if (DeviceType.IS_IPHONE_6){
                // this is for rendering power circleview numbers correctly
                if(number < 99){
                    if(number == 0 ){
                        CGContextTranslateCTM(ctx, -(44 + radius), -(radius - 68))
                        CGContextRotateCTM(ctx,CGFloat(-0.5))
                    }
                    else {
                        CGContextTranslateCTM(ctx, -(46 + radius), -(radius - 68))
                        CGContextRotateCTM(ctx,CGFloat(-0.5))
                    }
                }else{
                    CGContextTranslateCTM(ctx, -(47 + radius), -(radius - 71))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            }else if (DeviceType.IS_IPHONE_6P){
                if(number < 99) {
                    if (number == 0){
                        CGContextTranslateCTM(ctx,  -(49 + radius), -(radius - 77))
                        CGContextRotateCTM(ctx,CGFloat(-0.5))
                    }else{
                        CGContextTranslateCTM(ctx,  -(50 + radius), -(radius - 77))
                        CGContextRotateCTM(ctx,CGFloat(-0.5))
                    }
                } else{
                    CGContextTranslateCTM(ctx, -(52 + radius), -(radius - 79))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            }else{
                if(number < 99){
                    CGContextTranslateCTM(ctx, -(38 + radius), -(radius - 58))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }else{
                    CGContextTranslateCTM(ctx, -(40 + radius), -(radius - 60))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            }
        }else {
            // this is for rendering speed circle view propoerly
            if (DeviceType.IS_IPHONE_6){
                if(number < 6) {
                    CGContextTranslateCTM(ctx,  -(44 + radius), -(radius - 68))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                } else{
                    CGContextTranslateCTM(ctx, -(45.5 + radius), -(radius - 70))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            }else if (DeviceType.IS_IPHONE_6P){
                if(number < 6) {
                    CGContextTranslateCTM(ctx,  -(50 + radius), -(radius - 75))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                } else{
                    CGContextTranslateCTM(ctx, -(51 + radius), -(radius - 77))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            } else {
                if(number < 6) {
                    CGContextTranslateCTM(ctx, -(37 + radius), -(radius - 57))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
                else{
                    CGContextTranslateCTM(ctx, -(39 + radius), -(radius - 59))
                    CGContextRotateCTM(ctx,CGFloat(-0.5))
                }
            }
        }
        CGContextClipToRect(ctx, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)

        CGContextRestoreGState(ctx)
    }

    /**
    Update the elevation chart
    */
    func updateElevationChart(){
        // Clear

        // Sanitize the Elevation Points for Memory, et al.
        if( ComputerRuntimeVariables.ElevationPoints.count > 350 ){
            let ev = Array(ComputerRuntimeVariables.ElevationPoints.reverse())
            let evp = ev[0..<350]
            // Re-Store array
            ComputerRuntimeVariables.ElevationPoints = Array(Array(evp).reverse())
        }
        // Normalize the output
        uiChart.points = ComputerRuntimeVariables.ElevationPoints
        uiChart.refesh()

        // updates the elevation
        if(ComputerRuntimeVariables.Altitude != nil){
            if (ComputerRuntimeVariables.MetricMode == 0) {
                // - converting meters to feet
                let milesalti = (ComputerRuntimeVariables.Altitude) * 3.28084
                elevationReading.text = String(format: "%.1f", milesalti)
            } else if (ComputerRuntimeVariables.MetricMode == 1){
                elevationReading.text = String(format: "%.1f", ComputerRuntimeVariables.Altitude)
            }
        }
    }


    // /////////////
    // Save Menu's
    // /////////////

    /**
    Show Save Menu

    - parameter rect: <#rect description#>
    */
    func showSaveMenu(rect rect: CGRect) {
        if (ComputerRuntimeVariables.ButtonMode == 3) {
            let x1 = rect.origin.x
            let y1 = rect.origin.y


            if (self.viewWithTag(1001) == nil) {
                overlayBackground = SaveWorkoutBackground()
                overlayBackground.frame = CGRect(
                    x: CGFloat(x1),
                    y: CGFloat(y1),
                    width: CGFloat(rect.width),
                    height: CGFloat(rect.height)
                )
                overlayBackground.tag = 1001
                overlayBackground.backgroundColor = UIColor.clearColor()
                self.addSubview(overlayBackground)
            }

            if (self.viewWithTag(1002) == nil) {
                containerBox = SaveWorkoutOverlay()
                containerBox.frame = CGRect(
                    x: CGFloat(x1) + CGFloat(rect.width * 0.08),
                    y: CGFloat((rect.width / 4) * 3),
                    width: CGFloat(rect.width) - CGFloat(rect.width * 0.16),
                    height: CGFloat(rect.height / 4) + CGFloat((rect.height / 4) * 0.2)
                )
                containerBox.backgroundColor = UIColor.whiteColor()
                containerBox.tag = 1002
                self.addSubview(containerBox)
            }


            if (self.viewWithTag(1003) == nil) {
                discardButton = DiscardWorkoutButton()
                discardButton.frame = CGRect(
                    x: CGFloat(x1) + (rect.width * 0.1),
                    y: CGFloat((rect.width / 4) * 3) + CGFloat((rect.width / 4) * 0.05),
                    width: CGFloat(rect.width) - CGFloat(rect.width * 0.2),
                    height: CGFloat(60)
                )
                discardButton.tag = 1003
                discardButton.addTarget(self, action: "discardWorkout:", forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(discardButton)
                // TODO Finish
            }

            if (self.viewWithTag(1004) == nil) {
                saveButton = SaveWorkoutButton()
                saveButton.frame = CGRect(
                    x: CGFloat(x1) + (rect.width * 0.1),
                    y: CGFloat((rect.width / 4) * 3) + CGFloat((rect.width / 4) * 0.75),
                    width: CGFloat(rect.width) - CGFloat(rect.width * 0.2),
                    height: CGFloat(60)
                )
                saveButton.tag = 1004
                saveButton.addTarget(self, action: "saveWorkout:", forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(saveButton)
                // TODO Finish
            }


            if (self.viewWithTag(1005) == nil) {
                returnButton = ReturnWorkoutButton()
                returnButton.frame = CGRect(
                    x: CGFloat(x1) + (rect.width * 0.1),
                    y: CGFloat((rect.width / 4) * 3) + CGFloat((rect.width / 4) * 1.45),
                    width: CGFloat(rect.width) - CGFloat(rect.width * 0.2),
                    height: CGFloat(60)
                )
                returnButton.addTarget(self, action: "returnToMain:", forControlEvents: UIControlEvents.TouchUpInside)
                returnButton.tag = 1005
                self.addSubview(returnButton)
            }
        }
    }

    /**
    Remove from Save Menu

    - parameter rect: The current screen Rect
    */
    func removeSaveMenu(rect rect: CGRect) {
        var bg: UIView!
        if (ComputerRuntimeVariables.ButtonMode != 3 && overlayBackground != nil && self.viewWithTag(1001) != nil) {
            //            println("Removing the Options Screen ButtonMode: [\(ComputerRuntimeVariables.ButtonMode)]")
            for i in 1001 ... 1005 {
                bg = self.viewWithTag(i)
                if (bg != nil) {
                    bg!.removeFromSuperview()
                }
            }
        }
    }

    /**
    Return to the Main Screen

    - parameter sender: <#sender description#>
    */
    func returnToMain(sender: UIButton!) {
        ComputerRuntimeVariables.ButtonMode = 2
        // println("Clicking on Return to Main!")

        overlayBackground.alpha = 0
        containerBox.alpha = 0
        discardButton.alpha = 0
        saveButton.alpha = 0
        returnButton.alpha = 0
    }

    /**
    Save the Workout State

    - parameter sender: <#sender description#>
    */
    func saveWorkout(sender: UIButton!){

        //println("Save Workout")

        // Save...
        WatchCoreDataProxy.sharedInstance.saveRide(ComputerRuntimeVariables.OrigDate)

        print("computer controller original date\(ComputerRuntimeVariables.OrigDate)")

        // Compute Averages & Find Peaks
        var rideData = WatchCoreDataProxy.sharedInstance.fetchLocationData(ComputerRuntimeVariables.OrigDate)

        var i = 0
        var p = 0.0
        var c = 0.0
        var s = 0.0
        var h = 0.0

        for cc in rideData {
            var power = cc.valueForKey("power") as! NSNumber
            var speed = cc.valueForKey("speed") as! NSNumber
            var cadence = cc.valueForKey("cadence") as! NSNumber
            var heartrate = cc.valueForKey("heartrate") as! NSNumber

            p += Double(power)
            if(Double(power) > ComputerRuntimeVariables.PowerPeak){
                ComputerRuntimeVariables.PowerPeak = Double(power)
            }

            s += Double(speed)
            if(Double(speed) > ComputerRuntimeVariables.SpeedPeak){
                ComputerRuntimeVariables.SpeedPeak = Double(speed)
            }

            c += Double(cadence)
            if(Double(cadence) > ComputerRuntimeVariables.CadencePeak ){
                ComputerRuntimeVariables.CadencePeak = Double(cadence)
            }

            h += Double(heartrate)
            if(Double(heartrate) > ComputerRuntimeVariables.HeartratePeak ){
                ComputerRuntimeVariables.HeartratePeak = Double(heartrate)
            }
            // Lets inc this up
            i++
        }

        var pAvg = p / Double(i)
        var cAvg = c / Double(i)
        var sAvg = s / Double(i)
        var hAvg = h / Double(i)

        // Saving data!
        WatchCoreDataProxy.sharedInstance.setRideData(
            "",
            time: ComputerRuntimeVariables.elapsedTime ,
            distance: ComputerRuntimeVariables.CumulativeDistance,
            calories: ComputerRuntimeVariables.CumulativeCalories,
            date: ComputerRuntimeVariables.OrigDate,
            metric: 0,
            speedAverage: sAvg,
            speedPeak: ComputerRuntimeVariables.SpeedPeak,
            cadenceAverage: cAvg,
            cadencePeak: ComputerRuntimeVariables.CadencePeak,
            heartRateAverage: hAvg,
            heartRatePeak: ComputerRuntimeVariables.HeartratePeak,
            wattAverage: pAvg,
            wattPeak: ComputerRuntimeVariables.PowerPeak
        )

        // Now reset
        resetWorkoutScreen()
        // refresh
        self.saveWorkoutDelegate?.workoutHasBeenSaved(0)

        // Local notification
        localNotification.alertBody = "How do you feel today?"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 2)
        localNotification.category = "CounterCategory"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

    }

    /**
    Discard Workout

    - parameter sender: <#sender description#>
    */
    func discardWorkout(sender: UIButton!){

        // Just Reset screen.
        resetWorkoutScreen()
    }

    /**
    Reset the workout mode
    */
    func resetWorkoutScreen(){

        // hide
        overlayBackground.alpha = 0
        containerBox.alpha = 0
        discardButton.alpha = 0
        saveButton.alpha = 0
        returnButton.alpha = 0

        // Store variables/ data ...
        ComputerRuntimeVariables.OrigDate = nil
        ComputerRuntimeVariables.CurrentTime = nil
        ComputerRuntimeVariables.CumulativeDistance = 0.0
        ComputerRuntimeVariables.CumulativeCalories = 0.0
        ComputerRuntimeVariables.ButtonMode = 0
        // ComputerRuntimeVariables.UsageMode = 10
        ComputerRuntimeVariables.HasStarted = false
        ComputerRuntimeVariables.StartTime = nil
        ComputerRuntimeVariables.PauseTime = nil
        ComputerRuntimeVariables.PauseBuffer = nil

        ComputerRuntimeVariables.CadencePeak = 0.0
        ComputerRuntimeVariables.CadenceAverage = 0.0
        ComputerRuntimeVariables.PowerPeak = 0.0
        ComputerRuntimeVariables.PowerAverage = 0.0
        ComputerRuntimeVariables.SpeedPeak = 0.0
        ComputerRuntimeVariables.SpeedAverage = 0.0
        ComputerRuntimeVariables.HeartratePeak = 0.0
        ComputerRuntimeVariables.HeartrateAverage = 0.0

        ComputerRuntimeVariables.ElevationPoints = [] // empty

        // Reset computer
        timer.invalidate()
        pauseTimer.invalidate()
        // Clear buffers.
        pauseBuffer = 0.0

        //self.ComputerController(actionSheetController, animated:true, completion: nil)
        // Reset Buttons
        startStopButton.setTitle("START", forState: UIControlState.Normal)
        startStopButton.layer.removeAllAnimations()
        startStopButton.backgroundColor = cs.barCadence

        if (stopTimerButton.alpha == 1) {
            UIView.animateWithDuration(1.0, animations: {
                self.stopTimerButton.alpha = 0
            })
        }

        self.setNeedsDisplay()

    }


    // Heart Rate / Candece Sensor

    func distanceDidChange(cadence: CadenceConnector!, totalDistance: Double!) {
        dispatch_async(dispatch_get_main_queue(), {

        });
    }

    func speedDidChange(cadence: CadenceConnector!, speed: Double!) {
        let speedString = NSString(format: "%.2f", speed)
        dispatch_async(dispatch_get_main_queue(), {

        });
    }

    func crankFrequencyDidChange(cadence: CadenceConnector!, crankRevolutionsPerMinute: Double!) {
        let crankRevolutionsPerMinuteString = NSString(format: "%.2f", crankRevolutionsPerMinute)
        dispatch_async(dispatch_get_main_queue(), {

        });
    }

    func heartRateDidChange(heartbeat: HeartRateConnector!, heartRate: UInt8!) {
        dispatch_async(dispatch_get_main_queue(), {

        });
    }

}
