//
//  ElectricityPriceControllerTest.swift
//  SmartUsageToolTests
//
//  Created by Malte Ruff on 18.09.24.
//

import Foundation

import XCTest
@testable import SmartUsageTool

class ElectricityPriceControllerTests: XCTestCase {
	var controller: ElectricityPriceController!
	
	override func setUp() {
		super.setUp()
		controller = ElectricityPriceController()
	}
	
	override func tearDown() {
		controller = nil
		super.tearDown()
	}
	
	func testInitialization() {
		XCTAssertNil(controller.priceResponse)
		XCTAssertTrue(controller.isLoading)
		XCTAssertNil(controller.error)
		XCTAssertEqual(controller.pricePoints, [])
	}
	
	func testAggregatedPricePoints() {
		// Setup test data
		let now = Date()
		let testPoints = [
			PricePoint(timestamp: now, price: 10),
			PricePoint(timestamp: now.addingTimeInterval(3600), price: 20),
			PricePoint(timestamp: now.addingTimeInterval(7200), price: 30)
		]
		controller.priceResponse = PriceResponse(
			licenseInfo: "",
			unixSeconds: testPoints.map { Int($0.timestamp.timeIntervalSince1970) },
			price: testPoints.map { $0.price },
			unit: "EUR/kWh",
			deprecated: false
		)

		
		// Test day aggregation
		let dayPoints = controller.aggregatedPricePoints(for: .day)
		XCTAssertEqual(dayPoints.count, 3)
		
		// Test week aggregation
		let weekPoints = controller.aggregatedPricePoints(for: .week)
		XCTAssertEqual(weekPoints.count, 1)
	}
	
	func testMoveDate() {
		let initialDate = controller.currentDate
		controller.moveDate(by: 1, unit: .day)
		XCTAssertGreaterThan(controller.currentDate, initialDate)
		
		controller.moveDate(by: -1, unit: .day)
		XCTAssertLessThan(controller.currentDate, initialDate)
	}
	
	func testFormattedCurrentDate() {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM d, yyyy"
		let expectedDayFormat = formatter.string(from: controller.currentDate)
		XCTAssertEqual(controller.formattedCurrentDate(for: .day), expectedDayFormat)
		
		formatter.dateFormat = "MMMM yyyy"
		let expectedMonthFormat = formatter.string(from: controller.currentDate)
		XCTAssertEqual(controller.formattedCurrentDate(for: .month), expectedMonthFormat)
	}
	
	func testResetToCurrentDate() {
		let calendar = Calendar.current
		let initialComponents = calendar.dateComponents([.day, .month, .year, .hour], from: controller.currentDate)
		
		controller.moveDate(by: -7, unit: .day)
		let movedComponents = calendar.dateComponents([.day, .month, .year, .hour], from: controller.currentDate)
		
		XCTAssertNotEqual(movedComponents, initialComponents)
		
		controller.resetToCurrentDate()
		let resetComponents = calendar.dateComponents([.day, .month, .year, .hour], from: controller.currentDate)
		
		XCTAssertEqual(resetComponents, initialComponents)
	}
	
	func testFindExtremePoints() {
		// Setup test data
		let now = Date()
		let testPoints = [
			PricePoint(timestamp: now, price: 10),
			PricePoint(timestamp: now.addingTimeInterval(3600), price: 20),
			PricePoint(timestamp: now.addingTimeInterval(7200), price: 30)
		]
		controller.priceResponse = PriceResponse(
			licenseInfo: "",
			unixSeconds: testPoints.map { Int($0.timestamp.timeIntervalSince1970) },
			price: testPoints.map { $0.price },
			unit: "EUR/kWh",
			deprecated: false
		)
		
		let extremes = controller.findExtremePoints(for: .day, in: testPoints)
		XCTAssertEqual(extremes?.max.price, 30)
		XCTAssertEqual(extremes?.min.price, 10)
	}
}
