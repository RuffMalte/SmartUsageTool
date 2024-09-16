//
//  ElectricityPriceChartCreationView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 11.09.24.
//

import SwiftUI
import Charts

struct ElectricityPriceChartCreationView: View {
	@EnvironmentObject private var viewModel: ElectricityPriceController
	@Binding var selectedRange: ElectricityPriceController.TimeRange
	
	@State private var dragOffset: CGFloat = 0
	
	
	var body: some View {
		VStack {
			GeometryReader { geometry in
				Chart(viewModel.aggregatedPricePoints(for: selectedRange)) { point in
					LineMark(
						x: .value("Time", point.timestamp),
						y: .value("Price", point.price)
					)
					.interpolationMethod(.catmullRom)
					.lineStyle(StrokeStyle(lineWidth: 3))
					.foregroundStyle(.yellow)
					
					if let (maxPoint, minPoint) = getextremePoints() {
						ForEach([maxPoint, minPoint], id: \.id) { point in
							PointMark(
								x: .value("Time", point.timestamp),
								y: .value("Price", point.price)
							)
							.symbolSize(100)
							.foregroundStyle((point.price == maxPoint.price) ? .red : .green)
							.annotation {
								Text(point.price, format: .currency(code: UserDefaults.currency))
									.font(.system(.subheadline, design: .monospaced, weight: .semibold))
							}
						}
					}
				}
				.chartLegend(.visible)
				.chartXAxis {
					AxisMarks(values: .automatic()) { value in
						AxisGridLine()
						AxisTick()
						
						
						switch selectedRange {
						case .day:
							AxisValueLabel(format: .dateTime.hour())
						case .week:
							AxisValueLabel(format: .dateTime.weekday(.abbreviated))
						case .month:
							AxisValueLabel(format: .dateTime.day(.twoDigits))
						case .year:
							AxisValueLabel(format: .dateTime.day(.twoDigits).month(.twoDigits).year(.twoDigits))
						}
					}
				}
				.chartYAxis {
					AxisMarks(position: .leading) { value in
						AxisGridLine()
						AxisTick()
						AxisValueLabel {
							Text(value.as(Double.self)!, format: .currency(code: UserDefaults.currency))
						}
					}
				}
				// TODO: add gesture to move date and update prices
//				.animation(.snappy, value: dragOffset)
//				.offset(x: dragOffset)
//				.gesture(
//					DragGesture()
//						.onChanged { value in
//							dragOffset = value.translation.width
//						}
//						.onEnded { value in
//							let threshold = geometry.size.width * 0.2
//							if abs(value.translation.width) > threshold {
//								withAnimation {
//									if value.translation.width > 0 {
//										viewModel.moveDate(by: -1, unit: calendarComponent(for: selectedRange))
//									} else {
//										viewModel.moveDate(by: 1, unit: calendarComponent(for: selectedRange))
//									}
//								}
//							}
//							dragOffset = 0
//						}
//				)
			}
		}
		.frame(height: 300)
	}
	private func calendarComponent(for range: ElectricityPriceController.TimeRange) -> Calendar.Component {
		switch range {
		case .day, .week: return .day
		case .month: return .month
		case .year: return .year
		}
	}
	
	func getextremePoints() -> (max: PricePoint, min: PricePoint)? {
		let points = viewModel.aggregatedPricePoints(for: selectedRange)
		guard let maxPoint = points.max(by: { $0.price < $1.price }),
			  let minPoint = points.min(by: { $0.price < $1.price }) else {
			return nil
		}
		return (maxPoint, minPoint)
	}
}


#Preview {
	ElectricityPriceChartCreationView(selectedRange: .constant(.day))
		.withEnvironmentObjects()

}
