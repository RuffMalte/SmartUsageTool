//
//  SummaryItemListView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 14.09.24.
//

import SwiftUI

struct SummaryItemListView: View {
	
	var title: String
	var icon: String
	var titleColor: Color
	var latestDate: Date
	var latestValueView: AnyView
	var chartView: AnyView
	
    var body: some View {
		VStack(alignment: .leading) {
			
			HStack {
				Label(title, systemImage: icon)
					.font(.headline)
					.foregroundStyle(titleColor.gradient)
				
				Spacer()
				
				Text(latestDate, format: .dateTime.hour().minute())
					.font(.subheadline)
					.foregroundStyle(.secondary)

			}
			.padding(.bottom)
			
			
			HStack {
				VStack(alignment: .leading) {
					latestValueView
				}
				Spacer()
				
				VStack(alignment: .center) {
					chartView
				}
				.frame(width: 100, height: 50)
			}
		}
    }
}

#Preview {
	NavigationStack {
		Form {
			Section {
				NavigationLink {
					
				} label: {
					SummaryItemListView(
						title: "Title",
						icon: "star.fill",
						titleColor: .yellow,
						latestDate: Date(),
						latestValueView: AnyView(Text("Value")),
						chartView: AnyView(Text("Hello"))
					)
				}
			}
		}
	}

}
