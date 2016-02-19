//
//  BikeController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class BikeController: UITableViewController, UITextFieldDelegate{ // , UITableViewDelegate, UITableViewDataSource 

    let store = StoreUserDefaults()

    let WheelTypeData = ["Standard Wheel Size", "Deep Dished Size", "Full Dished Size"]

    @IBOutlet var BikeWeightSlider: UISlider!
    @IBOutlet var BikeWtLabel: UILabel!

    @IBOutlet var TirePressureSlider: UISlider!
    @IBOutlet var TirePressureLabel: UILabel!

    @IBOutlet weak var wheelSizeSegmentedSelection: UISegmentedControl!
    @IBOutlet weak var wheelTypeSegmentedSelection: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        let currentBikeWeight = store.UserBikeWeight
        let currentTirePressure = store.UserTirePressure

        let currentWheelSize = store.UserWheelSize
        let currentWheelType = store.UserwheelType

        BikeWeightSlider.value = (currentBikeWeight as NSString).floatValue
        BikeWtLabel.text = "\(currentBikeWeight) Lbs"


        TirePressureSlider.value = (currentTirePressure as NSString).floatValue
        TirePressureLabel.text = "\(currentTirePressure) PSI"

        wheelSizeSegmentedSelection.selectedSegmentIndex = (currentWheelSize as NSString).integerValue
        wheelTypeSegmentedSelection.selectedSegmentIndex = (currentWheelType as NSString).integerValue
    }

    @IBAction func BikeWtSlider(sender: AnyObject) {
        let cb = Int(BikeWeightSlider.value)
        BikeWtLabel.text = "\(cb) Lbs"
        store.UserBikeWeight = "\(cb)"
    }


    @IBAction func TirePressureSlider(sender: AnyObject) {
        let cs = Int(TirePressureSlider.value)
        TirePressureLabel.text = "\(cs) PSI"
        store.UserTirePressure = "\(cs)"
    }

    @IBAction func wheelSizeSelected(sender: AnyObject) {
        store.UserWheelSize = "\(wheelSizeSegmentedSelection.selectedSegmentIndex)"
    }

    @IBAction func wheelTypeSelected(sender: AnyObject) {
        store.UserwheelType = "\(wheelTypeSegmentedSelection.selectedSegmentIndex)"
    }
}