//
//  withEnviromentObjects.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import SwiftUI

struct withEnviromentObjects: ViewModifier {

	var electricityPriceController: ElectricityPriceController = ElectricityPriceController()
	var electricityMapsAPIController = ElectricityMapsAPIController()
	var electricityMapsAPIKeyController = ElectricityMapsAPIKeyController()
	func body(content: Content) -> some View {
		content
			.environment(electricityPriceController)
			.environment(electricityMapsAPIController)
			.environment(electricityMapsAPIKeyController)
	}

}
	
extension View {
	func withEnvironmentObjects() -> some View {
		UserDefaults.setUseDailyFetching(false)
		UserDefaults.standard.selectedDailPriceFetchingCountry = SupportedPriceFetchingCountryModel.supportedCountries[0]
		UserDefaults.setHasSeenOnboarding(true)
		return self.modifier(withEnviromentObjects())
	}
}
