//
//  CarbonIntensityData.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//
import SwiftUI

struct CarbonIntensityData: Codable {
	let zone: String
	let carbonIntensity: Int
	let datetime: String
	let updatedAt: String
	let createdAt: String
	let emissionFactorType: String
	let isEstimated: Bool
	let estimationMethod: String
}

extension CarbonIntensityData {
	var datetimeAsDate: Date? {
		let formatter = ISO8601DateFormatter()
		return formatter.date(from: datetime)
	}
	
	var updatedAtAsDate: Date? {
		let formatter = ISO8601DateFormatter()
		return formatter.date(from: updatedAt)
	}
	
	var createdAtAsDate: Date? {
		let formatter = ISO8601DateFormatter()
		return formatter.date(from: createdAt)
	}
}
