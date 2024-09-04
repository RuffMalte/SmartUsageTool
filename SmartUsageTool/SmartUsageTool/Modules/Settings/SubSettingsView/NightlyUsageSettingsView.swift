//
//  NightlyUsageSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct NightlyUsageSettingsView: View {
	@State private var isNightPrice = UserDefaults.isNightPrice
	@State private var nightPrice = UserDefaults.nightPrice
	@State private var currencyCode = UserDefaults.currency

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
	
	var body: some View {
		Form {
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
			} footer: {
				Text(Localize.nightlyUsageDescription)
			}
			
			Section {
				HStack {
					TextField(Localize.nightlyUsage, text: nightPriceString)
						.padding()
						.background(.white)
						.clipShape(.rect(cornerRadius: 10))
						.keyboardType(.decimalPad)
						.disabled(!isNightPrice)
						.onChange(of: nightPrice) { oldValue, newValue in
							nightPrice = newValue
							UserDefaults.setNight(price: newValue)
							nightPriceString.wrappedValue = String(format: "%.5f", newValue)
						}
					Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")")
						.font(.system(.headline, design: .default, weight: .regular))
						.foregroundStyle(.secondary)
						.padding()
				}
			} header: {
				Text(Localize.nightPricing)
			}
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
		}
		.onAppear {
			nightPrice = UserDefaults.nightPrice
		}
		.navigationTitle(Localize.nightlyUsage)
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button {
					dismissKeyboard()
				} label: {
					Image(systemName: "keyboard.chevron.compact.down")
				}
				Spacer()
				Button {
					UserDefaults.setNight(price: nightPrice)
					dismissKeyboard()
				} label: {
					Image(systemName: "square.and.arrow.down")
				}
			}
		}
	}
	
	private func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	NavigationStack {
		NightlyUsageSettingsView()
			.navigationTitle(Localize.nightlyUsage)
	}
}
