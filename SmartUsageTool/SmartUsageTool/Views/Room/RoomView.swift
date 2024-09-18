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
	@State private var isPresentedEditRoom = false
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
					.popoverTip(AddNewDeviceTip())
				}
				ToolbarItem(placement: .primaryAction) {
					Button {
						isPresentedEditRoom.toggle()
					} label: {
						Image(systemName: "pencil")
					}
					.popoverTip(EditRoomTip())
				}
			}
			.sheet(isPresented: $isPresentedEditRoom) {
				ModifyRoomSheetView(room: room, isNewRoom: false)
			}
		}
	}
	
	
	var headerView: some View {
		HStack {
			Text(NSLocalizedString(room.name.capitalized, comment: ""))
				.font(.system(.largeTitle, weight: .bold))
			Spacer()
			Text(room.dailyExpenses, format: .currency(code: UserDefaults.currency))
				.font(.system(.title3, design: .monospaced, weight: .regular))
			
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.background)
				.shadow(radius: 10)
		}
	}
	
	var listView: some View {
		Group {
			List {
				ForEach(room.devices) { device in
					NavigationLink {
						DeviceDetailView(device: device, currentRoom: room)
					} label: {
						DeviceItemListView(device: device)
					}
				}
			}
			.listStyle(PlainListStyle())
		}
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
			playFeedbackHaptic(.medium)
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
