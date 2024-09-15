//
//  DevicesPriceChartCreationView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 15.09.24.
//

import SwiftUI
import Charts
import SwiftData

struct DevicesPriceChartCreationView: View {
	
	@Binding var selectedRange: ElectricityPriceController.TimeRange
	@EnvironmentObject private var viewModel: ElectricityPriceController
	@Query private var devices: [DeviceModel]
	
    var body: some View {
		Chart(viewModel.calculateDevicePrices(for: devices, range: selectedRange)) { point in
			LineMark(
				x: .value("Time", point.timestamp),
				y: .value("Price", point.price)
			)
			.interpolationMethod(.catmullRom)
			.foregroundStyle(.green)
		}
		.chartXAxis {
			AxisMarks(values: .automatic()) { value in
				AxisGridLine()
				AxisTick()
				AxisValueLabel {
					if let date = value.as(Date.self) {
						switch selectedRange {
						case .day:
							Text(date, format: .dateTime.hour())
						case .week:
							Text(date, format: .dateTime.weekday(.abbreviated))
						case .month:
							Text(date, format: .dateTime.day())
						case .year:
							Text(date, format: .dateTime.month(.abbreviated))
						}
					}
				}
			}
		}
		.chartYAxis {
			AxisMarks(position: .leading) { value in
				AxisGridLine()
				AxisTick()
				AxisValueLabel {
					if let price = value.as(Double.self) {
						Text(price, format: .currency(code: UserDefaults.currency))
					}
				}
			}
		}
		.frame(height: 300)
    }
}

#Preview {
	DevicesPriceChartCreationView(selectedRange: .constant(.week))
		.withEnvironmentObjects()
}
