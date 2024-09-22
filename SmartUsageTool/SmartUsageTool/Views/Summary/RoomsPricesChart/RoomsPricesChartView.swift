//
//  RoomsPricesChartView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import SwiftUI
import SwiftData
import Charts

struct RoomsPricesChartView: View {
	
	@EnvironmentObject private var electricityMapsApiController: ElectricityMapsAPIController
	@Query private var devices: [DeviceModel]
	@Query private var rooms: [RoomModel]

	@State private var devicesCarbonFootprint: [DeviceCarbonIntensityModel] = []
	
	@State private var isShowingDetailSheet: Bool = false

    var body: some View {
		VStack {
			headerView
			ScrollView(.vertical) {
				
				HStack {
					if let (most, least) = HomeCalculationsController().getMostAndLeastExpensiveRoom(rooms: rooms) {
						VStack(alignment: .leading) {
							Text(Localize.range)
								.font(.system(.subheadline, design: .rounded, weight: .bold))
								.foregroundStyle(.secondary)
							
							HStack(alignment: .firstTextBaseline) {
								Text(HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: least), format: .number.precision(.fractionLength(2)))
								Text("/")
								Text(HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: most), format: .number.precision(.fractionLength(2)))
								Text(UserDefaults.currency)
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
				}
				
				
				
				VStack {
					Chart(rooms) { point in
						SectorMark(
							angle: .value("Amount", HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: point)),
							angularInset: 3.0
						)
						.cornerRadius(6)
						.foregroundStyle(by: .value("device", NSLocalizedString(point.name.capitalized, comment: "")))
					}
					.scaledToFit()
					
				}
				
				if let mostExpensiveRoom = HomeCalculationsController().getMostExpensiveRoom(rooms: rooms) {
					HStack {
						Text(Localize.mostExpensive + ":")
						Text(NSLocalizedString(mostExpensiveRoom.name.capitalized, comment: ""))
						Spacer()
						Text(HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: mostExpensiveRoom), format: .number.precision(.fractionLength(2)))
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
			.padding()
			.navigationBarTitleDisplayMode(.inline)
			
			.sheet(isPresented: $isShowingDetailSheet) {
				RoomPricesTableViewSmall()
					.presentationDetents([.medium, .large])
			}
		}
    }
	var headerView: some View {
		HStack {
			Text(Localize.rooms)
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
}
