//
//  ElectricityPriceChartExtremePointMarkView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 11.09.24.
//

import SwiftUI
import Charts

struct ElectricityPriceChartExtremePointMarkView: View {
	let point: PricePoint
	let isMax: Bool
	let selectedRange: ElectricityPriceController.TimeRange
	
	var body: some View {
		Chart {
			PointMark(
				x: .value("Time", point.timestamp),
				y: .value("Price", point.price)
			)
			.symbolSize(100)
			.foregroundStyle(isMax ? .red : .green)
			.annotation {
				Text(point.price, format: .currency(code: UserDefaults.currency))
					.font(.system(.subheadline, design: .monospaced, weight: .semibold))
			}
			
			RuleMark(x: .value("Time", point.timestamp))
				.annotation {
					Group {
						switch selectedRange {
						case .day:
							Text(point.timestamp, format: .dateTime.hour())
						case .week:
							Text(point.timestamp, format: .dateTime.weekday(.abbreviated))
						case .month:
							Text(point.timestamp, format: .dateTime.day(.twoDigits))
						case .year:
							Text(point.timestamp, format: .dateTime.day(.twoDigits).month(.twoDigits).year(.twoDigits))
						}
					}
					.frame(width: 100)
				}
				.lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
				.foregroundStyle(.gray)
		}
	}
}

#Preview {
	ElectricityPriceChartExtremePointMarkView(point: PricePoint(timestamp: Date(), price: 0.1), isMax: true, selectedRange: .day)
}
