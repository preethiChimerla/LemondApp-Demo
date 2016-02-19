//
//  APIControllerProtocol.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 5/31/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation

/**
*  API Controller Delgate
*/

protocol APIControllerProtocol {
    func didRecieveLoginResult(results: Int)
    func didRecieveRegisterResult(results: Int, message: String)
}

