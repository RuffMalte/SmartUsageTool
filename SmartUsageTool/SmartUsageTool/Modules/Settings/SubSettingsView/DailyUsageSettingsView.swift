//
//  DailyUsageSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct DailyUsageSettingsView: View {
	@State private var dayPrice = UserDefaults.dayPrice
	@State private var currencyCode = UserDefaults.currency

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
	
	var body: some View {
		Form {
			Section {
				HStack {
					TextField(Localize.dailyUsage, text: dayPriceString)
						.padding()
						.background(.white)
						.clipShape(.rect(cornerRadius: 10))
						.keyboardType(.decimalPad)
						.onChange(of: dayPrice) { oldValue, newValue in
							dayPrice = newValue
							dayPriceString.wrappedValue = String(format: "%.5f", newValue)
							UserDefaults.setDay(price: newValue)
						}
					Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")")
						.font(.system(.headline, design: .default, weight: .regular))
						.foregroundStyle(.secondary)
						.padding()
				}
			} header: {
				Text(Localize.dailyUsage)
			}
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
		}
		.onAppear {
			dayPrice = UserDefaults.dayPrice
		}
		.navigationTitle(Localize.dailyUsage)
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button {
					dismissKeyboard()
				} label: {
					Image(systemName: "keyboard.chevron.compact.down")
				}
				Spacer()
				Button {
					UserDefaults.setDay(price: dayPrice)
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
    DailyUsageSettingsView()
}
