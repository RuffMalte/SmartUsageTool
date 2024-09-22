//
//  RoomModel.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 01.04.2024.
//

import Foundation
import SwiftData

@Model
final class RoomModel: Identifiable {
    var id = UUID()
    var type: RoomType
    var name: String
    @Relationship(deleteRule: .cascade)  var devices: [DeviceModel] = []
	
	var dailyExpenses: Double {
		devices.filter { $0.isOn }.reduce(0.0) { $0 + $1.expenses }
	}
	
	var monthlyExpenses: Double {
		dailyExpenses * 30 // Assuming an average month has 30 days
	}
	
	var yearlyExpenses: Double {
		dailyExpenses * 365 // Using 365 days for a year
	}
    
    init(type: RoomType, name: String) {
        self.type = type
        self.name = name
    }
	
}

extension RoomModel {
	static let preview = RoomModel(type: .livingRoom, name: "livingRoom")
}

extension RoomModel {
	static var new: RoomModel {
		return RoomModel(type: .other, name: "")
	}
}
