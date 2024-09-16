//
//  DeviceModel.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 13.04.2024.
//

import Foundation
import SwiftData

@Model
final class DeviceModel: Identifiable, ObservableObject {
	let id = UUID()
	var name: String
	var dayTime: Date
	var nightTime: Date
	var power: Int
	var isOn: Bool
	// var type: DeviceType
	
	// Computed property for day expenses
	var dayExpenses: Double {
		let powerKWT = Double(power) / 1000
		return powerKWT * doubleFormattedDayTime * UserDefaults.dayPrice
	}
	
	// Computed property for night expenses
	var nightExpenses: Double {
		let powerKWT = Double(power) / 1000
		return powerKWT * doubleFormattedNightTime * UserDefaults.nightPrice
	}
	
	// Total expenses combining day and night expenses
	var expenses: Double {
		return dayExpenses + nightExpenses
	}
	
	init(name: String, dayTime: Date, nightTime: Date, power: Int, isOn: Bool) {
		self.name = name
		self.dayTime = dayTime
		self.nightTime = nightTime
		self.power = power
		self.isOn = isOn
		// self.type = type
	}
	
	var doubleFormattedDayTime: Double {
		let components = Calendar.current.dateComponents([.hour, .minute], from: dayTime)
		let hours = Double(components.hour ?? 0)
		let minutes = Double(components.minute ?? 0)
		return hours + (minutes / 60.0).rounded(to: 2)
	}
	
	var doubleFormattedNightTime: Double {
		let components = Calendar.current.dateComponents([.hour, .minute], from: nightTime)
		let hours = Double(components.hour ?? 0)
		let minutes = Double(components.minute ?? 0)
		return hours + (minutes / 60.0).rounded(to: 2)
	}
}

extension Double {
	func rounded(to places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
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

extension DeviceModel {
	static let preview: DeviceModel = {
		let calendar = Calendar.current
		let referenceDate = calendar.startOfDay(for: Date())
		return DeviceModel(
			name: "Device",
			dayTime: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!,
			nightTime: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!,
			power: 0,
			isOn: true
		)
	}()
	
	static var new: DeviceModel {
		let calendar = Calendar.current
		let referenceDate = calendar.startOfDay(for: Date())
		return DeviceModel(
			name: "",
			dayTime: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!,
			nightTime: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: referenceDate)!,
			power: 0,
			isOn: true
		)
	}
}
