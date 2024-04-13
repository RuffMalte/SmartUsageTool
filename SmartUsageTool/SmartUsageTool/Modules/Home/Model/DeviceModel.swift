//
//  DeviceModel.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 13.04.2024.
//

import Foundation
import SwiftData

@Model
final class DeviceModel: Identifiable {
    let id = UUID()
    var name: String
    let dayTime: TimeInterval
    var nightTime: TimeInterval
    let power: Int
    
    init(name: String, dayTime: TimeInterval, nightTime: TimeInterval = 0, power: Int) {
        self.name = name
        self.dayTime = dayTime
        self.nightTime = nightTime
        self.power = power
    }
}
