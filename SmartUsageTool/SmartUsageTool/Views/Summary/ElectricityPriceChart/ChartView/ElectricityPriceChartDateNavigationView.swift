//
//  ElectricityPriceChartDateNavigationView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 11.09.24.
//

import SwiftUI

struct ElectricityPriceChartDateNavigationView: View {
	@EnvironmentObject private var viewModel: ElectricityPriceController
	var selectedRange: ElectricityPriceController.TimeRange
	
	var body: some View {
		HStack {
			Button(action: { 
				withAnimation {
					viewModel.moveDate(by: -1, unit: calendarComponent(for: selectedRange))
				}
			}) {
				Image(systemName: "chevron.left")
			}
			.disabled(!viewModel.canMoveBackward(for: selectedRange))
			
			Spacer()
			
//			Text(viewModel.formattedCurrentDate(for: selectedRange))
//				.font(.headline)
//			
			Spacer()
			
			Button(action: {
				withAnimation {
					viewModel.moveDate(by: 1, unit: calendarComponent(for: selectedRange))
				}
			}) {
				Image(systemName: "chevron.right")
			}
			.disabled(!viewModel.canMoveForward(for: selectedRange))
		}
	}
	
	private func calendarComponent(for range: ElectricityPriceController.TimeRange) -> Calendar.Component {
		switch range {
		case .day, .week: return .day
		case .month: return .month
		case .year: return .year
		}
	}
}

#Preview {
	ElectricityPriceChartDateNavigationView(selectedRange: .day)
		.withEnvironmentObjects()
}
