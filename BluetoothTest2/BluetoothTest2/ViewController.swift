//
//  ViewController.swift
//  BluetoothTest2
//
//  Created by Robin Reinhardt on 27.08.20.
//  Copyright © 2020 Robin Reinhardt. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var myPeripheral: CBPeripheral!
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var devicesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CoreBluetooth beim AppStart mit starten
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    

    // Status der BluetoothEinstellungen abfragen
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var msg = ""
        switch (central.state){
            case .poweredOff:
                msg = "Bluetooth ist ausgeschaltet"
            case .poweredOn:
                msg = "Bluetooth ist eingeschaltet"
               // manager.scanForPeripherals(withServices: nil, options: nil)
            case .unsupported:
                msg = "Bluetooth nicht verfügbar"
        default: break
        }
        print("Status: \(msg)")
    }

    
    // BluetoothGeräte entdecken und deren Namen ausgeben
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Name: \(String(peripheral.name ?? ""))")
        print("UUID: \(peripheral.identifier)")
        print("Beschreibung: \(peripheral.description)")
        print("RSSI: \(RSSI.intValue)")
        print("\n")
        
        devicesTextView.text = devicesTextView.text
            + "\n Name: \(String(peripheral.name ?? "")) \n"
            + " UUID: \(peripheral.identifier)\n"
            + " RSSI: \(RSSI.intValue)\n"
    }
    
    
    // Auf Button reagieren
    @IBAction func scanButtonTabbed(_ sender: Any) {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        print ("Scan gestartet")
        
    }
    
    
    @IBAction func stopButtonTabbed(_ sender: Any) {
        centralManager.stopScan()
        print ("Scan gestoppt")
    }
    
}

