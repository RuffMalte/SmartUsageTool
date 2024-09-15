//
//  RegionSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct RegionSettingsView: View {
	
	@State var selectedCurrency: Currency?
	
	@State private var searchText = ""
	@State private var isShowingCurrencyExplanation = false
	
	var body: some View {
		Form {
			Section {
				List {
					ForEach(filteredCurrencies, id: \.self) { currency in
						Button(action: {
							withAnimation {
								selectedCurrency = currency
								UserDefaults.setCurrency(currency.code)
							}
						}) {
							HStack {
								if selectedCurrency == currency {
									Image(systemName: "checkmark")
										.foregroundStyle(.green)
								} else {
									Image(systemName: "circle")
										.foregroundStyle(.secondary)
								}
								Text(currency.flag)
									.font(.title2)
								Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currency.code])).currencySymbol ?? "$")")
								Spacer()
								Text(NSLocalizedString(currency.name, comment: ""))
									.foregroundColor(.secondary)
							}
						}
						
					}
				}
				.onAppear {
					selectedCurrency = currencies.first { $0.code == UserDefaults.currency }
				}
			} header: {
				HStack {
					Label {
						Text(selectedCurrency?.flag ?? "")
					} icon: {
						Text(NSLocalizedString(selectedCurrency?.code ?? "USD", comment: ""))
					}
					Spacer()
					
					Button {
						isShowingCurrencyExplanation.toggle()
					} label: {
						Image(systemName: "info.circle")
					}
				}
				.popover(isPresented: $isShowingCurrencyExplanation, content: {
					ScrollView(.vertical) {
						VStack {
							Text(Localize.currencyExplanation)
							
								.presentationCompactAdaptation(.popover)
						}
					}
					.padding()
					.frame(width: 200, height: 150)
					.font(.system(.subheadline, design: .rounded, weight: .regular))
					.foregroundStyle(.primary)
				})
			}
			
			
			//Region for api purpose in the future
			//Depending on some countries that have diffent regions for dirrent Prices
			//so make something to select the land/ region you want to pull from
			//default is the users location if they want to pull from there
			//maybe this one: https://zylalabs.com/api-marketplace/data/electricity%2Brates%2Bin%2Beurope%2Bapi/3040
			
		}
		.searchable(text: $searchText)
		
		.navigationTitle(Localize.regionSettings)
		.navigationBarTitleDisplayMode(.large)
	}
	private var filteredCurrencies: [Currency] {
		if searchText.isEmpty {
			return currencies
		} else {
			return currencies.filter { currency in
				currency.code.lowercased().contains(searchText.lowercased()) ||
				currency.name.lowercased().contains(searchText.lowercased())
			}
		}
	}
	
	private func getCurrentCode() -> String {
		let code = UserDefaults.currency
		return code
	}
	
	struct Currency: Identifiable, Hashable {
		let id = UUID()
		let code: String
		let name: String
		let flag: String
	}
	
	let currencies = [
		Currency(code: "EUR", name: "Euro", flag: "🇪🇺"),
		Currency(code: "HRN", name: "Ukrainian Hryvnia", flag: "🇺🇦"),
		Currency(code: "GBP", name: "British Pound", flag: "🇬🇧"),
		Currency(code: "CHF", name: "Swiss Franc", flag: "🇨🇭"),
		Currency(code: "SEK", name: "Swedish Krona", flag: "🇸🇪"),
		Currency(code: "NOK", name: "Norwegian Krone", flag: "🇳🇴"),
		Currency(code: "DKK", name: "Danish Krone", flag: "🇩🇰"),
		Currency(code: "PLN", name: "Polish Zloty", flag: "🇵🇱"),
		Currency(code: "CZK", name: "Czech Koruna", flag: "🇨🇿"),
		Currency(code: "HUF", name: "Hungarian Forint", flag: "🇭🇺"),
		Currency(code: "RUB", name: "Russian Ruble", flag: "🇷🇺"),
		Currency(code: "RON", name: "Romanian Leu", flag: "🇷🇴"),
		Currency(code: "HRK", name: "Croatian Kuna", flag: "🇭🇷"),
		Currency(code: "BGN", name: "Bulgarian Lev", flag: "🇧🇬"),
		Currency(code: "TRY", name: "Turkish Lira", flag: "🇹🇷"),
		Currency(code: "ISK", name: "Icelandic Krona", flag: "🇮🇸"),
		Currency(code: "USD", name: "US Dollar", flag: "🇺🇸"),
		Currency(code: "JPY", name: "Japanese Yen", flag: "🇯🇵"),
		Currency(code: "AUD", name: "Australian Dollar", flag: "🇦🇺"),
		Currency(code: "CAD", name: "Canadian Dollar", flag: "🇨🇦"),
		Currency(code: "CNY", name: "Chinese Yuan", flag: "🇨🇳"),
		Currency(code: "INR", name: "Indian Rupee", flag: "🇮🇳"),
		Currency(code: "MXN", name: "Mexican Peso", flag: "🇲🇽"),
		Currency(code: "SGD", name: "Singapore Dollar", flag: "🇸🇬"),
		Currency(code: "NZD", name: "New Zealand Dollar", flag: "🇳🇿"),
		Currency(code: "KRW", name: "South Korean Won", flag: "🇰🇷"),
	]
}

#Preview {
	NavigationStack {
		RegionSettingsView()
	}
}

