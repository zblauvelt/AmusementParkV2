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
    case InvalidData(Descripion: String)
}

protocol Guest {
    var entrantType: EntrantType { get set }
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
    var discount: [Discount] { get }
    var firstName: String { get set }
    var lastName: String { get set }
    var address: String { get set }
    var state: String { get set }
    var city: String { get set }
    var zipCode: String { get set }
}

protocol PassGenerator {
    var guestTypes: [EntrantType] { get }
    
    func createPass(guest: Guest) throws
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
    var firstName: String = ""
    var lastName: String = ""
    var address: String = ""
    var state: String = ""
    var city: String = ""
    var zipCode: String = ""
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
        discount = [.food(10), .merchandise(20)]
        entrantType = .vipGuest
    }
}

class FreeChildGuest: GuestType {
    var age: Int
    
    init(age: Int) {
        self.age = age
        super.init()
        entrantType = .freeChild
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

class GuestPassGenerator: PassGenerator {
    let guestTypes: [EntrantType] = [.classicGuest, .foodService, .freeChild, .maintenance, .manager, .vipGuest, .rideService]
    var fName = ""
    var lName = ""
    var address = ""
    var city = ""
    var state = ""
    var zipCode = ""
    
    
    func createPass(guest: Guest) throws {
        print("\(guest.address)")
        
        if guestTypes.contains(guest.entrantType) {
            print("Have a great time in the Park! \nAccess: \(guest.areaAccess)\nRide Access: \(guest.rideAccess)\n Discount\(guest.discount)")
        } else {
            print("Shoudn't get here")
            if guest.firstName != "" {
                fName = guest.firstName
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your first name.")
            }
            if guest.lastName != "" {
                lName = guest.lastName
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your last name.")
            }
            if guest.address != "" {
                address = guest.address
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your address")
            }
            if guest.city != "" {
                city = guest.city
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your city")
            }
            if guest.state != "" {
                state = guest.state
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your state")
            }
            if guest.zipCode != "" {
                zipCode = guest.zipCode
            } else {
                throw GuestError.InvalidData(Descripion: "Please provide your zip code")
            }
         print("Welcome to the Park \(fName)!\nYou have access to \(guest.areaAccess)")
        }
        
    }
    

}



















