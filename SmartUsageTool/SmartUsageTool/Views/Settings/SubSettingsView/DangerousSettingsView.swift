//
//  DangerousSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import SwiftUI
import SwiftData
import TipKit

struct DangerousSettingsView: View {
	
	@State var isShowingConfirmationAlert = false
	
	enum selection: String, CaseIterable {
		case deleteAllData
		case deleteAllRoomAndDevices
		case deleteAllDevices
		case resetAllTips
	}
	
	@State private var selected: selection?
	
	@Environment(\.modelContext) var modelContext
	
	@State var showNextScreen = false
	
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
				
				Section {
					Button(role: .destructive) {
						selected = selection.resetAllTips
						isShowingConfirmationAlert.toggle()
					} label: {
						Label(Localize.resetAllTips, systemImage: "lightbulb")
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
		.navigationDestination(isPresented: $showNextScreen) {
			OnBoardingMainView()
				.navigationBarBackButtonHidden()
			
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
		case .resetAllTips:
			return resetAllTips
		default:
			return {}
		}
	}
	
	private func deleteAllDevices() {
		deleteItems(modelContext, type: DeviceModel.self)
		playNotificationHaptic(.success)
	}
	
	private func deleteAllRoomAndDevices() {
		deleteItems(modelContext, type: DeviceModel.self)
		deleteItems(modelContext, type: RoomModel.self)
		playNotificationHaptic(.success)
	}
	
	private func deleteAllData() {
		deleteItems(modelContext, type: DeviceModel.self)
		deleteItems(modelContext, type: RoomModel.self)
		UserDefaults.resetToDefaults()
		playNotificationHaptic(.success)
		showNextScreen = true
	}
	
	private func resetAllTips() {
		Task {
			try? Tips.resetDatastore()
		}
		playNotificationHaptic(.success)
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
