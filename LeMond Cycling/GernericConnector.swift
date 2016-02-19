//
//  GernericConnector.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/9/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import CoreBluetooth

class GernericConnector: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {

    var central: CBCentralManager!
    var currentPeripheral: CBPeripheral?
    var services: [CBUUID]!

    init(services: [CBUUID]) {
        super.init()
        self.services = services
        self.central = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case .PoweredOn:
            central.scanForPeripheralsWithServices(services, options: nil)
            print("starting scan for \(services)")
        default:
            print("not powered on")
        }
    }

    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String:AnyObject], RSSI: NSNumber) {

        print("didDiscoverPeripheral \(peripheral) advertisementData: \(advertisementData)")

        if let current = currentPeripheral {
            //can we do this prettier?
            print("we´re allready connected to \(current)")
        } else {
            currentPeripheral = peripheral;
            central.connectPeripheral(peripheral, options: nil);
        }
    }

    func centralManager(central: CBCentralManager!, didRetrieveConnectedPeripherals peripherals: [AnyObject]!) {
        print("didRetrieveConnectedPeripherals peripherals:\(peripherals)")
    }

    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didFailToConnectPeripheral \(peripheral) error:\(error)")
        self.currentPeripheral = nil
    }

    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didDisconnectPeripheral \(peripheral) error:\(error)")
        self.currentPeripheral = nil
    }

    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("didConnectPeripheral " + peripheral.name!)
        peripheral.delegate = self
        peripheral.discoverServices(services)
    }


}