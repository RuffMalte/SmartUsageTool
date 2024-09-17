//
//  HoursAndMinutesTimeIntervalPicker.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 04.09.24.
//

//import SwiftUI
//
//struct HoursAndMinutesTimeIntervalPicker: View {
//	
//	var initiallHours: TimeInterval
//	var initailSeconds: TimeInterval
//	
//	var type: String
//	var title: String
//	
//	var minValueHours: TimeInterval?
//	var maxValueHours: TimeInterval?
//	
//	var minValueSeconds: TimeInterval?
//	var maxalueSeconds: TimeInterval?
//	
//	
//	var onValueChanged: (TimeInterval, TimeInterval) -> Void
//	
//	@State private var isShowingPickerPopup = false
//	@State private var hours: Double
//	@State private var minutes: Double
//	
//    var body: some View {
//		VStack(alignment: .leading) {
//		
//			Text(title)
//				.fontWeight(.semibold)
//			
//			HStack {
//					
//				HStack {
//					Text(formatHours(initiallHours))
//					Text(Localize.hrs)
//					
//					Text(formatHours(initailSeconds))
//					Text(Localize.min)
//					
//				}
//				.foregroundStyle(.secondary)
//				
//				Spacer()
//				
//				
//				Button {
//					
//				} label: {
//					HStack {
//						Text(minutes, format: .time(pattern: .hourMinute))
//						Text(":")
//						
//					}
//				}
//				.padding()
//				.buttonStyle(.plain)
//			}
//			.padding()
//			.background(Color(.systemGray6))
//			.clipShape(RoundedRectangle(cornerRadius: 10))
//		}
//    }
//	
//	func formatHours(_ hours: TimeInterval) -> String {
//		let formatted = String(format: "%.0f", hours)
//		return formatted.replacingOccurrences(of: ".0", with: "")
//	}
//	func formatMinutes(_ minutes: TimeInterval) -> String {
//		let formatted = String(format: "%.0f", minutes)
//		return formatted.replacingOccurrences(of: ".0", with: "")
//	}
//}
//
//#Preview {
//	HoursAndMinutesTimeIntervalPicker(initiallHours: 0, initailSeconds: 0, type: "hrs", title: "Daily Usage") { hours, minutes in
//			print("Hours: \(hours), Minutes: \(minutes)")
//	}
//}
