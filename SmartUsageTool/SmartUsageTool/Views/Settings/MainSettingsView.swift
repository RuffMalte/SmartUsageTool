//
//  MainSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct MainSettingsView: View {
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue

	var body: some View {
		VStack {
			settingsScrollView
			
			.navigationTitle(Localize.settings)
		}
	}
	
	var settingsScrollView: some View {
		List {
			Section {
				NavigationLink {
					CurrencySelectionPickerView()
				} label: {
					SettingsItemListView(icon: "globe.asia.australia", iconBackground: .orange, title: Localize.regionSettings)
				}
			}
			
			Section {
				NavigationLink {
					PriceFetchingSettingsView()
				} label: {
					SettingsItemListView(icon: "dollarsign.arrow.circlepath", iconBackground: .indigo, title: Localize.priceFetchingSettings)
				}
				
				NavigationLink {
					DailyUsageSettingsView()
				} label: {
					SettingsItemListView(icon: "sun.max", iconBackground: .red, title: Localize.dailyUsage)
				}
				
				NavigationLink {
					NightlyUsageSettingsView()
				} label: {
					SettingsItemListView(icon: "moon.stars", iconBackground: .green, title: Localize.nightlyUsage)
				}
				
				NavigationLink {
					ContractLengthSettingsView()
				} label: {
					SettingsItemListView(icon: "clock.arrow.2.circlepath", iconBackground: .yellow, title: Localize.contractMangement)
				}

			}
			
			Section {
				ColorPicker(selectedColor: $selectedTintColor)
			}
			
			Section {
				NavigationLink {
					SettingsAboutAppView()
				} label: {
					SettingsItemListView(icon: "info.circle", iconBackground: .blue, title: Localize.about)
				}
				ContactUsView()
			}
			
			Section {
				NavigationLink {
					DangerousSettingsView()
				} label: {
					SettingsItemListView(icon: "trash", iconBackground: .red, title: Localize.dangerousSettings)
						.foregroundStyle(.red)
				}

			}
		}
	}
}

#Preview {
	NavigationStack {
		MainSettingsView()
			.withEnvironmentObjects()
	}
}


struct SettingsItemListView: View {
	
	var icon: String
	var iconBackground: Color
	var title: String
	
	var body: some View {
		HStack {
			ZStack {
				RoundedRectangle(cornerRadius: 5)
					.frame(width: 30, height: 30)
					.foregroundStyle(iconBackground)
				
				Image(systemName: icon)
					.foregroundStyle(.white)
					.font(.title3)
				
			}
			
			Text(title)
		}
	}
}

#Preview {
	SettingsItemListView(icon: "gearshape", iconBackground: .gray, title: "General")
}
