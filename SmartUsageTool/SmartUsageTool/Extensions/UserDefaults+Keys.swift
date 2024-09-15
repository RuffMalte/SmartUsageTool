//
//  UserDefaults+Keys.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import Foundation

extension UserDefaults {
	// getter
    static var currency: String {
        Self.standard.string(forKey: Key.currency.rawValue) ?? "USD"
    }
    
    static var dayPrice: Double {
        Self.standard.double(forKey: Key.dayPrice.rawValue) 
    }
    
    static var nightPrice: Double {
        Self.standard.double(forKey: Key.nightPrice.rawValue)
    }
    
    static var isNightPrice: Bool {
        Self.standard.bool(forKey: Key.isNightPrice.rawValue)
    }
	
	static var nightPriceStartTimeslot: Int {
		Self.standard.integer(forKey: Key.nightPriceStartTimeslot.rawValue)
	}
	
	static var nightPriceStoppTimeslot: Int {
		Self.standard.integer(forKey: Key.nightPriceStoppTimeslot.rawValue)
	}
	
	static var useDailyFetching: Bool {
		Self.standard.bool(forKey: Key.useDailyFetching.rawValue)
	}
	
	// setter
    static func setCurrency(_ currency: String) {
        Self.standard.setValue(currency, forKey: Key.currency.rawValue)
    }
    
    static func setDay(price: Double) {
        Self.standard.setValue(price, forKey: Key.dayPrice.rawValue)
    }
    
    static func setNight(price: Double) {
        Self.standard.setValue(price, forKey: Key.nightPrice.rawValue)
    }
    
    static func setNight(available: Bool) {
        Self.standard.setValue(available, forKey: Key.isNightPrice.rawValue)
    }
	
	
	static func setNightPriceStartTimeslot(_ value: Int) {
		Self.standard.setValue(value, forKey: Key.nightPriceStartTimeslot.rawValue)
	}
	
	static func setNightPriceStoppTimeslot(_ value: Int) {
		Self.standard.setValue(value, forKey: Key.nightPriceStoppTimeslot.rawValue)
	}
	
	static func setUseDailyFetching(_ value: Bool) {
		Self.standard.setValue(value, forKey: Key.useDailyFetching.rawValue)
	}
	
	
	
	var selectedDailPriceFetchingCountry: SupportedPriceFetchingCountryModel? {
		get {
			if let data = data(forKey: Key.selectedDailPriceFetchingCountry.rawValue) {
				return try? JSONDecoder().decode(SupportedPriceFetchingCountryModel.self, from: data)
			}
			return nil
		}
		set {
			if let newValue = newValue, let data = try? JSONEncoder().encode(newValue) {
				set(data, forKey: Key.selectedDailPriceFetchingCountry.rawValue)
			} else {
				removeObject(forKey: Key.selectedDailPriceFetchingCountry.rawValue)
			}
		}
	}
}


private extension UserDefaults {
    enum Key: String {
        case currency
        case dayPrice
        case nightPrice
        case isNightPrice
		case nightPriceStartTimeslot
		case nightPriceStoppTimeslot
		case useDailyFetching
		case selectedDailPriceFetchingCountry
    }
}
