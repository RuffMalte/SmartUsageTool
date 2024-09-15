//
//  ElectricityPriceHomeView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import SwiftUI

struct ElectricityPriceHomeView: View {
    var body: some View {
		VStack {
			headerView
			ScrollView(.vertical) {
				ElectricityPriceChartView()
			}
			.navigationBarTitleDisplayMode(.inline)
		}
    }
	var headerView: some View {
		HStack {
			Text(Localize.electricityPrice)
				.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background(Color.yellow.gradient.quaternary)
	}
}

#Preview {
	ElectricityPriceHomeView()
		.withEnvironmentObjects()
}
