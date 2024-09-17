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
	
	init() {
		_nightStartTime = State(initialValue: Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStartTimeslot)))
		_nightEndTime = State(initialValue: Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStoppTimeslot)))
	}
	
	@State private var nightStartTime: Date
	@State private var nightEndTime: Date
	private var nightPriceStartTimeslot: Date {
		return Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStartTimeslot))
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
				}
				.padding()
			} header: {
				Text(Localize.nightPricing)
					.padding(.leading)
			} footer: {
				Text(Localize.nightPricingFetchingDescription)
					.padding(.leading)
				//This will show the latest nightPRice recorded. You can also set it yourself if the fetchpricesDaily is set to off
			}
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
			.disabled(!isNightPrice)
			
			Section {
				CustomHourMinutePicker(selection: $nightStartTime, label: Localize.nightStart, systemImage: "moonrise")
				CustomHourMinutePicker(selection: $nightEndTime, label: Localize.nightEnd, systemImage: "moonset")
			} footer: {
//				Text(Localize.nightPricingDescription)
			}
			.disabled(!isNightPrice)
			.onChange(of: nightStartTime) { oldValue, newValue in
				let timestamp = Int(newValue.timeIntervalSince1970)
				UserDefaults.setNightPriceStartTimeslot(timestamp)
			}
			.onChange(of: nightEndTime) { oldValue, newValue in
				let timestamp = Int(newValue.timeIntervalSince1970)
				UserDefaults.setNightPriceStoppTimeslot(timestamp)
			}
			
		}
		.onAppear {
			nightPrice = UserDefaults.nightPrice
			nightStartTime = Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStartTimeslot))
			nightEndTime = Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStoppTimeslot))
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
