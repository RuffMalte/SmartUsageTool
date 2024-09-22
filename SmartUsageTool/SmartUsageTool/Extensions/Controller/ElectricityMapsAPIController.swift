//
//  ElectricityMapsAPIController.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//

import Foundation
import Observation

@Observable
class ElectricityMapsAPIController: ObservableObject {
	
	
	var currentCarbonIntensityData: CarbonIntensityData?
	var isLoading = false

	init () {
		
	}
		
	func getCurrentCarbonIntensityData(for zone: String, authToken: String) {
		Task {
			do {
				isLoading = true
				let result = try await fetchCurrentCarbonIntensityData(for: zone, authToken: authToken)
				await MainActor.run {
					currentCarbonIntensityData = result
					print(currentCarbonIntensityData?.carbonIntensity.description ?? "No data")
					isLoading = false
				}
			} catch {
				print("Error fetching carbon intensity data: \(error.localizedDescription)")
				await MainActor.run {
					isLoading = false
				}
			}
		}
	}
	
	private func fetchCurrentCarbonIntensityData(for zone: String, authToken: String) async throws -> CarbonIntensityData {
		let urlString = "https://api.electricitymap.org/v3/carbon-intensity/latest?zone=\(zone)"
		guard let url = URL(string: urlString) else {
			throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
		}
		
		var request = URLRequest(url: url)
		request.addValue(authToken, forHTTPHeaderField: "auth-token")
		
		let (data, _) = try await URLSession.shared.data(for: request)
		
		// Print the raw JSON data for debugging
		if let jsonString = String(data: data, encoding: .utf8) {
			print("Raw JSON response: \(jsonString)")
		}
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		do {
			let carbonData = try decoder.decode(CarbonIntensityData.self, from: data)
			return carbonData
		} catch {
			print("Decoding error: \(error)")
			throw error
		}
	}
	
	func calculateDevicesCarbonIntensity(devices: [DeviceModel]) -> [DeviceCarbonIntensityModel] {
		if let currentData = currentCarbonIntensityData {
			var newDevices: [DeviceCarbonIntensityModel] = []
			let carbonIntensity = currentData.carbonIntensity // Assuming this is in gCO2eq/kWh
			
			for device in devices {
				// Convert device power from watts to kilowatts
				if device.isOn == false {
					break;
				}
			
				
				let powerInKW = Double(device.power) / 1000.0
				
				
				let energyConsumptionKWh = Double(powerInKW * device.doubleFormattedDayTime) + Double(powerInKW * device.nightExpenses)
				
				// Calculate carbon intensity
				let calculatedCarbonIntensity = energyConsumptionKWh * Double(carbonIntensity)
				
				let newDevice = DeviceCarbonIntensityModel(device: device, calculatedCarbonIntensity: Double(calculatedCarbonIntensity))
				newDevices.append(newDevice)
			}
			
			let sortedDevices = newDevices.sorted { $0.calculatedCarbonIntensity > $1.calculatedCarbonIntensity }
			
			let topSevenDevices = Array(sortedDevices.prefix(7))
			
			return topSevenDevices
		} else {
			return []
		}
	}
	
}
