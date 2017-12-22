//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var passGenerator: GuestPassGenerator!
    let guest = ClassicGuest()
    let maintenanceWorker = Maintenance(firstName: "Zack", lastName: "Chesney", address: "20 Millers", state: "NH", city: "Rochester", zipCode: "03868")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(maintenanceWorker.entrantType)
        print(guest.entrantType)
        tryToCreateGuest()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tryToCreateGuest() {
        do {
            try passGenerator.createPass(guest: guest)
        } catch let error {
            print("ZACK \(error)")
        }
    }

}

