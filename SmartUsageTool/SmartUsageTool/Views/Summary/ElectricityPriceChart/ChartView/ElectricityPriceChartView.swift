//
//  ElectricityPriceChartView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import SwiftUI
import Charts

struct ElectricityPriceChartView: View {
	@EnvironmentObject private var viewModel: ElectricityPriceController
	@State private var selectedRange: ElectricityPriceController.TimeRange = .day
	
	@State private var isShowingDetailSheet: Bool = false
	
	@State  private var currentMaxPoint: PricePoint?
	@State  private var currentMinPoint: PricePoint?
	
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
					if let (maxPoint, minPoint) = viewModel.findExtremePoints(for: selectedRange, in: viewModel.pricePoints) {
						ElectricityPriceChartHeaderViewView(maxPoint: maxPoint, minPoint: minPoint, selectedRange: $selectedRange)
					}
				}
				ElectricityPriceChartCreationView(selectedRange: $selectedRange)
				
//				if selectedRange != .year {
//					ElectricityPriceChartDateNavigationView(selectedRange: selectedRange)
//				} else {
//					Text(viewModel.formattedCurrentDate(for: .year))
//						.font(.headline)
//						.padding()
//				}
				
				if let currentPricePricePoint = viewModel.currentPricePricePoint {
					HStack {
						Text(Localize.latest + ":")
						Text(currentPricePricePoint.timestamp, format: .dateTime.hour().minute(.twoDigits))
						Spacer()
						Text(currentPricePricePoint.price, format: .number.precision(.fractionLength(5)))
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
				
				Button {
					isShowingDetailSheet.toggle()
				} label: {
					Text(Localize.showMoreData)
						.bold()
				}
				
				
			}
		}
		.onAppear {
			viewModel.currentDate = Date()
		}
		.padding()
		.sheet(isPresented: $isShowingDetailSheet) {
			Text("add detail")
		}
	}
}

#Preview {
    ElectricityPriceChartView()
		.withEnvironmentObjects()
}
