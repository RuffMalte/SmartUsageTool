//
//  DevicesCarbonFootPrintChartView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import SwiftUI
import SwiftData
import Charts

struct DevicesCarbonFootPrintChartView: View {
	
	@EnvironmentObject private var electricityMapsApiController: ElectricityMapsAPIController
	@Query private var devices: [DeviceModel]

	@State private var devicesCarbonFootprint: [DeviceCarbonIntensityModel] = []
	
	@State private var isShowingDetailSheet: Bool = false

    var body: some View {
		VStack {
			headerView
			ScrollView(.vertical) {
				
				HStack {
					VStack(alignment: .leading) {
						Text(Localize.range)
							.font(.system(.subheadline, design: .rounded, weight: .bold))
							.foregroundStyle(.secondary)
						
						HStack(alignment: .firstTextBaseline) {
							Text(getMaxAndMinValues(from: devicesCarbonFootprint).min, format: .number.precision(.fractionLength(2)))
							Text("/")
							Text(getMaxAndMinValues(from: devicesCarbonFootprint).max, format: .number.precision(.fractionLength(2)))
							Text("gCO2")
								.font(.system(.subheadline, design: .rounded, weight: .semibold))
								.foregroundStyle(.secondary)
						}
						.font(.system(.title, design: .monospaced, weight: .semibold))
						
						HStack {
							Text(Date(), format: .dateTime.hour().minute())
						}
						.font(.system(.subheadline, design: .rounded, weight: .bold))
						.foregroundStyle(.secondary)
					}
					
					
					Spacer()
				}
				
				
				
				VStack {
					Chart(devicesCarbonFootprint) { point in
						SectorMark(
							angle: .value("Amount", point.calculatedCarbonIntensity),
							angularInset: 3.0
						)
						.cornerRadius(6)
						.foregroundStyle(by: .value("device", point.device.name))
					}
					.scaledToFit()
					
				}
				
				if let latestValue = electricityMapsApiController.currentCarbonIntensityData {
					HStack {
						Text(Localize.latest + ":")
						Text(Date(), format: .dateTime.hour().minute(.twoDigits))
						Spacer()
						Text(latestValue.carbonIntensity, format: .number.precision(.fractionLength(2)))
							.bold()
						Text("gCO2eq/kWh")
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
				
				GroupBox {
					HStack {
						VStack(alignment: .leading) {
						
							Text(Localize.UnderstandingYourCarbonFootprint)
								.font(.system(.body, design: .default, weight: .regular))
						}
						Spacer()
					}
				} label: {
					Label(Localize.info, systemImage: "info.circle")
						.font(.system(.title3, design: .rounded, weight: .bold))
						.foregroundStyle(.tint)
				}
				.padding(.top)
				
			}
			.padding()
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				devicesCarbonFootprint = electricityMapsApiController.calculateDevicesCarbonIntensity(devices: devices)
			}
			.sheet(isPresented: $isShowingDetailSheet) {
				DevicesCarbonFootPrintTableView()
					.presentationDetents([.medium, .large])
			}
		}
    }
	var headerView: some View {
		HStack {
			Text(Localize.devicesCarbonFootprint)
				.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.purple.gradient.quaternary)
				.shadow(radius: 10)
		}
	}
	
	func getMaxAndMinValues(from devices: [DeviceCarbonIntensityModel]) -> (max: Double, min: Double) {
		guard !devices.isEmpty else {
			return (max: 0.0, min: 0.0)
		}
		
		let maxIntensity = devices.max { $0.calculatedCarbonIntensity < $1.calculatedCarbonIntensity }!.calculatedCarbonIntensity
		let minIntensity = devices.min { $0.calculatedCarbonIntensity < $1.calculatedCarbonIntensity }!.calculatedCarbonIntensity
		
		return (max: maxIntensity, min: minIntensity)
	}
}
	
#Preview {
    DevicesCarbonFootPrintChartView()
		.withEnvironmentObjects()
}
