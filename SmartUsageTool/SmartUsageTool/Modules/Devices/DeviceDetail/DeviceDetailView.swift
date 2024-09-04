//
//  DeviceDetailView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 02.09.24.
//

import SwiftUI
import SwiftData

struct DeviceDetailView: View {
	
	@Bindable var device: DeviceModel
	@Bindable var currentRoom: RoomModel
	
	@Environment(\.modelContext) private var modelContext
	
	@State private var isShowingInformation: Bool = false
	@State private var isNightPrice = UserDefaults.isNightPrice
	@State private var currencyCode = UserDefaults.currency
	
	@State private var isShowingEditSheet = false
	var body: some View {
		VStack {
			headerView
			ScrollView(.vertical, showsIndicators: false) {
				
				Button {
					withAnimation(.bouncy) {
						device.isOn.toggle()
					}
				} label: {
					Image(systemName: device.isOn ? "power" : "poweroff")
						.foregroundStyle(device.isOn ? .green : .secondary)
						.font(.system(size: 150))
						.shadow(radius: 1)
						.padding()
						.contentTransition(.symbolEffect(.automatic))
				}
				.buttonStyle(.plain)
				.frame(width: 200, height: 200)
				
				Text(device.isOn ? Localize.turnOff : Localize.turnOn)
					.font(.system(.headline, design: .monospaced, weight: .bold))
				
				Divider()
					.padding(.vertical)
				
				VStack {
					HStack {
						Spacer()
						
						Label {
							Text(device.expenses, format: .currency(code: UserDefaults.currency))
								.font(.system(.headline, design: .monospaced, weight: .bold))
						} icon: {
							Image(systemName: "bolt.fill")
								.foregroundStyle(.yellow)
						}
						
						Spacer()
						Button {
							withAnimation {
								isShowingInformation.toggle()
							}
						} label: {
							Image(systemName: "info.circle")
								.font(.title3)
						}
						.popover(isPresented: $isShowingInformation) {
							ScrollView {
								VStack {
									Text(Localize.deviceInfo)
								}
							}
							.frame(width: 200, height: 150)
							.padding()
							.presentationCompactAdaptation(.popover)
						}
					}
					if UserDefaults.isNightPrice {
						HStack {
							Spacer()
							Label {
								Text(device.dayExpenses, format: .currency(code: UserDefaults.currency))
									.font(.system(.headline, design: .monospaced, weight: .bold))
							} icon: {
								Image(systemName: "sun.max")
							}
							Spacer()
							Label {
								Text(device.nightExpenses, format: .currency(code: UserDefaults.currency))
									.font(.system(.headline, design: .monospaced, weight: .bold))
							} icon: {
								Image(systemName: "moon.stars")
							}
							Spacer()
						}
						.padding(.vertical, 5)
					}
				}
				Divider()
					.padding(.vertical)
				
				
				VStack(spacing: 20) {
					DeviceInfoWithTextfield(
						initialValue: Double(device.power),
						type: Localize.w,
						title: Localize.power
					) { value in
						device.power = Int(value)
					}
					
					CustomHourMinutePicker(
						selection: $device.dayTime,
						label: Localize.dailyUsage,
						systemImage: "sun.max")
					
					if UserDefaults.isNightPrice {
						CustomHourMinutePicker(
							selection: $device.nightTime,
							label: Localize.nightlyUsage,
							systemImage: "moon.stars")
					}
				}
				.toolbar {
					ToolbarItemGroup(placement: .keyboard) {
						Button {
							dismissKeyboard()
						} label: {
							Image(systemName: "keyboard.chevron.compact.down")
						}
						Spacer()
						Button {
							dismissKeyboard()
						} label: {
							Image(systemName: "square.and.arrow.down")
						}
					}
					ToolbarItem(placement: .primaryAction) {
						Button {
							isShowingEditSheet.toggle()
						} label: {
							Image(systemName: "pencil")
						}
					}
				}
			}
			.padding([.bottom, .horizontal])
			.sheet(isPresented: $isShowingEditSheet) {
				ModifyDeviceSheetView(device: device, roomToAddto: currentRoom, isNewDevice: false)
			}
		}
		
	}
	var headerView: some View {
		HStack {
			Text(device.name)
				.font(.system(.largeTitle, weight: .bold))
			Spacer()
		}
		.padding()
		.background(Color.background)
	}
	private func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	DeviceDetailView(device: DeviceModel.preview, currentRoom: RoomModel.preview)
}
