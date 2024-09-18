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
	
	@EnvironmentObject private var viewModel: ElectricityPriceController
	
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
						.keyboardType(.decimalPad)
						.onChange(of: dayPrice) { oldValue, newValue in
							dayPrice = newValue
							dayPriceString.wrappedValue = String(format: "%.5f", newValue)
							UserDefaults.setDay(price: newValue)
						}
						.onChange(of: viewModel.isLoading) { oldValue, newValue in
							if let currentPrice = viewModel.currentPrice, !newValue {
								withAnimation {
									dayPriceString.wrappedValue = String(format: "%.5f", currentPrice)
									print("Current price: \(currentPrice)")
									UserDefaults.setDay(price: currentPrice)
								}
							}
						}
						
					Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")")
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
			
			
//			Section {
//				Button {
//					viewModel.fetchCurrentPrice()
//				} label: {
//					if viewModel.isLoading {
//						ProgressView()
//					} else {
//						Text("Fetch")
//					}
//				}
//			}
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
		.withEnvironmentObjects()
}
