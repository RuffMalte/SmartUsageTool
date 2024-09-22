//
//  SummaryMainView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 14.09.24.
//

import SwiftUI
import Charts
import SwiftData
import TipKit

struct SummaryMainView: View {
	
	@EnvironmentObject private var viewModel: ElectricityPriceController
	@EnvironmentObject private var electricityMapsApiController: ElectricityMapsAPIController
	
	@Query private var devices: [DeviceModel]
	@Query private var rooms: [RoomModel]

    var body: some View {
		NavigationView {
			VStack(spacing: 10) {
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
					
					
					Section {
						if let mostExpensiveRoom = HomeCalculationsController().getMostExpensiveRoom(rooms: rooms) {
							NavigationLink {
								RoomsPricesChartView()
							} label: {
								SummaryItemListView(
									title: Localize.mostExpensiveRooms,
									icon: "square.split.bottomrightquarter",
									titleColor: .mint,
									latestDate: Date(),
									latestValueView: AnyView(
										VStack(alignment: .leading) {
											Text(Localize.mostExpensive)
												.font(.system(.subheadline, design: .rounded, weight: .semibold))
												.foregroundStyle(.secondary)
											
											HStack(alignment: .firstTextBaseline) {
												Text(NSLocalizedString(mostExpensiveRoom.name.capitalized, comment: ""))
													.font(.system(.title2, design: .monospaced, weight: .bold))
											}
										}
									),
									chartView: AnyView(
										VStack(alignment: .trailing) {
											HStack(alignment: .lastTextBaseline) {
												Text(HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: mostExpensiveRoom), format: .currency(code: UserDefaults.currency))
													.font(.system(.title2, design: .monospaced, weight: .semibold))
											}
										}
									)
								)
							}
						}
					}
					
					Section {
						TipView(getMoreStatistics())
							.tipBackground(Color.clear)
					}
					.listRowInsets(EdgeInsets())
					
					
					Section {
						if let currentCarbonIntensityData = electricityMapsApiController.currentCarbonIntensityData {
							NavigationLink {
								DevicesCarbonFootPrintChartView()
							} label: {
								SummaryItemListView(
									title: Localize.devicesCarbonFootprint,
									icon: "carbon.dioxide.cloud",
									titleColor: .purple,
									latestDate: currentCarbonIntensityData.datetimeAsDate ?? Date(),
									latestValueView: AnyView(
										VStack(alignment: .leading) {
											Text(Localize.latest)
												.font(.system(.subheadline, design: .rounded, weight: .semibold))
												.foregroundStyle(.secondary)
											
											HStack(alignment: .firstTextBaseline) {
												Text(currentCarbonIntensityData.carbonIntensity, format: .number.precision(.fractionLength(2)))
													.font(.system(.title2, design: .monospaced, weight: .bold))
												
												Text("gCO2eq/kWh")
													.foregroundStyle(.secondary)
													.font(.system(.footnote))
											}
										}
									),
									chartView: AnyView(
										VStack {
											Chart(electricityMapsApiController.calculateDevicesCarbonIntensity(devices: devices)) { point in
												SectorMark(
													angle: .value("Amount", point.calculatedCarbonIntensity),
													angularInset: 3.0
												)
												.cornerRadius(2)
												.foregroundStyle(by: .value("device", point.device.name))
											}
											.chartLegend(.hidden)
											
										}
									)
								)
							}
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
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.background.gradient)
				.shadow(radius: 10)
		}
	}
}

#Preview {
	SummaryMainView()
		.withEnvironmentObjects()
}
