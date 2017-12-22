//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let guest = ClassicGuest()
    let maintenanceWorker = Maintenance(firstName: "Zack", lastName: "Chesney", address: "20 Millers", state: "NH", city: "Rochester", zipCode: "03868")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPasses()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPasses() {
        do {
            try guest.createPass()
            try maintenanceWorker.createPass()
        } catch GuestError.invalidFirstName(Description: "Please provide first name.") {
            print("Please provide first name")
        } catch GuestError.invalidLastName(Description: "Please provide last name") {
            print("Please provide last name.")
        } catch GuestError.invalidAddress(Description: "Please provide address.") {
            print("Please provide address.")
        } catch GuestError.invalidCity(Description: "Please provide city.") {
            print("Please provide city.")
        } catch GuestError.invalidState(Description: "Please provide state.") {
            print("Please provide state.")
        } catch GuestError.invalidZipCode(Description: "Please provide zip code") {
            print("Please provide zip code.")
        } catch GuestError.ageRequirementNotMet(Description: "Child does not meet age requirement") {
            print("Child does not meet age requirement.")
        } catch let error {
            fatalError("\(error)")
        }
        
    }

}

