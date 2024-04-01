//
//  RoomModel.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 01.04.2024.
//

import Foundation

struct RoomModel: Identifiable {
    let id = UUID()
    let type: RoomType
    lazy var name: String = { type.rawValue.capitalized }()
}
