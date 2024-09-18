//
//  DangerousSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import SwiftUI
import SwiftData

struct DangerousSettingsView: View {
	
	@State var isShowingConfirmationAlert = false
	
	enum selection: String, CaseIterable {
		case deleteAllData
		case deleteAllRoomAndDevices
		case deleteAllDevices
	}
	
	@State private var selected: selection?
	
	@Environment(\.modelContext) var modelContext
	
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					Button(role: .destructive) {
						selected = selection.deleteAllData
						isShowingConfirmationAlert.toggle()
					} label: {
						Label(Localize.deleteAllData, systemImage: "trash")
							.foregroundStyle(.red)
					}
					
				} footer: {
					
				}
				
				Section {
					Button(role: .destructive) {
						selected = selection.deleteAllRoomAndDevices
						isShowingConfirmationAlert.toggle()
					} label: {
						Label(Localize.deleteAllRoomAndDevices, systemImage: "square.split.bottomrightquarter")
							.foregroundStyle(.red)
					}
				}
				
				Section {
					Button(role: .destructive) {
						selected = selection.deleteAllDevices
						isShowingConfirmationAlert.toggle()
					} label: {
						Label(Localize.deleteAllDevices, systemImage: "oven")
							.foregroundStyle(.red)
					}
				}
				
			}
			.alert(getDeleteLocalizeString(), isPresented: $isShowingConfirmationAlert) {
				Button(Localize.cancel, role: .cancel) {}
				Button(Localize.delete, role: .destructive) {
					getExecuteFunctionOnSelction()()
				}
			}
			.navigationTitle(Localize.dangerousSettings)
			
		}
	}
	
	private func getDeleteLocalizeString() -> String {
		switch selected {
		case .deleteAllData:
			return Localize.deleteAllData
		case .deleteAllRoomAndDevices:
			return Localize.deleteAllRoomAndDevices
		case .deleteAllDevices:
			return Localize.deleteAllDevices
		default:
			return ""
		}
	}
	
	private func getExecuteFunctionOnSelction() -> (() -> Void) {
		switch selected {
		case .deleteAllData:
			return deleteAllData
		case .deleteAllRoomAndDevices:
			return deleteAllRoomAndDevices
		case .deleteAllDevices:
			return deleteAllDevices
		default:
			return {}
		}
	}
	
	private func deleteAllDevices() {
		deleteItems(modelContext, type: DeviceModel.self)
	}
	
	private func deleteAllRoomAndDevices() {
		deleteItems(modelContext, type: DeviceModel.self)
		deleteItems(modelContext, type: RoomModel.self)
	}
	
	private func deleteAllData() {
		deleteItems(modelContext, type: DeviceModel.self)
		deleteItems(modelContext, type: RoomModel.self)
		UserDefaults.resetToDefaults()
	}
	
	private func deleteItems<T: PersistentModel>(_ modelContext: ModelContext, type: T.Type) {
		do {
			let fetchDescriptor = FetchDescriptor<T>()
			let items = try modelContext.fetch(fetchDescriptor)
			
			for item in items {
				modelContext.delete(item)
			}
			
			try modelContext.save()
			
		} catch {
			print("Failed to delete items: \(error)")
		}
	}
}

#Preview {
	DangerousSettingsView()
}
