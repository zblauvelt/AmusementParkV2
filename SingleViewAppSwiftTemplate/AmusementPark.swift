//
//  AmusementPark.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Zachary Blauvelt on 12/21/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum EntrantType: String {
    case classicGuest = "Classic Guest"
    case vipGuest = "VIP Guest"
    case freeChild = "Free Child"
    case foodService = "Food Service Employee"
    case rideService = "Ride Service Employee"
    case maintenance = "Maintenance Employee"
    case manager = "Park Manager"
}

enum AreaAccess: String {
    case amusementPark = "Amusement Park"
    case kitchen = "Kitchen"
    case rideControl = "Ride Control"
    case maintenance = "Maintenance"
    case officeArea = "Office Area"
}

enum RideAccess: String {
    case allRides = "Access to All Rides"
    case skipAllLines = "Skip All Lines"
}

enum Discount {
    case food
    case merchandise
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
    var foodDiscount: Int { get }
    var merchandiseDiscount: Int { get }
    
    func pass() throws -> Guest

}

class GuestType: Guest {
    
    var entrantType: EntrantType = .classicGuest
    var areaAccess: [AreaAccess] = [.amusementPark]
    var rideAccess: [RideAccess] = [.allRides]
    var foodDiscount = 0
    var merchandiseDiscount = 0
    
    func pass() throws -> Guest {
        print("Welcome to the Park!\nPark Pass: \(self.entrantType.rawValue)")
        return self
    }
}

class ClassicGuest: GuestType {
    override init() {
        super.init()
    }
    
}

class VIPGuest: GuestType {
    override init() {
        super.init()
        rideAccess.append(.skipAllLines)
        entrantType = .vipGuest
        foodDiscount = 10
        merchandiseDiscount = 20
    }

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
    
    override func pass() throws -> Guest {
        let childPass = FreeChildGuest(age: self.age)
        let isFree = checkAge()
        if isFree == true {
            let guestPass = childPass
            print("Welcome to the Park!\nPark Pass: \(self.entrantType.rawValue)")
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
    var foodDiscount: Int = 15
    var merchandiseDiscount: Int = 25
    
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
    
    func pass() throws -> Guest {
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
        print("Welcome to the Park \(self.firstName)!\nPark Pass: \(self.entrantType.rawValue)")
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





















