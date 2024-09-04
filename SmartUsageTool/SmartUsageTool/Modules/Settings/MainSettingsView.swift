//
//  MainSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct MainSettingsView: View {
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
					RegionSettingsView()
				} label: {
					SettingsItemListView(icon: "globe.asia.australia", iconBackground: .orange, title: Localize.regionSettings)
				}
				NavigationLink {
					NightlyUsageSettingsView()
				} label: {
					SettingsItemListView(icon: "moon.stars", iconBackground: .green, title: Localize.nightlyUsage)
				}
				NavigationLink {
					DailyUsageSettingsView()
				} label: {
					SettingsItemListView(icon: "sun.max", iconBackground: .mint, title: Localize.dailyUsage)
				}
			}
			
			Section {
				NavigationLink {
					SettingsAboutAppView()
				} label: {
					SettingsItemListView(icon: "info.circle", iconBackground: .blue, title: Localize.about)
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		MainSettingsView()
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
