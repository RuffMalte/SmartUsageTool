//
//  RoomView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import SwiftUI

struct RoomView: View {
    var room: RoomModel
    @State private var selectedDevice: DeviceModel = DeviceModel(name: "Select Device", dayTime: 0, power: 0, isOn: false)
    
    
    var body: some View {
        VStack {
            headerView
            Spacer()
        }
        .navigationBarItems(
            trailing:
                HStack {
                    Button(action: {
                        // Action for the first button
                    }) {
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        // Action for the second button
                    }) {
                        Image(systemName: "gear")
                    }
                }
        )
    }
}

private extension RoomView {
    var headerView: some View {
        HStack {
            Text(room.name)
                .font(.system(size: 28, weight: .semibold))
            Spacer()
            Text(String(format: "$%.2f", room.expenses))
                .font(.system(size: 22))
        }
        .padding(30)
        .padding(.bottom, 10)
        .background(Color.background)
    }
}

#Preview {
    RoomView(room: RoomModel(type: .bathroom, name: "Bathroom"))
}
