//
//  RoomType.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 01.04.2024.
//

import Foundation
import SwiftUI

enum RoomType: String, Codable {
    case kitchen, bathroom, bedroom, livingRoom, other
    
    static func checkBy(name: String) -> RoomType {
        let lowercasedName = name.lowercased()
        switch lowercasedName {
        case Localize.kitchen.lowercased():
            return .kitchen
        case Localize.bathroom.lowercased():
            return .bathroom
        case Localize.bedroom.lowercased():
            return .bedroom
        case Localize.livingRoom.lowercased():
            return .livingRoom
        default:
            return .other
        }
    }
}
