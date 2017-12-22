//
//  AmusementPark.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Zachary Blauvelt on 12/21/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum EntrantType: String {
    case classicGuest
    case vipGuest
    case freeChild
    case foodService
    case rideService
    case maintenance
    case manager
}

enum AreaAccess: String {
    case amusementPark
    case kitchen
    case rideControl
    case maintenance
    case officeArea
}

enum RideAccess: String {
    case allRides
    case skipAllLines
}

enum Discount {
    case food(Int)
    case merchandise(Int)
}

enum GuestError: Error {
    case invalidFirstName(Description: String)
    case invalidLastName(Description: String)
    case invalidAddress(Description: String)
    case invalidCity(Description: String)
    case invalidState(Description: String)
    case invalidZipCode(Description: String)
    case ageRequirementNotMet(Description: String)
}

protocol Guest {
    var entrantType: EntrantType { get }
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
    var discount: [Discount] { get }
    
    func createPass() throws -> Guest

}

protocol Swipe {
    var guest: Guest { get }
    
    func checkAccess(guest: Guest) throws
}

class GuestType: Guest {
    
    var entrantType: EntrantType = .classicGuest
    var areaAccess: [AreaAccess] = [.amusementPark]
    var rideAccess: [RideAccess] = [.allRides]
    var discount: [Discount] = [.food(0), .merchandise(0)]
    
    func createPass() throws -> Guest {
        print("Welcome to the Park!\nPark Pass: \(self.entrantType) \nPark Access: \(self.areaAccess) \nRide Access: \(self.discount) /nDiscounts: \(self.discount)")
        return self
    }
}

class ClassicGuest: GuestType {
    override init() {
        super.init()
    }
    
    /*override func createPass() throws -> Guest {
        let guestPass = ClassicGuest()
        return guestPass
    }*/
}

class VIPGuest: GuestType {
    override init() {
        super.init()
        rideAccess.append(.skipAllLines)
        discount = [.food(10), .merchandise(20)]
        entrantType = .vipGuest
    }
    /*override func createPass() throws -> Guest {
        let guestPass = VIPGuest()
        return guestPass
    }*/
}

class FreeChildGuest: GuestType {
    var age: Int
    
    init(age: Int) {
        self.age = age
        super.init()
        entrantType = .freeChild
    }
    
    func checkAge() -> Bool {
        let freeAgeLimit = 5
        if self.age < freeAgeLimit {
            return true
        } else {
            return false
        }
    }
    
    override func createPass() throws -> Guest {
        let childPass = FreeChildGuest(age: self.age)
        let isFree = checkAge()
        if isFree == true {
            let guestPass = childPass
            print("Welcome to the Park!\nPark Pass: \(self.entrantType) \nPark Access: \(self.areaAccess) \nRide Access: \(self.discount) /nDiscounts: \(self.discount)")
            return guestPass
        } else {
            throw GuestError.ageRequirementNotMet(Description: "Sorry, your child is above the allowed age")
        }
    }
    
}

class EmployeeType: Guest {

    var entrantType: EntrantType = .foodService
    var areaAccess: [AreaAccess] = [.amusementPark]
    var rideAccess: [RideAccess] = [.allRides]
    var discount: [Discount] = [.food(15), .merchandise(25)]
    var firstName: String
    var lastName: String
    var address: String
    var state: String
    var city: String
    var zipCode: String
    
    init(firstName: String, lastName: String, address: String, state: String, city: String, zipCode: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.state = state
        self.city = city
        self.zipCode = zipCode
    }
    
    func createPass() throws -> Guest {
        guard firstName != "" else {
            throw GuestError.invalidFirstName(Description: "Please provide a first name.")
        }
        guard lastName != "" else {
            throw GuestError.invalidLastName(Description: "Please provide last name.")
        }
        guard address != "" else {
            throw GuestError.invalidAddress(Description: "Please provide an address.")
        }
        guard state != "" else {
            throw GuestError.invalidState(Description: "Please provide a state.")
        }
        guard city != "" else {
            throw GuestError.invalidCity(Description: "Please provide a city.")
        }
        guard zipCode != "" else {
            throw GuestError.invalidZipCode(Description: "Please provide a zip code")
        }
        print("Welcome to the Park \(self.firstName)!\nPark Pass: \(self.entrantType) \nPark Access: \(self.areaAccess) \nRide Access: \(self.discount) /nDiscounts: \(self.discount)")
        return self
    }
}

class FoodService: EmployeeType {
    override init(firstName: String, lastName: String, address: String, state: String, city: String, zipCode: String) {
        super.init(firstName: firstName, lastName: lastName, address: address, state: state, city: city, zipCode: zipCode)
        areaAccess.append(.kitchen)
    }
}

class RideService: EmployeeType {
    override init(firstName: String, lastName: String, address: String, state: String, city: String, zipCode: String) {
        super.init(firstName: firstName, lastName: lastName, address: address, state: state, city: city, zipCode: zipCode)
        areaAccess.append(.rideControl)
        entrantType = .rideService
    }
}

class Maintenance: EmployeeType {
    override init(firstName: String, lastName: String, address: String, state: String, city: String, zipCode: String) {
        super.init(firstName: firstName, lastName: lastName, address: address, state: state, city: city, zipCode: zipCode)
        areaAccess = [.amusementPark, .kitchen, .maintenance, .rideControl]
        entrantType = .maintenance
    }
}

class Manager: EmployeeType {
    override init(firstName: String, lastName: String, address: String, state: String, city: String, zipCode: String) {
        super.init(firstName: firstName, lastName: lastName, address: address, state: state, city: city, zipCode: zipCode)
        areaAccess = [.amusementPark, .kitchen, .maintenance, .rideControl, .officeArea]
        entrantType = .manager
    }
}





















