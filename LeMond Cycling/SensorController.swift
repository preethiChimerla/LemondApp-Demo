//
//  SensorController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit


class SensorController: UITableViewController, UITextFieldDelegate { // UITableViewDelegate, ,  UITableViewDataSource


    @IBOutlet var HeartRate: UITextField!
    @IBOutlet var Cadence: UITextField!
    @IBOutlet var PwerCrankSet: UITextField!
    @IBOutlet var SpeedSensor: UITextField!
    @IBOutlet var StationaryTrainer: UITextField!


}