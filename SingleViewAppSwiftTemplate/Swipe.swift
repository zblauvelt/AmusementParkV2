        //
        //  Swipe.swift
        //  SingleViewAppSwiftTemplate
        //
        //  Created by Zachary Blauvelt on 12/23/17.
        //  Copyright © 2017 Treehouse. All rights reserved.
        //

        import Foundation

        //Swipe methods

extension ViewController {


    enum Result: String {
        case granted = "ACCESS GRANTED"
        case denied = "ACCESS DENIED"
        }

    func swipeAreaAccess(guest: Guest, swipeAccess: AreaAccess) {

        func checkAccess() {
            if guest.areaAccess.contains(swipeAccess) {
                print(Result.granted.rawValue)
            } else {
                print(Result.denied.rawValue)
            }
        }
        switch swipeAccess {
            case .amusementPark:
                checkAccess()
            case .kitchen:
                checkAccess()
            case .maintenance:
                checkAccess()
            case .officeArea:
                checkAccess()
            case .rideControl:
                checkAccess()

            }
        }


    func swipeRideAccess(guest: Guest, swipeAccess: RideAccess) {
        func checkAccess() {
            if guest.rideAccess.contains(swipeAccess) {
                print(Result.granted.rawValue)
            } else {
                print(Result.denied.rawValue)
            }
        }
        switch swipeAccess {
        case .allRides:
            checkAccess()
        case .skipAllLines:
            checkAccess()
        }
    }

    func swipeDiscount(guest: Guest, swipeDiscount: Discount) {
        switch swipeDiscount {
        case .food:
            print("Food Discount: \(guest.foodDiscount)")
        case .merchandise:
            print("Merchandise Discount: \(guest.merchandiseDiscount)")
        }
        
    }





}












