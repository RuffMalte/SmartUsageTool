//
//  ListView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
	@Query private var items: [RoomModel]
	
	private var totalCost: Double {
		let sum = items.reduce(0.0) { $0 + $1.dailyExpenses }
		return sum
	}
	var body: some View {
		contentView
	}
}

private extension ListView {
	
	var contentView: some View {
		VStack {
			headerView
			//            Spacer()
			listView
		}
	}
	
	var headerView: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack {
				Text(Localize.list)
					.font(.system(.largeTitle, weight: .semibold))
				
				Spacer()
				Text(totalCost, format: .currency(code: UserDefaults.currency))
					.font(.system(.title2, design: .monospaced, weight: .semibold))
				
			}
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.background.gradient)
				.shadow(radius: 10)
		}
	}
	
	var listView: some View {
		List {
			ForEach(items) { room in
				Section {
					ForEach(room.devices) { device in
						VStack {
							HStack {
								Text(device.name)
									.font(.headline)
								Spacer()
								Text(device.expenses, format: .currency(code: UserDefaults.currency))
									.fontDesign(.monospaced)
							}
							.font(.subheadline)
							.foregroundColor(.secondary)
							
							HStack(alignment: .top) {
								VStack(alignment: .leading) {
									Text(Localize.dailyUsage)
									Text("\(device.doubleFormattedDayTime, specifier: "%.1f") \(Localize.hrs)")
										.fontDesign(.monospaced)
								}
								Spacer()
								if UserDefaults.isNightPrice {
									VStack(alignment: .leading) {
										Text(Localize.nightlyUsage)
										Text("\(device.doubleFormattedNightTime, specifier: "%.1f") \(Localize.hrs)")
											.fontDesign(.monospaced)
									}
									Spacer()
								}
								
								VStack(alignment: .leading) {
									Text(Localize.power)
									Text("\(device.power) \(Localize.w)")
										.fontDesign(.monospaced)
								}
							}
							.font(.subheadline)
							.foregroundStyle(.tertiary)
							.padding([.top, .leading])
						}
						
					}
				} header: {
					HStack {
						Text(NSLocalizedString(room.name.capitalized, comment: ""))
							.font(.title)
						Spacer()
						Text(room.dailyExpenses, format: .currency(code: UserDefaults.currency))
							.font(.system(.headline, design: .monospaced, weight: .regular))
					}
					.foregroundStyle(.primary)
				}
			}
		}
		.listStyle(.plain)
		
	}
}

#Preview {
	ListView()
}
