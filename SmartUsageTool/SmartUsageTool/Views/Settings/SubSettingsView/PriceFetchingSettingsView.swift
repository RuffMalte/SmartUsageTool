//
//  PriceFetchingSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 11.09.24.
//

import SwiftUI

struct PriceFetchingSettingsView: View {
	
	@State private var useDailyFetching = UserDefaults.useDailyFetching
	@EnvironmentObject private var viewModel: ElectricityPriceController
	
	@State private var selectedCountry: SupportedPriceFetchingCountryModel?
	
	var body: some View {
		Form {
			Section {
				Toggle(isOn: $useDailyFetching) {
					Label(Localize.useDailyFetching, systemImage: "bolt.fill")
				}
				.onChange(of: useDailyFetching) { oldValue, newValue in
					UserDefaults.setUseDailyFetching(newValue)
					useDailyFetching = newValue
					if newValue {
						viewModel.fetchCurrentPrice()
					}
				}
			} footer: {
				Text(Localize.useDailyFetchingDescription)
			}
			.onAppear {
				useDailyFetching = UserDefaults.useDailyFetching
			}
			
			Section(header: Text(Localize.selectCountry)) {
				NavigationLink(destination: CountrySelectionView(selectedCountry: $selectedCountry)) {
					if let country = selectedCountry {
						HStack {
							Text(country.flagIcon)
							Text(country.name)
						}
					} else {
						Text(Localize.selectCountry)
					}
				}
			}
			.onAppear {
				selectedCountry = UserDefaults.standard.selectedDailPriceFetchingCountry
				if selectedCountry == nil {
					let currentLocale = Locale.current
					let languageCode = currentLocale.language.languageCode?.identifier
					let regionCode = currentLocale.region?.identifier
					
					selectedCountry = SupportedPriceFetchingCountryModel.supportedCountries.first { country in
						if languageCode == "de" {
							return country.code == "DE-LU"
						} else if languageCode == "uk" {
							return country.code == "PL"
						} else if let regionCode = regionCode {
							return country.code.hasPrefix(regionCode)
						}
						return false
					}
					
					selectedCountry = selectedCountry ?? SupportedPriceFetchingCountryModel.supportedCountries.first { $0.code == "DE-LU" }
					
					UserDefaults.standard.selectedDailPriceFetchingCountry = selectedCountry
				}
			}
			
			Button {
				viewModel.fetchCurrentPrice()
			} label: {
				HStack {
					Spacer()
					Text(Localize.forcePriceUpdate)
					Spacer()
				}
				.font(.system(.subheadline, design: .rounded, weight: .bold))
				.foregroundStyle(.gray)
			}
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
			.listRowBackground(EmptyView())
			
			
			
			.navigationTitle(Localize.priceFetchingSettings)
		}
	}
}

#Preview {
	NavigationStack {
		PriceFetchingSettingsView()
			.withEnvironmentObjects()
	}
}

struct CountrySelectionView: View {
	@Binding var selectedCountry: SupportedPriceFetchingCountryModel?
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject private var viewModel: ElectricityPriceController
	
	var body: some View {
		List {
			Button(Localize.none) {
				selectedCountry = nil
				saveSelection()
				presentationMode.wrappedValue.dismiss()
			}
			
			ForEach(SupportedPriceFetchingCountryModel.supportedCountries) { country in
				Button {
					selectedCountry = country
					saveSelection()
					presentationMode.wrappedValue.dismiss()
					viewModel.fetchCurrentPrice()
				} label: {
					HStack {
						Text(country.flagIcon)
						Text(country.name)
						Spacer()
						if selectedCountry?.id == country.id {
							Image(systemName: "checkmark")
						}
					}
				}
			}
		}
		.navigationTitle("Select a Country")
	}
	
	private func saveSelection() {
		UserDefaults.standard.selectedDailPriceFetchingCountry = selectedCountry
	}
}
