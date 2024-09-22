//
//  TimeRangeChartView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import SwiftUI
import SwiftData
import Charts

struct TimeRangeChartView: View {
	@Query private var rooms: [RoomModel]

    var body: some View {
		VStack {
			headerView
			ScrollView(.vertical) {
				VStack(spacing: 30) {
					VStack(alignment: .leading) {
						Label {
							Text(Localize.projectedYearlyCost)
						} icon: {
							Image(systemName: "fireworks")
						}
						.fontWeight(.semibold)
						
						HStack {
							Text(HomeCalculationsController().getTotalYearlyExpenses(rooms: rooms), format: .number.precision(.fractionLength(2)))
								.font(.system(.headline, design: .monospaced, weight: .regular))
							Spacer()
							Text(UserDefaults.currency)
								.foregroundStyle(.secondary)
						}
						.padding()
						.background(.bar)
						.clipShape(.rect(cornerRadius: 10))
					}
					
					
					VStack(alignment: .leading) {
						Label {
							Text(Localize.monthlyCost)
						} icon: {
							Image(systemName: "calendar")
						}
						.fontWeight(.semibold)
						
						HStack {
							Text(HomeCalculationsController().getTotalMonthlyCost(rooms: rooms), format: .number.precision(.fractionLength(2)))
								.font(.system(.headline, design: .monospaced, weight: .regular))
							Spacer()
							Text(UserDefaults.currency)
								.foregroundStyle(.secondary)
						}
						.padding()
						.background(.bar)
						.clipShape(.rect(cornerRadius: 10))
					}
					
					VStack(alignment: .leading) {
						Label {
							Text(Localize.dailyCost)
						} icon: {
							Image(systemName: "1.square")
						}
						.fontWeight(.semibold)
						
						HStack {
							Text(HomeCalculationsController().getTotalDailyCoast(rooms: rooms), format: .number.precision(.fractionLength(2)))
								.font(.system(.headline, design: .monospaced, weight: .regular))
							Spacer()
							Text(UserDefaults.currency)
								.foregroundStyle(.secondary)
						}
						.padding()
						.background(.bar)
						.clipShape(.rect(cornerRadius: 10))
					}
					
					
					
					
				}
			}
			.padding()
			.navigationBarTitleDisplayMode(.inline)
		}
    }
	var headerView: some View {
		HStack {
			Text(Localize.projectedYearlyCost)
				.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.orange.gradient.quaternary)
				.shadow(radius: 10)
		}
	}
}

#Preview {
    TimeRangeChartView()
}
