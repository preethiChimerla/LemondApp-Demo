//
//  ProfileController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/3/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit


class ProfileController: UITableViewController, UITextFieldDelegate{  // , UITableViewDelegate, UITableViewDataSource 

    var store = StoreUserDefaults()

    @IBOutlet var prefferedNameText: UITextField!
    @IBOutlet var FirstNameText: UITextField!
    @IBOutlet var LastNameText: UITextField!


    /**
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentPrefferedName = store.prefferedName!
        let currentFirstName = store.FirstName!
        let currentLastName = store.LastName!

        prefferedNameText.text = currentPrefferedName
        FirstNameText.text = currentFirstName
        LastNameText.text = currentLastName
    }

    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func prefferedNameChanged(sender: AnyObject) {
        store.prefferedName = prefferedNameText.text
    }

    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func FrstName(sender: AnyObject) {

        store.FirstName = FirstNameText.text
    }

    /**
    <#Description#>
    
    - parameter sender: <#sender description#>
    */
    @IBAction func LastName(sender: AnyObject) {
        store.LastName = LastNameText.text
    }

}