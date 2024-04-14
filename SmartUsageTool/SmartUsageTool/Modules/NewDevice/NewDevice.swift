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
    @State private var power: Int = 0
    @State private var dayTime: TimeInterval = 0
    @State private var nightTime: TimeInterval = 0
    var room: RoomModel
    var isNightPrice: Bool { UserDefaults.isNightPrice }
    
    var body: some View {
        contentView
    }
}

private extension NewDevice {
    var contentView: some View {
        ZStack {
            NavigationView {
                mainView
                
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Add Device")
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented.toggle()
                    },
                                        trailing: Button("Save") {
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
            Text("Device Name")
                .fontWeight(.semibold)
            TextField("Enter name", text: $name)
                .padding()
                .textFieldStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
                )
        }
    }
    
    var powerView: some View {
        VStack(alignment: .leading) {
            Text("Power")
                .fontWeight(.semibold)
            TextField("Enter power", text: $name)
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
            Text("Daily Usage")
                .fontWeight(.semibold)
            TextField("Enter time", text: $name)
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
            Text("Nightly Usage")
                .fontWeight(.semibold)
            TextField("Enter time", text: $name)
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
        let newItem = DeviceModel(name: name, dayTime: dayTime, nightTime: nightTime, power: power, isOn: true)
        room.devices.append(newItem)
    }
}

#Preview {
    NewDevice(isPresented: .constant(true), room: RoomModel(type: .bathroom, name: ""))
}
