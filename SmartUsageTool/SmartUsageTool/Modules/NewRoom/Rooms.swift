//
//  Rooms.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 17.04.2024.
//

import Foundation

enum Room: String, CaseIterable {
    case other = "Other"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case bedroom = "Bedroom"
    case bathroom = "Bathroom"
    case diningRoom = "Dining Room"
    case homeOffice = "Home Office"
    case laundryRoom = "Laundry Room"
    case garage = "Garage"
    case basement = "Basement"
    case attic = "Attic"
    case guestRoom = "Guest Room"
    case nursery = "Nursery"
    case playroom = "Playroom"
    case library = "Library"
    case studyRoom = "Study Room"
    case conservatory = "Conservatory"
    case mudroom = "Mudroom"
    case sunroom = "Sunroom"
    case pantry = "Pantry"
    case hallway = "Hallway"
    case foyer = "Foyer"
    case den = "Den"
    case gym = "Gym"
    case homeTheater = "Home Theater"
    case workshop = "Workshop"
    case storageRoom = "Storage Room"
    
    var localizedName: String {
        switch self {
        case .other:
            return Localize.other
        case .livingRoom:
            return Localize.livingRoom
        case .kitchen:
            return Localize.kitchen
        case .bedroom:
            return Localize.bedroom
        case .bathroom:
            return Localize.bathroom
        case .diningRoom:
            return Localize.diningRoom
        case .homeOffice:
            return Localize.homeOffice
        case .laundryRoom:
            return Localize.laundryRoom
        case .garage:
            return Localize.garage
        case .basement:
            return Localize.basement
        case .attic:
            return Localize.attic
        case .guestRoom:
            return Localize.guestRoom
        case .nursery:
            return Localize.nursery
        case .playroom:
            return Localize.playroom
        case .library:
            return Localize.library
        case .studyRoom:
            return Localize.studyRoom
        case .conservatory:
            return Localize.conservatory
        case .mudroom:
            return Localize.mudroom
        case .sunroom:
            return Localize.sunroom
        case .pantry:
            return Localize.pantry
        case .hallway:
            return Localize.hallway
        case .foyer:
            return Localize.foyer
        case .den:
            return Localize.den
        case .gym:
            return Localize.gym
        case .homeTheater:
            return Localize.homeTheater
        case .workshop:
            return Localize.workshop
        case .storageRoom:
            return Localize.storageRoom
        }
    }
	
	var caseName: String {
		return String(describing: self)
	}
}
