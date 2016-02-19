//
//  HeartrateConnector.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol HeartRateDelegate {

    func heartRateDidChange(heartbeat: HeartRateConnector!, heartRate: UInt8!)
}

class HeartRateConnector: GernericConnector {

    var HEARTBEAT_SERVICE = CBUUID(string: "180D")
    var HEARTBEAT_MEASUREMENT = CBUUID(string: "2A37")

    var delegate: HeartRateDelegate?

    init() {
        super.init(services: [HEARTBEAT_SERVICE])
    }

    /**
    <#Description#>
    
    - parameter peripheral: <#peripheral description#>
    - parameter error:      <#error description#>
    */
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        print("didDiscoverServices:error:\(error)")
        if (error != nil) {
            for service in peripheral.services! {
                if service.UUID == HEARTBEAT_SERVICE {
                    peripheral.discoverCharacteristics([HEARTBEAT_SERVICE], forService: service as! CBService)
                    print("discoverCharacteristics")
                }
            }
        }
    }


    /**
    <#Description#>
    
    - parameter peripheral: <#peripheral description#>
    - parameter service:    <#service description#>
    - parameter error:      <#error description#>
    */
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        print("didDiscoverCharacteristicsForService:\(service) error:\(error)")
        if (error != nil) {
            if service.UUID == HEARTBEAT_SERVICE {
                for characteristic in service.characteristics! {
                    if (characteristic as! CBCharacteristic).UUID == HEARTBEAT_MEASUREMENT {
                        peripheral.setNotifyValue(true, forCharacteristic: characteristic as! CBCharacteristic);
                    }
                }
            }
        }
    }

    /**
    <#Description#>
    
    - parameter peripheral:     <#peripheral description#>
    - parameter characteristic: <#characteristic description#>
    - parameter error:          <#error description#>
    */
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        print("didUpdateValueForCharacteristic:\(characteristic) error:\(error)")
        if (error != nil && characteristic.UUID == HEARTBEAT_MEASUREMENT) {

            var heartRate: UInt8 = 0
            characteristic.value!.getBytes(&heartRate, range: NSMakeRange(1, 1))


            delegate?.heartRateDidChange(self, heartRate: heartRate)
        }
    }
}