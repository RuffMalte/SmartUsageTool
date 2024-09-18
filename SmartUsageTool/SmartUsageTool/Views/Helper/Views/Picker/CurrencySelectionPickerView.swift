//
//  CurrencySelectionPickerView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import SwiftUI

struct CurrencySelectionPickerView: View {
	
	@State var selectedCurrency: Currency?
	@State private var isShowingCurrencyExplanation = false
	@Environment(\.dismiss) var dismiss
	var onCurrencySelected: ((String) -> Void)?

	var body: some View {
		NavigationStack {
			Form {
				Picker(selection: $selectedCurrency) {
					ForEach(Currency.currencies) { currency in
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
						
						.tag(currency)
					}
				} label: {
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
				.pickerStyle(.inline)
				.onAppear {
					selectedCurrency = Currency.currencies.first { $0.code == UserDefaults.currency }
				}
				.onChange(of: selectedCurrency, { oldValue, newValue in
					if let selectedCurrency = newValue {
						withAnimation {
							UserDefaults.setCurrency(selectedCurrency.code)
							onCurrencySelected?(selectedCurrency.code)
						}
					}
				})
				.navigationTitle(Localize.regionSettings)
				.navigationBarTitleDisplayMode(.inline)
			}
		}
	}
}

#Preview {
	CurrencySelectionPickerView()
}
