//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var passAccepted = false
    //MARK: Test cases to Generate Pass
    /// Test case to create Guest
    let guest = ClassicGuest()
    /// Test case to create succussful Employee
    let maintenanceWorker = Maintenance(firstName: "Zack", lastName: "Chesney", address: "20 Millers", state: "NH", city: "Rochester", zipCode: "03868")
    /// Test case for Error Handling
    let foodEmployee = FoodService(firstName: "", lastName: "", address: "", state: "", city: "", zipCode: "")
    /// Test case to fail child over 5. Change initialized Int to test fail or success.
    let childOne = FreeChildGuest(age: 4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Takes a Guest instance to generate the pass. Pass in one of the above guest to test.
        getGuestPass(guestPass: childOne)
        //Test case for Area Access. Put in guest and swipe accesses area - result printed in console
        swipeAreaAccess(guest: maintenanceWorker, swipeAccess: .officeArea)
        swipeRideAccess(guest: guest, swipeAccess: .skipAllLines)
        swipeDiscount(guest: foodEmployee, swipeDiscount: .food)
       
    }


    
    
    
    
    
    
    
    
    
    func getGuestPass(guestPass: Guest) {
        do {
            try _ = guestPass.pass()
            passAccepted = true
            print("\(guestPass.entrantType)")

        } catch GuestError.invalidFirstName {
            print("Please provide first name.")
        } catch GuestError.invalidLastName {
            print("Please provide last name.")
        } catch GuestError.invalidAddress {
            print("Please provide address.")
        } catch GuestError.invalidCity {
            print("Please provide city.")
        } catch GuestError.invalidState {
            print("Please provide state.")
        } catch GuestError.invalidZipCode {
            print("Please provide zip code.")
        } catch GuestError.ageRequirementNotMet {
            print("Child does not meet age requirement.")
        } catch let error {
            fatalError("\(error)")
        }
        
    }


    
    
    
    
}

