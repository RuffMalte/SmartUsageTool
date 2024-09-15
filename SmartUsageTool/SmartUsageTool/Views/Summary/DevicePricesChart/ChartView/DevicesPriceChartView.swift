//
//  DevicesPriceChartView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 15.09.24.
//

import SwiftUI
import Charts
import SwiftData

struct DevicesPriceChartView: View {
	@EnvironmentObject private var viewModel: ElectricityPriceController
	@State private var selectedRange: ElectricityPriceController.TimeRange = .week
	
	@Query private var devices: [DeviceModel]
	
	@State private var isShowingDetailSheet: Bool = false
	
	var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView("Loading...")
					.frame(height: 300)
			} else if let error = viewModel.error {
				Text("Error: \(error.localizedDescription)")
			} else {
				ChartRangePickerView(selectedRange: $selectedRange)
				
				Group {
					if let (maxPoint, minPoint) = viewModel.findExtremePoints(for: selectedRange, in: viewModel.calculateDevicePrices(for: devices, range: selectedRange)) {
						DevicesPriceChartHeaderView(maxPoint: maxPoint, minPoint: minPoint, selectedRange: $selectedRange)
					}
				}
				
				DevicesPriceChartCreationView(selectedRange: $selectedRange)
				
				if let currentPricePricePoint = viewModel.calculateDevicePrices(for: devices, range: selectedRange).last {
					HStack {
						Text(Localize.latest + ":")
						Text(Date(), format: .dateTime.hour().minute(.twoDigits))
						Spacer()
						Text(currentPricePricePoint.price, format: .number.precision(.fractionLength(2)))
							.bold()
						Text(UserDefaults.currency)
							.foregroundStyle(.secondary)
					}
					.font(.system(.footnote, design: .default))
					.padding()
					.background(.bar)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.padding(.vertical)
				}
				
				Button(Localize.showMoreData) {
					isShowingDetailSheet.toggle()
				}
				
				
				
			}
		}
		.padding()
		.sheet(isPresented: $isShowingDetailSheet) {
//			DevicesPriceChartDetailView(selectedRange: $selectedRange)
		}
	}
}

#Preview {
	DevicesPriceChartView()
		.withEnvironmentObjects()
}
