//
//  UserDefaults+Keys.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import Foundation

extension UserDefaults {
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
}


private extension UserDefaults {
    enum Key: String {
        case currency
        case dayPrice
        case nightPrice
        case isNightPrice
    }
}
