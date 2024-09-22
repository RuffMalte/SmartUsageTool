//
//  DeviceCarbonIntensityModel.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import Foundation

struct DeviceCarbonIntensityModel: Identifiable {
	
	var id: UUID
	var device: DeviceModel
	var calculatedCarbonIntensity: Double
	
	init(id: UUID = UUID(), device: DeviceModel, calculatedCarbonIntensity: Double) {
		self.id = id
		self.device = device
		self.calculatedCarbonIntensity = calculatedCarbonIntensity
	}
}
