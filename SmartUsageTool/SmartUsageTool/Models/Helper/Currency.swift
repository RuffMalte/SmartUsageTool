//
//  Currency.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import SwiftUI

struct Currency: Identifiable, Hashable {
	let id: UUID
	let code: String
	let name: String
	let flag: String
	
	init(id: UUID = UUID(), code: String, name: String, flag: String) {
		self.id = id
		self.code = code
		self.name = name
		self.flag = flag
	}
}
extension Currency {
	static let currencies = [
		Currency(code: "EUR", name: "Euro", flag: "🇪🇺"),
		Currency(code: "HRN", name: "Ukrainian Hryvnia", flag: "🇺🇦"),
		Currency(code: "GBP", name: "British Pound", flag: "🇬🇧"),
		Currency(code: "CHF", name: "Swiss Franc", flag: "🇨🇭"),
		Currency(code: "SEK", name: "Swedish Krona", flag: "🇸🇪"),
		Currency(code: "NOK", name: "Norwegian Krone", flag: "🇳🇴"),
		Currency(code: "DKK", name: "Danish Krone", flag: "🇩🇰"),
		Currency(code: "PLN", name: "Polish Zloty", flag: "🇵🇱"),
		Currency(code: "CZK", name: "Czech Koruna", flag: "🇨🇿"),
		Currency(code: "HUF", name: "Hungarian Forint", flag: "🇭🇺"),
		Currency(code: "RUB", name: "Russian Ruble", flag: "🇷🇺"),
		Currency(code: "RON", name: "Romanian Leu", flag: "🇷🇴"),
		Currency(code: "HRK", name: "Croatian Kuna", flag: "🇭🇷"),
		Currency(code: "BGN", name: "Bulgarian Lev", flag: "🇧🇬"),
		Currency(code: "TRY", name: "Turkish Lira", flag: "🇹🇷"),
		Currency(code: "ISK", name: "Icelandic Krona", flag: "🇮🇸"),
		Currency(code: "USD", name: "US Dollar", flag: "🇺🇸"),
		Currency(code: "JPY", name: "Japanese Yen", flag: "🇯🇵"),
		Currency(code: "AUD", name: "Australian Dollar", flag: "🇦🇺"),
		Currency(code: "CAD", name: "Canadian Dollar", flag: "🇨🇦"),
		Currency(code: "CNY", name: "Chinese Yuan", flag: "🇨🇳"),
		Currency(code: "INR", name: "Indian Rupee", flag: "🇮🇳"),
		Currency(code: "MXN", name: "Mexican Peso", flag: "🇲🇽"),
		Currency(code: "SGD", name: "Singapore Dollar", flag: "🇸🇬"),
		Currency(code: "NZD", name: "New Zealand Dollar", flag: "🇳🇿"),
		Currency(code: "KRW", name: "South Korean Won", flag: "🇰🇷"),
	]
}
