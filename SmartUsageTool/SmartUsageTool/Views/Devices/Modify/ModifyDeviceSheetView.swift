//
//  ModifyDeviceSheetView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 04.09.24.
//

import SwiftUI
import SwiftData

struct ModifyDeviceSheetView: View {
	
	@Bindable var device: DeviceModel
	@Bindable var roomToAddto: RoomModel
	var isNewDevice: Bool = true
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	@State private var isShowingNamingSheet = false
	@State private var isShowingConfirmation = false
	var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				VStack {
					Image("Device")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxWidth: .infinity)
					
					
					VStack(alignment: .leading, spacing: 20) {
						//name
						VStack(alignment: .leading) {
							Text(Localize.enterName)
								.font(.system(.body, design: .default, weight: .semibold))
							Button {
								isShowingNamingSheet.toggle()
							} label: {
								HStack {
									Text(device.name)
										.font(.system(.body, design: .rounded, weight: .bold))
										.foregroundStyle(.primary)
									Spacer()
									Image(systemName: "pencil")
								}
								.padding()
								.background(.bar)
								.clipShape(.rect(cornerRadius: 10))
							}
						}
						.sheet(isPresented: $isShowingNamingSheet) {
							DeviceNamingSheetView(device: device)
								.presentationDetents([.medium, .large])
						}
						
						// power
						DeviceInfoWithTextfield(
							initialValue: Double(device.power),
							type: Localize.w,
							title: Localize.powerW) { value in
								device.power = Int(value)
							}
						
						// day
						CustomHourMinutePicker(
							selection: $device.dayTime,
							label: Localize.dailyUsage,
							systemImage: "sun.max")
						
						// night
						if UserDefaults.isNightPrice {
							CustomHourMinutePicker(
								selection: $device.nightTime,
								label: Localize.nightlyUsage,
								systemImage: "moon.stars")
						}
						if !isNewDevice {
							Button(role: .destructive) {
								isShowingConfirmation.toggle()
							} label: {
								HStack {
									Spacer()
									Label(Localize.delete, systemImage: "trash")
										.font(.system(.body, design: .rounded, weight: .bold))
									Spacer()
								}
								
							}
							.padding()
							.background(.red.opacity(0.1))
							.clipShape(.rect(cornerRadius: 10))
						}
					}
					.padding()
					
					Spacer()
				}
			}
			.onAppear {
				if isNewDevice {
					device.name = Device.allCases[0].localizedName
				}
			}
			.navigationTitle(Localize.addDevice)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(Localize.save) {
						playNotificationHaptic(.success)
						if isNewDevice {
							roomToAddto.devices.append(device)
						}
						try? modelContext.save()
						dismiss()
					}
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button(Localize.cancel) {
						dismiss()
					}
				}
			}
			.confirmationDialog(Localize.areYouSure, isPresented: $isShowingConfirmation, titleVisibility: .visible) {
				Button(Localize.delete, role: .destructive) {
					withAnimation {
						modelContext.delete(device)
						try? modelContext.save()
						playNotificationHaptic(.success)
						dismiss()
					}
				}
				Button(Localize.cancel, role: .cancel) {
					isShowingConfirmation.toggle()
				}
			}
		}
	}
}

struct DeviceNamingSheetView: View {
	
	@Bindable var device: DeviceModel
	@Environment(\.dismiss) private var dismiss
	@State private var searchText = ""
	
	var filteredDevices: [Device] {
		if searchText.isEmpty {
			return Device.allCases
		} else {
			return Device.allCases.filter { $0.localizedName.lowercased().contains(searchText.lowercased()) }
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				TextField(Localize.enterName, text: $searchText)
					.font(.system(.body, design: .default, weight: .bold))
					.padding()
					.background(.bar)
					.clipShape(.rect(cornerRadius: 10))
					.onChange(of: searchText) { oldValue, newValue in
						device.name = newValue
					}
				Spacer()
				
				Button {
					device.name = searchText
					dismiss()
				} label: {
					Text(Localize.save)
				}
			}
			
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading) {
					ForEach(filteredDevices, id: \.self) { device in
						Button {
							self.searchText = device.localizedName
							self.device.name = device.localizedName
						} label: {
							HStack {
								Text(device.localizedName)
								Spacer()
								if self.device.name == device.localizedName {
									Image(systemName: "checkmark")
										.foregroundStyle(.tint)
								}
							}
							.padding(5)
							.background(self.device.name == device.localizedName ? Color(.tintColor) : .clear)
							.clipShape(.rect(cornerRadius: 5))
						}
						.buttonStyle(.plain)
					}
					.animation(.default, value: filteredDevices)
				}
			}
		}
		.padding()
		.onAppear {
			if device.name.isEmpty {
				searchText = device.name
			}
		}
	}
}
#Preview {
	DeviceNamingSheetView(device: DeviceModel.preview)
}

struct CustomHourMinutePicker: View {
	@Binding var selection: Date
	let label: String
	let systemImage: String
	
	var body: some View {
		DatePicker(selection: $selection, displayedComponents: .hourAndMinute) {
			HStack {
				Label(label, systemImage: systemImage)
					.font(.system(.body, design: .rounded, weight: .semibold))
				Spacer()
				Text(Localize.hrs + " : " + Localize.min)
					.font(.system(.footnote, design: .rounded, weight: .regular))
					.foregroundStyle(.secondary)
			}
		}
		.datePickerStyle(.compact)
	}
}

#Preview {
	ModifyDeviceSheetView(device: DeviceModel.new, roomToAddto: RoomModel.preview)
}
