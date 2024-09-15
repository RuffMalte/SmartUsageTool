//
//  ElectricityPriceChartHeaderViewView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 14.09.24.
//

import SwiftUI

struct ElectricityPriceChartHeaderViewView: View {
	
	@State var maxPoint: PricePoint
	@State var minPoint: PricePoint
	
	@Binding var selectedRange: ElectricityPriceController.TimeRange
	@EnvironmentObject private var viewModel: ElectricityPriceController

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(Localize.range)
					.font(.system(.subheadline, design: .rounded, weight: .bold))
					.foregroundStyle(.secondary)
				
				HStack(alignment: .firstTextBaseline) {
					Text(minPoint.price.formatted(.number.precision(.fractionLength(5))))
					Text("/")
					Text(maxPoint.price.formatted(.number.precision(.fractionLength(5))))
					Text(UserDefaults.currency)
						.font(.system(.subheadline, design: .rounded, weight: .semibold))
						.foregroundStyle(.secondary)
				}
				.font(.system(.title, design: .monospaced, weight: .semibold))
				
				HStack {
					Text(viewModel.formattedCurrentDate(for: selectedRange))
				}
				.font(.system(.subheadline, design: .rounded, weight: .bold))
				.foregroundStyle(.secondary)
				
//				ElectricityPriceChartDateNavigationView(selectedRange: selectedRange)
//					.padding(5)
			}
			
			
			Spacer()
		}
		.onChange(of: selectedRange) { oldValue, newValue in
			if let (newMaxPoint, newMinPoint) = viewModel.findExtremePoints(for: selectedRange, in: viewModel.pricePoints) {
				withAnimation(.snappy) {	
					maxPoint = newMaxPoint
					minPoint = newMinPoint
				}
			}
		}
	}
}

#Preview {
	ElectricityPriceChartHeaderViewView(maxPoint: PricePoint(timestamp: Date(), price: 0), minPoint: PricePoint(timestamp: Date(), price: 0), selectedRange: .constant(.day))
		.withEnvironmentObjects()
}
