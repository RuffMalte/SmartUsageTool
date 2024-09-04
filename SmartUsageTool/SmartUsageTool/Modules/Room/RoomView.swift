//
//  RoomView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import SwiftUI
import SwiftData

struct RoomView: View {
	@Bindable var room: RoomModel
	//    @State private var selectedDevice: DeviceModel = DeviceModel(name: Localize.selectDevice, dayTime: 0, power: 0, isOn: true)
	@State private var isPresentedNewDevice = false
	@Binding var isNightPrice: Bool
	
	var body: some View {
		contentView
	}
}

private extension RoomView {
	var contentView: some View {
		VStack {
			VStack(spacing: 0) {
				headerView
				listView
			}
			.sheet(isPresented: $isPresentedNewDevice) {
				ModifyDeviceSheetView(device: DeviceModel.new, roomToAddto: room, isNewDevice: true)
//				NewDevice(isPresented: $isPresentedNewDevice, room: room)
			}
			.onChange(of: isNightPrice, { oldValue, newValue in
				UserDefaults.setNight(available: newValue)
			})
			
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(action: {
						isPresentedNewDevice.toggle()
					}) {
						Image(systemName: "plus")
					}
				}
			}
		}
	}
	
	
	var headerView: some View {
		HStack {
			Text(room.name)
				.font(.system(.largeTitle, weight: .bold))
			Spacer()
			Text(room.expenses, format: .currency(code: UserDefaults.currency))
				.font(.system(.title3, design: .monospaced, weight: .regular))
			
		}
		.padding()
		.background(Color.background)
	}
	
	//    var detailView: some View {
	//        VStack {
	//            HStack {
	//                Text(selectedDevice.name)
	//                    .font(.system(size: 22, weight: .semibold))
	//                Spacer()
	//                Toggle("", isOn: $selectedDevice.isOn)
	//            }
	//            VStack {
	//                InfoView(initialValue: selectedDevice.dayTime, type: Localize.hrs, title: Localize.dailyUsage)
	//                    // TODO: - Add switch to the night time
	////                if selectedDevice.dayTime > 0  {
	////                    Button("Використовувати лише вночі") {
	////                        selectedDevice.nightTime += selectedDevice.dayTime
	////                        selectedDevice.dayTime = 0
	////                    }
	////                }
	//                if isNightPrice {
	//                    InfoView(initialValue: selectedDevice.nightTime, type: Localize.hrs, title: Localize.nightlyUsage)
	//                }
	//                Spacer()
	//                InfoView(initialValue: Double(selectedDevice.power), type: Localize.w, title: Localize.power)
	//            }
	//        }
	//        .padding(30)
	////        .background(Color.background)
	//    }
	
	var listView: some View {
		Group {
			//            detailView
			List {
				ForEach(room.devices) { device in
					NavigationLink {
						DeviceDetailView(device: device, currentRoom: room)
					} label: {
						DeviceItemListView(device: device)
					}
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
	NavigationView {
		RoomView(room: RoomModel.preview, isNightPrice: .constant(true))
	}
}

struct PowerToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		Button {
			withAnimation {
				configuration.isOn.toggle()
			}
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
