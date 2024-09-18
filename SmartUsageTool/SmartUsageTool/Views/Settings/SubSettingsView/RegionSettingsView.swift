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
					selectedCurrency = Currency.currencies.first { $0.code == UserDefaults.currency }
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
			return Currency.currencies
		} else {
			return Currency.currencies.filter { currency in
				currency.code.lowercased().contains(searchText.lowercased()) ||
				currency.name.lowercased().contains(searchText.lowercased())
			}
		}
	}
	
	private func getCurrentCode() -> String {
		let code = UserDefaults.currency
		return code
	}
}

#Preview {
	NavigationStack {
		RegionSettingsView()
	}
}

