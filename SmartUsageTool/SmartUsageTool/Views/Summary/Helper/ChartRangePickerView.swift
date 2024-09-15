//
//  ElectricityPriceChartRangePickerView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 11.09.24.
//

import SwiftUI

struct ChartRangePickerView: View {
	@Binding var selectedRange: ElectricityPriceController.TimeRange
	
	var body: some View {
		Picker("Time Range", selection: $selectedRange) {
			ForEach(ElectricityPriceController.TimeRange.allCases) { range in
				withAnimation {
					Text(range.localisedString).tag(range)
				}
			}
		}
		.pickerStyle(.segmented)
	}
}

#Preview {
	ChartRangePickerView(selectedRange: .constant(.day))
}
