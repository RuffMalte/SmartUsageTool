//
//  HomeViewModel.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 01.04.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var enteredText = ""
    @Published var totalCost: Double = 0.0
    
    
//    // TODO: - Mock data should be replaced to real
//    @Published var rooms: [RoomModel] = [
//        .init(type: .kitchen),
//        .init(type: .bathroom),
//        .init(type: .bedroom),
//        .init(type: .livingRoom),
//        .init(type: .other),
//        .init(type: .other),
//        .init(type: .other),
//        .init(type: .other),
//        .init(type: .other),
//    ]
}
