//
//  DevicesPriceHomeView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 15.09.24.
//

import SwiftUI

struct DevicesPriceHomeView: View {
	var body: some View {
		VStack {
			headerView
			ScrollView(.vertical) {
				DevicesPriceChartView()
			}
			.navigationBarTitleDisplayMode(.inline)
		}
	}
	var headerView: some View {
		HStack {
			Text(Localize.devicePrice)
				.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background(Color.green.gradient.quaternary)
	}
}

#Preview {
    DevicesPriceHomeView()
		.withEnvironmentObjects()
}
