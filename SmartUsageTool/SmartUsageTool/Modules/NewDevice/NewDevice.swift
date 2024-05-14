//
//  NewDevice.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//
import SwiftUI
import SwiftData

struct NewDevice: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var power: String = ""
    @State private var dayTime: String = ""
    @State private var nightTime: String = ""
    @State private var selectedDevice: Device = .spaceHeater
    let devices: [Device] = Device.allCases
    var room: RoomModel
    var isNightPrice: Bool { UserDefaults.isNightPrice }
    
    var body: some View {
//        ScrollView(.vertical) {
            contentView
//        }
    }
}

private extension NewDevice {
    var contentView: some View {
        ZStack {
            NavigationView {
                mainView
                
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(Localize.addDevice)
                    .navigationBarItems(leading: Button(Localize.cancel) {
                        isPresented.toggle()
                    },
                                        trailing: Button(Localize.save) {
                        addItem()
                        isPresented.toggle()
                    })
                
            }
        }
    }
    
    var mainView: some View {
        VStack(spacing: 8) {
            Image("Device")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            nameView
                .padding(.horizontal , 30)
            powerView
                .padding(.horizontal , 30)
            dailyView
                .padding(.horizontal , 30)
            if isNightPrice {
                nightlyView
                    .padding(.horizontal , 30)
            }
            Spacer()
        }
    }
    
    var nameView: some View {
        VStack(alignment: .leading) {
            Text(Localize.device)
                .fontWeight(.semibold)
            if selectedDevice == .other {
                textfieldView
            } else {
                devicePickerView
            }
        }
    }
    
    var textfieldView: some View {
        TextField(Localize.enterName, text: $name)
            .padding()
            .textFieldStyle(.plain)
            .background(
                RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
            )
    }
    
    var devicePickerView: some View {
        HStack {
            Picker(Localize.selectDevice, selection: $selectedDevice) {
                        ForEach(devices, id: \.self) { device in
                                Text(device.localizedName)
                                    .font(.system(size: 14))
                        }
                    }
            .pickerStyle(.menu)
            Spacer()
        }
        .padding(.vertical,8)
        .background(
            RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
        )

    }
    
    var powerView: some View {
        VStack(alignment: .leading) {
            Text(Localize.powerW)
                .fontWeight(.semibold)
            TextField(Localize.enterPower, text: $power)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
                )
        }
    }
    
    var dailyView: some View {
        VStack(alignment: .leading) {
            Text(Localize.dailyUsageHours)
                .fontWeight(.semibold)
            TextField(Localize.enterTime, text: $dayTime)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
                )
        }
    }
    
    var nightlyView: some View {
        VStack(alignment: .leading) {
            Text(Localize.nightlyUsage)
                .fontWeight(.semibold)
            TextField(Localize.enterTime, text: $nightTime)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
                )
        }
    }
}

private extension NewDevice {
    func addItem() {
        let newItem = DeviceModel(name: selectedDevice == .other ? name : selectedDevice.localizedName, dayTime: TimeInterval(dayTime) ?? 0, nightTime: TimeInterval(nightTime) ?? 0, power: Int(power) ?? 0, isOn: true)
        room.devices.append(newItem)
    }
}

#Preview {
    NewDevice(isPresented: .constant(true), room: RoomModel(type: .bathroom, name: ""))
}
