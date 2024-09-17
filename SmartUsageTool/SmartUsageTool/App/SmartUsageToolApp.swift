//
//  SmartUsageToolApp.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

@main
struct SmartUsageToolApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RoomModel.self,
            DeviceModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
	
	@StateObject private var electricityPriceController = ElectricityPriceController()
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue

    var body: some Scene {
        WindowGroup {
            LaunchView()
				.tint(selectedTintColor.toColor)
                .modelContainer(sharedModelContainer)
				.environmentObject(electricityPriceController)
        }
    }
}
