//
//  RoomView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import SwiftUI

struct RoomView: View {
    var room: RoomModel
    @State private var selectedDevice: DeviceModel = DeviceModel(name: Localize.selectDevice, dayTime: 0, power: 0, isOn: true)
    @State private var isPresentedNewDevice = false
    @State private var isNightPrice = UserDefaults.isNightPrice
    
    var body: some View {
        contentView
    }
}

private extension RoomView {
    var contentView: some View {
        VStack(spacing: 0) {
            headerView
            listView
        }
        .sheet(isPresented: $isPresentedNewDevice) {
            NewDevice(isPresented: $isPresentedNewDevice, room: room)
        }
        .onChange(of: isNightPrice, { oldValue, newValue in
            UserDefaults.setNight(available: newValue)
        })
        .navigationBarItems(
            trailing:
                HStack {
                    Button(action: {
                        isPresentedNewDevice.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    Menu {
                        HStack {
                            Toggle(Localize.nightPricing, isOn: $isNightPrice)
                        }
                    } label: {
                        Image(systemName: "gear")
                    }

                }
        )
        
    }
    
    
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
    
    var detailView: some View {
        VStack {
            HStack {
                Text(selectedDevice.name)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Toggle("", isOn: $selectedDevice.isOn)
            }
            HStack {
                InfoView(initialValue: selectedDevice.dayTime, type: "hrs", title: Localize.dailyUsage)
                if UserDefaults.isNightPrice {
                    InfoView(initialValue: selectedDevice.nightTime, type: Localize.hrs, title: Localize.nightlyUsage)
                }
                Spacer()
                InfoView(initialValue: Double(selectedDevice.power), type: Localize.w, title: Localize.power)
            }
        }
        .padding(30)
//        .background(Color.background)
    }
    
    var listView: some View {
        Group {
            detailView
            List {
                ForEach(room.devices) { device in
                    Button(action: {
                        selectedDevice = device
                    }) {
                        HStack {
                            Text(device.name)
                                .font(.headline)
                            Spacer()
                            Toggle("", isOn: $selectedDevice.isOn)
                        }
                        .padding(.vertical)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .onDelete(perform: deleteDevice)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    
    func deleteDevice(at offsets: IndexSet) {
        room.devices.remove(atOffsets: offsets)
    }
}

#Preview {
    RoomView(room: RoomModel(type: .bathroom, name: "Bathroom"))
}
