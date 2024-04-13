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
        case "kitchen":
            return .kitchen
        case "bathroom":
            return .bathroom
        case "bedroom":
            return .bedroom
        case "livingroom", "living room":
            return .livingRoom
        default:
            return .other
        }
    }
}
