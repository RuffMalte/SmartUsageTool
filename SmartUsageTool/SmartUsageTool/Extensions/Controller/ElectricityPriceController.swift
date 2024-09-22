//
//  ElectricityPriceController.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import Foundation
import SwiftUI

@Observable
class ElectricityPriceController: ObservableObject {
	// MARK: - Properties
	var priceResponse: PriceResponse?
	var isLoading = false
	var error: Error?
	private var _pricePoints: [PricePoint]?
	var pricePoints: [PricePoint] {
		if let cached = _pricePoints {
			return cached
		}
		guard let response = priceResponse else { return [] }
		let points = zip(response.unixSeconds, response.price).map { (timestamp, price) in
			PricePoint(timestamp: Date(timeIntervalSince1970: TimeInterval(timestamp)), price: price)
		}
		_pricePoints = points
		return points
	}
	var currentPrice: Double?
	var currentPricePricePoint: PricePoint?
	var currentDate: Date = Date()
	private var latestDataDate: Date {
		if let cached = _latestDataDate {
			return cached
		}
		let latest = pricePoints.map(\.timestamp).max() ?? Date()
		_latestDataDate = latest
		return latest
	}
	private var _latestDataDate: Date?
	
	// MARK: - Initialization
	init() {
		if UserDefaults.useDailyFetching {
			fetchPricesForYear()
			fetchCurrentPrice()
		}
	}
	
	// MARK: - Methods
	func fetchPricesForYear() {
		let now = Date()
		let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: now)!
		fetchPrices(country: UserDefaults.standard.selectedDailPriceFetchingCountry?.code ?? "", start: Int(oneYearAgo.timeIntervalSince1970), end: Int(now.timeIntervalSince1970))
	}
	
	func fetchCurrentPrice() {
		isLoading = true
		error = nil
		let now = Date()
		let fourHoursAgo = Calendar.current.date(byAdding: .hour, value: -4, to: now)!
		
		Task {
			do {
				let result = try await performFetch(country: UserDefaults.standard.selectedDailPriceFetchingCountry?.code ?? "", start: Int(fourHoursAgo.timeIntervalSince1970), end: Int(now.timeIntervalSince1970))
				await MainActor.run {
					self.currentPrice = result.withConvertedPrices().price.last
					
					if let price = self.currentPrice {
						self.currentPricePricePoint = PricePoint(timestamp: now, price: price)
					}
					
					let calendar = Calendar.current
					let today = Date()
					
					if UserDefaults.isNightPrice {
						let nightStartHour = calendar.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStartTimeslot)))
						let nightEndHour = calendar.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(UserDefaults.nightPriceStoppTimeslot)))
						let currentHour = calendar.component(.hour, from: today)
						
						let isNightTime = (currentHour >= nightStartHour && currentHour < nightEndHour) || (nightEndHour < nightStartHour && (currentHour >= nightStartHour || currentHour < nightEndHour))
						
						if isNightTime {
							UserDefaults.setNight(price: self.currentPrice ?? 0)
						} else {
							UserDefaults.setDay(price: self.currentPrice ?? 0)
						}
					} else {
						UserDefaults.setDay(price: self.currentPrice ?? 0)
					}
					
					self.isLoading = false
				}
			} catch {
				await MainActor.run {
					self.error = error
					self.isLoading = false
				}
			}
		}
	}
	
	private func fetchPrices(country: String, start: Int, end: Int) {
		isLoading = true
		error = nil
		
		Task {
			do {
				let result = try await performFetch(country: country, start: start, end: end)
				await MainActor.run {
					self.priceResponse = result.withConvertedPrices()
					self._pricePoints = nil // Invalidate cache
					self._latestDataDate = nil // Invalidate cache
					self.isLoading = false
				}
			} catch {
				await MainActor.run {
					self.error = error
					self.isLoading = false
				}
			}
		}
	}
	
	private func performFetch(country: String, start: Int, end: Int) async throws -> PriceResponse {
		let baseURL = "https://api.energy-charts.info/price"
		let urlString = "\(baseURL)?bzn=\(country)&start=\(start)&end=\(end)"
		
		guard let url = URL(string: urlString) else {
			throw APIError.invalidURL
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			return try decoder.decode(PriceResponse.self, from: data)
		} catch let decodingError as DecodingError {
			throw APIError.decodingError(decodingError)
		} catch {
			throw APIError.networkError(error)
		}
	}
	
	enum TimeRange: String, CaseIterable, Identifiable {
		case day, week, month, year
		var id: Self { self }
		var localisedString: String {
			switch self {
			case .day:
				return Localize.day
			case .week:
				return Localize.week
			case .month:
				return Localize.month
			case .year:
				return Localize.year
			}
		}
	}
	
	func aggregatedPricePoints(for range: TimeRange) -> [PricePoint] {
		guard !pricePoints.isEmpty else { return [] }
		
		let calendar = Calendar.current
		let (startDate, endDate) = getDateRange(for: range, calendar: calendar)
		let filteredPoints = pricePoints.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }
		
		switch range {
		case .day:
			return filteredPoints
		case .week, .month:
			return aggregateByDay(filteredPoints)
		case .year:
			return aggregateByMonth(pricePoints)
		}
	}
	
	private func getDateRange(for range: TimeRange, calendar: Calendar) -> (Date, Date) {
		switch range {
		case .day:
			let startOfDay = calendar.startOfDay(for: currentDate)
			return (startOfDay, calendar.date(byAdding: .day, value: 1, to: startOfDay)!)
		case .week:
			let endDate = min(currentDate, latestDataDate)
			return (calendar.date(byAdding: .day, value: -6, to: endDate)!, endDate)
		case .month:
			let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
			return (startOfMonth, calendar.date(byAdding: .month, value: 1, to: startOfMonth)!)
		case .year:
			return (pricePoints.first?.timestamp ?? currentDate, latestDataDate)
		}
	}
	
	private func aggregateByDay(_ points: [PricePoint]) -> [PricePoint] {
		let calendar = Calendar.current
		let grouped = Dictionary(grouping: points) { calendar.startOfDay(for: $0.timestamp) }
		return grouped.map { (date, points) in
			let averagePrice = points.reduce(0.0) { $0 + $1.price } / Double(points.count)
			return PricePoint(timestamp: date, price: averagePrice)
		}.sorted { $0.timestamp < $1.timestamp }
	}
	
	private func aggregateByMonth(_ points: [PricePoint]) -> [PricePoint] {
		let calendar = Calendar.current
		let grouped = Dictionary(grouping: points) {
			calendar.date(from: calendar.dateComponents([.year, .month], from: $0.timestamp))!
		}
		return grouped.map { (date, points) in
			let averagePrice = points.reduce(0.0) { $0 + $1.price } / Double(points.count)
			return PricePoint(timestamp: date, price: averagePrice)
		}.sorted { $0.timestamp < $1.timestamp }
	}
	
	// MARK: - Date switcher
	func moveDate(by value: Int, unit: Calendar.Component) {
		if let newDate = Calendar.current.date(byAdding: unit, value: value, to: currentDate) {
			currentDate = min(newDate, latestDataDate)
		}
	}
	
	func canMoveForward(for range: TimeRange) -> Bool {
		let calendar = Calendar.current
		switch range {
		case .day:
			return calendar.startOfDay(for: currentDate) < calendar.startOfDay(for: latestDataDate)
		case .week:
			return calendar.date(byAdding: .day, value: 1, to: currentDate)! <= latestDataDate
		case .month:
			let currentMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
			let latestMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: latestDataDate))!
			return currentMonthStart < latestMonthStart
		case .year:
			return false
		}
	}
	
	func canMoveBackward(for range: TimeRange) -> Bool {
		let calendar = Calendar.current
		let earliestDate = pricePoints.first?.timestamp ?? Date()
		
		switch range {
		case .day:
			return calendar.startOfDay(for: currentDate) > calendar.startOfDay(for: earliestDate)
		case .week:
			return calendar.date(byAdding: .day, value: -7, to: currentDate)! >= earliestDate
		case .month:
			let currentMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
			let earliestMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: earliestDate))!
			return currentMonthStart > earliestMonthStart
		case .year:
			return false
		}
	}
	
	func formattedCurrentDate(for range: TimeRange) -> String {
		let formatter = DateFormatter()
		switch range {
		case .day:
			formatter.dateFormat = "MMM d, yyyy"
			return formatter.string(from: currentDate)
		case .week:
			let endDate = min(currentDate, latestDataDate)
			let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
			formatter.dateFormat = "MMM d"
			return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate)), \(Calendar.current.component(.year, from: endDate))"
		case .month:
			formatter.dateFormat = "MMMM yyyy"
			return formatter.string(from: currentDate)
		case .year:
			formatter.dateFormat = "yyyy"
			return formatter.string(from: latestDataDate)
		}
	}
	
	func resetToCurrentDate() {
		currentDate = min(Date(), latestDataDate)
	}
	
	func findExtremePoints(for range: TimeRange, in pricePoints: [PricePoint]) -> (max: PricePoint, min: PricePoint)? {
		let calendar = Calendar.current
		let (startDate, endDate) = getDateRange(for: range, calendar: calendar)
		
		let filteredPoints = pricePoints.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }
		
		guard let maxPoint = filteredPoints.max(by: { $0.price < $1.price }),
			  let minPoint = filteredPoints.min(by: { $0.price < $1.price }),
			  !filteredPoints.isEmpty else {
			return nil
		}
		
		return (maxPoint, minPoint)
	}
	
	func calculateDevicePrices(for devices: [DeviceModel], range: TimeRange) -> [PricePoint] {
		let pricePoints = aggregatedPricePoints(for: range)
		
		return pricePoints.map { point in
			let totalDevicePrice = devices.reduce(0.0) { total, device in
				guard device.isOn else { return total }
				
				let powerKWH = Double(device.power) / 1000.0
				let dailyUsageHours = device.doubleFormattedDayTime + device.doubleFormattedNightTime
				
				return total + (powerKWH * dailyUsageHours * point.price)
			}
			
			return PricePoint(timestamp: point.timestamp, price: totalDevicePrice)
		}
	}
}
