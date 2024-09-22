//
//  DevicesCarbonFootPrintTableView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import SwiftUI
import SwiftData

struct DevicesCarbonFootPrintTableView: View {
	@EnvironmentObject private var electricityMapsApiController: ElectricityMapsAPIController
	@Query private var devices: [DeviceModel]
	@State private var devicesCarbonFootprint: [DeviceCarbonIntensityModel] = []
	
	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				LazyVGrid(columns: columns, spacing: 0) {
					Text(Localize.deviceName)
						.frame(maxWidth: .infinity)
					Text("gCO2eq/kWh")
						.frame(maxWidth: .infinity)
						
				}
				.font(.system(.headline, design: .rounded, weight: .bold))
				.padding()
				.foregroundStyle(.tint)
				.background(.bar)
				
				ScrollView {
					LazyVGrid(columns: columns, spacing: 0) {
						ForEach(devicesCarbonFootprint, id: \.device.id) { device in
							Text(device.device.name)
								.frame(maxWidth: .infinity)
								.padding()
								.font(.system(.subheadline, design: .default, weight: .regular))
								
							Text(device.calculatedCarbonIntensity, format: .number.precision(.fractionLength(2)))
								.frame(maxWidth: .infinity)
								.padding()
								.font(.system(.subheadline, design: .monospaced, weight: .regular))
						}
					}

				}
			}
			.onAppear {
				devicesCarbonFootprint = electricityMapsApiController.calculateDevicesCarbonIntensity(devices: devices)
			}
		}
	}
}
#Preview {
    DevicesCarbonFootPrintTableView()
}
