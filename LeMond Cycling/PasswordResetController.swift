//
//  PasswordResetController.swift
//  LeMond Cycling
//
//  Created by preethi Reddy on 6/5/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class PasswordResetController: UITableViewController, UITextFieldDelegate { // , UITableViewDelegate, UITableViewDataSource {

    var store = StoreUserDefaults()

    @IBOutlet var oldPasswordText: UITextField!
    @IBOutlet var ConfirmPasswordText: UITextField!
    @IBOutlet var NewPasswordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func OldPassword(sender: AnyObject) {

    }

    @IBAction func NewPassword(sender: AnyObject) {
    }

    @IBAction func ConfirmPassword(sender: AnyObject) {
    }


}