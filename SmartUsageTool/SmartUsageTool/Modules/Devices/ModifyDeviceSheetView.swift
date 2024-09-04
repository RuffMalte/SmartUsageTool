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
								.background(Color(.systemGray6))
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
					}
					.padding()
					
					Spacer()
				}
			}
			.onAppear {
				if isNewDevice {
					device.name = Device.allCases[0].rawValue
				}
			}
			.navigationTitle(Localize.addDevice)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(Localize.save) {
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
			return Device.allCases.filter { $0.rawValue.lowercased().contains(searchText.lowercased()) }
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				TextField(Localize.enterName, text: $searchText)
					.font(.system(.body, design: .default, weight: .bold))
					.padding()
					.background(Color(.systemGray6))
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
							self.searchText = device.rawValue
							self.device.name = device.rawValue
						} label: {
							HStack {
								Text(NSLocalizedString(device.rawValue.capitalized, comment: ""))
								Spacer()
								if self.device.name == device.rawValue {
									Image(systemName: "checkmark")
										.foregroundStyle(.tint)
								}
							}
							.padding(5)
							.background(self.device.name == device.rawValue ? Color(.systemGray6) : .clear)
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
