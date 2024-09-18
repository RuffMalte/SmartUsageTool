//
//  SummaryMainView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 14.09.24.
//

import SwiftUI
import Charts
import SwiftData

struct SummaryMainView: View {
	
	@EnvironmentObject private var viewModel: ElectricityPriceController
	
	@Query private var devices: [DeviceModel]
    var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				headerView
				Form {
					Section {
						if let currentPricePricePoint = viewModel.currentPricePricePoint {
							NavigationLink {
								ElectricityPriceHomeView()
							} label: {
								SummaryItemListView(
									title: Localize.electricityPrice,
									icon: "bolt.fill",
									titleColor: .yellow,
									latestDate: currentPricePricePoint.timestamp,
									latestValueView: AnyView(
										VStack(alignment: .leading) {
											Text(Localize.latest)
												.font(.system(.subheadline, design: .rounded, weight: .semibold))
												.foregroundStyle(.secondary)
											
											HStack(alignment: .firstTextBaseline) {
												Text(currentPricePricePoint.price, format: .number)
													.font(.system(.title2, design: .monospaced, weight: .bold))
												
												Text(UserDefaults.currency)
													.foregroundStyle(.secondary)
													.font(.system(.footnote))
											}
										}
									),
									chartView: AnyView(
										VStack {
											Chart(viewModel.aggregatedPricePoints(for: .day)) { point in
												LineMark(
													x: .value("Time", point.timestamp),
													y: .value("Price", point.price)
												)
												.interpolationMethod(.catmullRom)
												.lineStyle(StrokeStyle(lineWidth: 3))
												.foregroundStyle(.yellow)
											}
											.chartXAxis(.hidden)
											.chartYAxis(.hidden)
										}
									)
								)
							}
							.popoverTip(CurrentEnergyPriceTip())
						}
					}
					
					Section {
						if let lastDevicePrice = viewModel.calculateDevicePrices(for: devices, range: .week).last?.price {
							NavigationLink {
								DevicesPriceHomeView()
							} label: {
								SummaryItemListView(
									title: Localize.devicePrices,
									icon: "dollarsign",
									titleColor: .green,
									latestDate: Date(),
									latestValueView: AnyView(
										VStack(alignment: .leading) {
											Text(Localize.latest)
												.font(.system(.subheadline, design: .rounded, weight: .semibold))
												.foregroundStyle(.secondary)
											
											HStack(alignment: .firstTextBaseline) {
												Text(lastDevicePrice, format: .number.precision(.fractionLength(2)))
													.font(.system(.title2, design: .monospaced, weight: .bold))
												
												Text(UserDefaults.currency)
													.foregroundStyle(.secondary)
													.font(.system(.footnote))
											}
										}
									),
									chartView: AnyView(
										VStack {
											Chart(viewModel.calculateDevicePrices(for: devices, range: .day)) { point in
												LineMark(
													x: .value("Time", point.timestamp),
													y: .value("Price", point.price)
												)
												.interpolationMethod(.catmullRom)
												.lineStyle(StrokeStyle(lineWidth: 3))
												.foregroundStyle(.green)
											}
											.chartXAxis(.hidden)
											.chartYAxis(.hidden)
										}
									)
								)
							}
							.popoverTip(CurrentDevicePricesTip())
						}
					}
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					HStack {
						NavigationLink {
							MainSettingsView()
						} label: {
							Image(systemName: "gearshape.fill")
						}
					}
				}
			}
		}
    }
	var headerView: some View {
		HStack {
			Text(Localize.summary)
			.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background(Color.background)
	}
}

#Preview {
	SummaryMainView()
		.withEnvironmentObjects()
}
