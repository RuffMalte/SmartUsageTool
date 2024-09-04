//
//  DeviceItemListView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 02.09.24.
//

import SwiftUI
import SwiftData

struct DeviceItemListView: View {
	
	@Bindable var device: DeviceModel
	@State private var isNightPrice = UserDefaults.isNightPrice
	@State private var currencyCode = UserDefaults.currency

	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	@State private var showingConfirmation = false
	@State private var isShowingEditSheet = false
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 10) {
				
				HStack {
					Text(device.name)
						.font(.system(.title2, design: .rounded, weight: .bold))
					Spacer()
					HStack(spacing: 5) {
						Text("\(device.expenses, specifier: "%.2f")")
						Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")")
					}
					.font(.system(.headline, design: .monospaced, weight: .bold))
					.foregroundStyle(.secondary)
					.padding(.trailing, 10)
				}
				.lineLimit(1)
				
				LazyVGrid(columns: {
					var gridItems = [
						GridItem(.flexible(minimum: 80)),
						GridItem(.flexible(minimum: 80))
					]
					if isNightPrice {
						gridItems.append(GridItem(.flexible(minimum: 80)))
					}
					return gridItems
				}(), alignment: .leading, spacing: 16) {
					DeviceInfoViewSmall(initialValue: Double(device.power), type: Localize.w)
					DeviceInfoViewSmall(initialValue: device.doubleFormattedDayTime, type: Localize.hrs, icon: "sun.max.fill")
					if isNightPrice {
						DeviceInfoViewSmall(initialValue: device.doubleFormattedNightTime, type: Localize.hrs, icon: "moon.fill")
					}
				}
				.lineLimit(1)
				
			}
			Spacer()
			Toggle("", isOn: Bindable(device).isOn)
				.toggleStyle(PowerToggleStyle())
				.font(.title2)
		}
		.contextMenu {
			Button {
				withAnimation {
					device.isOn.toggle()
				}
			} label: {
				Label(device.isOn ? Localize.turnOff : Localize.turnOn, systemImage: device.isOn ? "poweroff" : "power")
			}
			Button {
				isShowingEditSheet.toggle()
			} label: {
				Label(Localize.edit, systemImage: "pencil")
			}

			Button(role: .destructive) {
				showingConfirmation.toggle()
			} label: {
				Label(Localize.delete, systemImage: "trash")
			}
		}
		.confirmationDialog(Localize.areYouSure, isPresented: $showingConfirmation, titleVisibility: .visible) {
			Button(Localize.delete, role: .destructive) {
				withAnimation {
					modelContext.delete(device)
					try? modelContext.save()
				}
			}
			Button(Localize.cancel, role: .cancel) {
				dismiss()
			}
		}
		.sheet(isPresented: $isShowingEditSheet) {
			ModifyDeviceSheetView(device: device, roomToAddto: RoomModel.preview)
		}
	}
}

#Preview {
	DeviceItemListView(device: DeviceModel.preview)
}
