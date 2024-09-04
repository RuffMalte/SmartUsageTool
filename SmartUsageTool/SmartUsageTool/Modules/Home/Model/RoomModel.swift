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
    let id = UUID()
    let type: RoomType
    var name: String
    @Relationship(deleteRule: .cascade)  var devices: [DeviceModel] = []
	var expenses: Double {
		devices.filter { $0.isOn }.reduce(0.0) { $0 + $1.expenses }
	}
    
    init(type: RoomType, name: String) {
        self.type = type
        self.name = name
    }
}

extension RoomModel {
	static let preview = RoomModel(type: .livingRoom, name: "Living Room")
}
