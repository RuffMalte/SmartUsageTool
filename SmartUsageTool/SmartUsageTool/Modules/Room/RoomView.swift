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
    @Binding var isNightPrice: Bool
    
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
        .onAppear {
            selectedDevice = room.devices[0]
        }
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
            Text(String(format: "\(Localize.currencySymbol)%.2f", room.expenses))
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
            VStack {
                InfoView(initialValue: selectedDevice.dayTime, type: Localize.hrs, title: Localize.dailyUsage)
                    // TODO: - Add switch to the night time
//                if selectedDevice.dayTime > 0  {
//                    Button("Використовувати лише вночі") {
//                        selectedDevice.nightTime += selectedDevice.dayTime
//                        selectedDevice.dayTime = 0
//                    }
//                }
                if isNightPrice {
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
                            Toggle("", isOn: Bindable(device).isOn)
                                .toggleStyle(PowerToggleStyle())
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

//#Preview {
//    RoomView(room: RoomModel(type: .bathroom, name: "Bathroom"), isNightPrice: .constant(true))
//}

struct PowerToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "power" : "poweroff")
                    .foregroundStyle(configuration.isOn ? .green : .gray)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}
