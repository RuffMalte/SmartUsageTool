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
    var dayTime: TimeInterval
    var nightTime: TimeInterval
    var power: Int
    var isOn: Bool
//    var type: DeviceType
    
    var expenses: Double {
        let powerKWT = (Double(power) / 1000)
        let dayExpenses = powerKWT * dayTime * UserDefaults.dayPrice
        let nightExpenses = powerKWT * nightTime * UserDefaults.nightPrice
        return (dayExpenses + nightExpenses) * 30
    }
    
    init(name: String, dayTime: TimeInterval, nightTime: TimeInterval = 0, power: Int, isOn: Bool) {
        self.name = name
        self.dayTime = dayTime
        self.nightTime = nightTime
        self.power = power
        self.isOn = isOn
//        self.type = type
    }
}

enum DeviceType: Codable {
    case day, night, all
}

extension TimeInterval {
    var hours: Double {
        return self / 3600
    }
}
