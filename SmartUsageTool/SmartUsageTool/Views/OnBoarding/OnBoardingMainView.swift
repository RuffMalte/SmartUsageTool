//
//  OnBoardingMainView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import SwiftUI

struct OnBoardingMainView: View {
	
	@State var useDailyFetching: Bool = UserDefaults.useDailyFetching
	@State var selectedDailPriceFetchingCountry: SupportedPriceFetchingCountryModel?
	@State private var selectedCountry: SupportedPriceFetchingCountryModel?

	@State private var selectedCurrency: Currency?
	
	@State private var showNextScreen = false
	@State private var isLoading = false

	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text(Localize.priceFetchingSettings)) {
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
				
				Section {
					NavigationLink {
						CurrencySelectionPickerView()
					} label: {
						if let currency = selectedCurrency {
							HStack {
								Label {
									Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currency.code])).currencySymbol ?? "$")")
								} icon: {
									Text(currency.flag)
								}
								
								Spacer()
								
								Text(currency.name)
									.foregroundStyle(.secondary)
									.font(.caption)
								
							}
						} else {
							Text(Localize.none)
						}
					}
				} header: {
					Text(Localize.regionSettings)
				}
				.onAppear {
					selectedCurrency = Currency.currencies.first { $0.code == UserDefaults.currency }
				}
				
				Section {
					ColorPicker(selectedColor: $selectedTintColor)
				}
				
				HStack {
					Spacer()
					Button {
						isLoading = true
						
						UserDefaults.setUseDailyFetching(true)
						UserDefaults.standard.selectedDailPriceFetchingCountry = selectedCountry
						UserDefaults.setHasSeenOnboarding(true)
						
						isLoading = false
						withAnimation {
							showNextScreen = true
						}
					} label: {
						Text(Localize.finishOnboarding)
							.foregroundStyle(.white)
							.bold()
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 10)
									.foregroundStyle(.tint)
							}
					}
					.buttonStyle(.plain)
					Spacer()
				}
				.listRowBackground(Color.clear)
				.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
				
				
				.navigationTitle(Localize.onboarding)
			}
		}
		.navigationDestination(isPresented: $showNextScreen) {
			InitialView()
		}
	}
}

#Preview {
	OnBoardingMainView()
		.withEnvironmentObjects()
}
