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
	@State private var currentCurrencyCode: String?
	@State private var useDailyFetchingCurrent: Bool = false
	
	@State private var dayPrice = UserDefaults.dayPrice
	private var dayPriceString: Binding<String> {
		Binding(
			get: { String(format: "%.5f", self.dayPrice) },
			set: { newValue in
				if let value = Double(newValue) {
					self.dayPrice = value
				}
			}
		)
	}
	@State private var currencyCode = UserDefaults.currency
	@State private var isNightPrice = UserDefaults.isNightPrice
	@State private var nightPrice = UserDefaults.nightPrice
	private var nightPriceString: Binding<String> {
		Binding(
			get: { String(format: "%.5f", self.nightPrice) },
			set: { newValue in
				if let value = Double(newValue) {
					self.nightPrice = value
				}
			}
		)
	}
	
	
	@State private var showNextScreen = false
	@State private var isLoading = false

	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					Toggle(isOn: $useDailyFetchingCurrent) {
						Label(Localize.useDailyFetching, systemImage: "bolt")
					}
					.onChange(of: useDailyFetchingCurrent) { oldValue, newValue in
						UserDefaults.setUseDailyFetching(newValue)
						useDailyFetching = newValue
					}
					
					if useDailyFetchingCurrent {
						Section {
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
					}
				}
				.onAppear {
					useDailyFetching = UserDefaults.useDailyFetching
				}
				
				
				if !useDailyFetching {
					Section {
						HStack {
							TextField(Localize.dailyUsage, text: dayPriceString)
								.keyboardType(.decimalPad)
								.onChange(of: dayPrice) { oldValue, newValue in
									dayPrice = newValue
									dayPriceString.wrappedValue = String(format: "%.5f", newValue)
									UserDefaults.setDay(price: newValue)
								}
							
							Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currentCurrencyCode ?? "USD"])).currencySymbol ?? "$")")
								.font(.system(.headline, design: .default, weight: .regular))
								.foregroundStyle(.secondary)
						}
						.padding()
						.clipShape(.rect(cornerRadius: 10))
					} header: {
						Text(Localize.dailyUsage)
							.padding(.leading)
					}
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
					
					Section {
						Toggle(isOn: $isNightPrice, label: {
							Label {
								Text(Localize.nightlyUsage)
							} icon: {
								Image(systemName: "moon.stars")
							}
						})
						.onChange(of: isNightPrice) { oldValue, newValue in
							UserDefaults.setNight(available: newValue)
						}
						
						if isNightPrice {
							HStack {
								TextField(Localize.nightlyUsage, text: nightPriceString)
									.keyboardType(.decimalPad)
									.disabled(!isNightPrice)
									.onChange(of: nightPrice) { oldValue, newValue in
										nightPrice = newValue
										UserDefaults.setNight(price: newValue)
										nightPriceString.wrappedValue = String(format: "%.5f", newValue)
									}
								Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currentCurrencyCode ?? "USD"])).currencySymbol ?? "$")")
									.font(.system(.headline, design: .default, weight: .regular))
									.foregroundStyle(.secondary)
							}
						}
						
					} footer: {
						Text(Localize.nightlyUsageDescription)
					}
						
					
					
				}
				
				
				Section {
					NavigationLink {
						CurrencySelectionPickerView() { selected in
							print("hello")
							selectedCurrency = Currency.currencies.first { $0.code == selected}
							currentCurrencyCode = selected
						}
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
					currentCurrencyCode = selectedCurrency?.code
				}
				
				Section {
					ColorPicker(selectedColor: $selectedTintColor)
				}
				
				HStack {
					Spacer()
					Button {
						isLoading = true
						
						UserDefaults.setUseDailyFetching(useDailyFetching)
						UserDefaults.standard.selectedDailPriceFetchingCountry = selectedCountry
						UserDefaults.setHasSeenOnboarding(true)
						
						isLoading = false
						playNotificationHaptic(.success)
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
