//
//  BioController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit


class BioController: UITableViewController, UITextFieldDelegate { // , UITableViewDataSource   UITableViewDelegate


    var store = StoreUserDefaults()

    @IBOutlet weak var gender: UISegmentedControl!

    // Age Slider
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageText: UILabel!

    // Height Slider
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var heightText: UILabel!

    // Weight Slider
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightText: UILabel!

    @IBOutlet var setGender: UISegmentedControl!

    @IBAction func GenderChange(sender: AnyObject) {

        if (gender.selectedSegmentIndex == 1) {

        }


    }
    /**
    Our Loader
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentAge = store.UserAge
        let currentHeight = store.UserHeight
        let currentWeight = store.UserWeight
        let currentGender = store.UserGender

        // Assigned
        ageSlider.minimumValue = 0
        ageSlider.maximumValue = 100

        heightSlider.minimumValue = 2
        heightSlider.maximumValue = 8

        weightSlider.minimumValue = 20
        weightSlider.maximumValue = 450

        // ReApply on Load
        ageSlider.value = (currentAge as NSString).floatValue
        ageText.text = currentAge

        heightSlider.value = (currentHeight as NSString).floatValue
        heightText.text = convertDecimalToImperialHeight((currentHeight as NSString).floatValue)

        weightSlider.value = (currentWeight as NSString).floatValue
        weightText.text = "\(currentWeight) Lbs"
        //println("Gender [\(currentGender)]")
        gender.selectedSegmentIndex = (currentGender as NSString).integerValue
    }

    /**
    Age Slider
    
    - parameter sender:
    */
    @IBAction func ageSliderChange(sender: AnyObject) {
        if (ageSlider?.value != nil) {
            let sc = Int(ageSlider.value)
            ageText.text = "\(sc)"
            store.UserAge = "\(sc)"
        }
    }

    /**
    Height Slider
    
    - parameter sender: <#sender description#>
    */
    @IBAction func heightSliderChange(sender: AnyObject) {

        heightText.text = convertDecimalToImperialHeight(heightSlider.value)
        store.UserHeight = "\(heightSlider.value)"
    }

    /**
    Weight Slider
    
    - parameter sender: <#sender description#>
    */
    @IBAction func wieghtSliderChange(sender: AnyObject) {
        let sc = Int(weightSlider.value)
        weightText.text = "\(sc) Lbs"
        store.UserWeight = "\(sc)"
    }

    /**
    Set the Gender Selection
    
    - parameter sender: <#sender description#>
    */
    @IBAction func genderSelectionChanged(sender: AnyObject) {

        store.UserGender = "\(gender.selectedSegmentIndex)"
    }


    /**
    Convert to a float to Imperial Format
    
    - parameter height: Should be a float, such as 6.323
    
    - returns: A string, formated as 6ft 3in
    */
    func convertDecimalToImperialHeight(height: Float) -> String {
        let feet = Int(height)
        let fraction = height - Float(feet)
        let inches = Int(12.0 * fraction)
        return "\(feet)ft \(inches)in"
    }


}