//
//  SupportedPriceFetchingCountryModel.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 13.09.24.
//

import Foundation

struct SupportedPriceFetchingCountryModel: Codable, Identifiable, Hashable {
	let id: UUID
	var country: String
	var flagIcon: String
	var code: String
	var name: String
	
	init(id: UUID = UUID(), country: String, flagIcon: String, code: String, name: String) {
		self.id = id
		self.country = country
		self.flagIcon = flagIcon
		self.code = code
		self.name = name
	}
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func == (lhs: SupportedPriceFetchingCountryModel, rhs: SupportedPriceFetchingCountryModel) -> Bool {
		lhs.id == rhs.id
	}
}

extension SupportedPriceFetchingCountryModel {
	
	
	static let supportedCountries: [SupportedPriceFetchingCountryModel] = [
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Österreich", flagIcon: "🇦🇹", code: "AT", name: "Österreich"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "België", flagIcon: "🇧🇪", code: "BE", name: "België"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Schweiz", flagIcon: "🇨🇭", code: "CH", name: "Schweiz"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Česká republika", flagIcon: "🇨🇿", code: "CZ", name: "Česká republika"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Deutschland", flagIcon: "🇩🇪", code: "DE-LU", name: "Deutschland"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Deutschland", flagIcon: "🇱🇺", code: "DE-LU", name: "Luxemburg"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Danmark 1", flagIcon: "🇩🇰", code: "DK1", name: "Danmark 1"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Danmark 2", flagIcon: "🇩🇰", code: "DK2", name: "Danmark 2"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "France", flagIcon: "🇫🇷", code: "FR", name: "France"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Magyarország", flagIcon: "🇭🇺", code: "HU", name: "Magyarország"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Italia Settentrionale", flagIcon: "🇮🇹", code: "IT-North", name: "Italia Settentrionale"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Nederland", flagIcon: "🇳🇱", code: "NL", name: "Nederland"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Norge 2", flagIcon: "🇳🇴", code: "NO2", name: "Norge 2"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Polska", flagIcon: "🇵🇱", code: "PL", name: "Polska"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Sverige 4", flagIcon: "🇸🇪", code: "SE4", name: "Sverige 4"),
		SupportedPriceFetchingCountryModel(id: UUID(), country: "Slovenija", flagIcon: "🇸🇮", code: "SI", name: "Slovenija")
	]
	
	
}
