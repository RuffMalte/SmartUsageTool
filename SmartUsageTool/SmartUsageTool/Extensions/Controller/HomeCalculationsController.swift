//
//  HomeCalculationsController.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 22.09.24.
//

import Foundation

class HomeCalculationsController {
	
	
	
	func getMostAndLeastExpensiveRoom(rooms: [RoomModel]) -> (most: RoomModel, least: RoomModel)? {
		let mostExpensiveRoom = getMostExpensiveRoom(rooms: rooms)
		let leastExpensiveRoom = getLeastExpensiveRoom(rooms: rooms)
		
		guard let mostExpensiveRoom, let leastExpensiveRoom else { return nil }
		
		return (mostExpensiveRoom, leastExpensiveRoom)
	}
	
	func getMostExpensiveRoom(rooms: [RoomModel]) -> RoomModel? {
		return rooms.max(by: { $0.yearlyExpenses < $1.yearlyExpenses})
	}
	
	func getLeastExpensiveRoom(rooms: [RoomModel]) -> RoomModel? {
		return rooms.min(by: { $0.yearlyExpenses < $1.yearlyExpenses})
	}
	
	
	func calculateAverageHomeCost(rooms: [RoomModel]) -> Double {
		let totalCost = calculateTotalHomeCost(rooms: rooms)
		return totalCost / Double(rooms.count)
	}
	
	func calculateTotalHomeCost(rooms: [RoomModel]) -> Double {
		var totalCost: Double = 0.0
		for room in rooms {
			switch UserDefaults.selectedTimePeriod {
			case .daily:
				totalCost += room.dailyExpenses
			case .monthly:
				totalCost += room.monthlyExpenses
			case .yearly:
				totalCost += room.yearlyExpenses
			}
		}
		return totalCost
	}
	
	func getRoomPriceBasedOnTimePeriod(room: RoomModel) -> Double {
		switch UserDefaults.selectedTimePeriod {
		case .daily:
			return room.dailyExpenses
		case .monthly:
			return room.monthlyExpenses
		case .yearly:
			return room.yearlyExpenses
		}
	}
	
	func getTotalYearlyExpenses(rooms: [RoomModel]) -> Double {
		var totalYearlyExpenses: Double = 0.0
		for room in rooms {
			totalYearlyExpenses += room.yearlyExpenses
		}
		return totalYearlyExpenses
	}
	
	func getTotalMonthlyCost(rooms: [RoomModel]) -> Double {
		var totalMonthlyCost: Double = 0.0
		for room in rooms {
			totalMonthlyCost += room.monthlyExpenses
		}
		return totalMonthlyCost
	}
	
	func getTotalDailyCoast(rooms: [RoomModel]) -> Double {
		var totalDailyCoast: Double = 0.0
		for room in rooms {
			totalDailyCoast += room.dailyExpenses
		}
		return totalDailyCoast
	}
}
