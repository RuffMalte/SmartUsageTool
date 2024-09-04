//
//  SettingsAboutAppView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 03.09.24.
//

import SwiftUI

struct SettingsAboutAppView: View {
	var body: some View {
		Form {
			
			HStack {
				Spacer()
				VStack(alignment: .center) {
					Text(Localize.appName)
						.font(.system(.title, design: .rounded, weight: .bold))
						.foregroundStyle(.primary)
					HStack {
						Text(Localize.appVersion)
						getCurrentVersion()
					}
					.foregroundStyle(.secondary)
					
					Text(Localize.appBy)
						.foregroundStyle(.secondary)
					
				}
				Spacer()
			}
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
			.listRowBackground(Color.clear)
			
			Section {
//				Link("Privacy Policy", destination: URL(string: "")!)
			}
			
			Section {
				
			} header: {
				Text(Localize.appIcludedLibs)
					.font(.system(.caption, design: .rounded, weight: .semibold))
			}
			.navigationTitle(Localize.about)
			.navigationBarTitleDisplayMode(.inline)
		}
	}
	func getCurrentVersion() -> Text {
		let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
		return Text(version)
	}
	func getCurrentAppLanguage() -> String {
		let language = Bundle.main.preferredLocalizations.first ?? "Unknown"
		return language
	}
}

#Preview {
	NavigationStack {
		SettingsAboutAppView()
	}
}
