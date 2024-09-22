//
//  RoomPricesTableViewSmall.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import SwiftUI
import SwiftData

struct RoomPricesTableViewSmall: View {
	@Query private var rooms: [RoomModel]
	
	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				LazyVGrid(columns: columns, spacing: 0) {
					Text(Localize.rooms)
						.frame(maxWidth: .infinity)
					Text(UserDefaults.currency)
						.frame(maxWidth: .infinity)
						
				}
				.font(.system(.headline, design: .rounded, weight: .bold))
				.padding()
				.foregroundStyle(.tint)
				.background(.bar)
				
				ScrollView {
					LazyVGrid(columns: columns, spacing: 0) {
						ForEach(rooms) { room in
							Text(NSLocalizedString(room.name.capitalized, comment: ""))
								.frame(maxWidth: .infinity)
								.padding()
								.font(.system(.subheadline, design: .default, weight: .regular))
								
							Text(HomeCalculationsController().getRoomPriceBasedOnTimePeriod(room: room), format: .currency(code: UserDefaults.currency))
								.frame(maxWidth: .infinity)
								.padding()
								.font(.system(.subheadline, design: .monospaced, weight: .regular))
						}
					}

				}
			}
		}
	}
}
