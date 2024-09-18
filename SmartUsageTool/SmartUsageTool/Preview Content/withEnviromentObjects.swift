//
//  withEnviromentObjects.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import SwiftUI

struct withEnviromentObjects: ViewModifier {

	var electricityPriceController: ElectricityPriceController = ElectricityPriceController()
	
	func body(content: Content) -> some View {
		content
			.environment(electricityPriceController)
	}

}
	
extension View {
	func withEnvironmentObjects() -> some View {
		UserDefaults.setUseDailyFetching(true)
		UserDefaults.standard.selectedDailPriceFetchingCountry = SupportedPriceFetchingCountryModel.supportedCountries[0]
		UserDefaults.setHasSeenOnboarding(false)
		return self.modifier(withEnviromentObjects())
	}
}
