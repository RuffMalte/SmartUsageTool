//
//  TimePeriod.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//


enum TimePeriod: String, CaseIterable {
    case daily
    case monthly
    case yearly
	
//	var localized: String {
//		
//	}
	
	var icon: String {
		switch self {
		case .daily: return "1.square"
		case .monthly: return "calendar"
		case .yearly: return "fireworks"
		}
	}
	
	var localizedString: String {
		switch self {
		case .daily: return Localize.daily
		case .monthly: return Localize.monthly
		case .yearly: return Localize.yearly
		}
	}
}
