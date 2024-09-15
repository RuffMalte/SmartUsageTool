//
//  PriceResponse.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 09.09.24.
//

import Foundation

struct PriceResponse: Codable {
	let licenseInfo: String
	let unixSeconds: [Int]
	let price: [Double]
	let unit: String
	let deprecated: Bool
	
	enum CodingKeys: String, CodingKey {
		case licenseInfo = "license_info"
		case unixSeconds = "unix_seconds"
		case price, unit, deprecated
	}
	
	var pricePoints: [PricePoint] {
		zip(unixSeconds, price).map { (timestamp, price) in
			PricePoint(timestamp: Date(timeIntervalSince1970: TimeInterval(timestamp)), price: price)
		}
	}
	func withConvertedPrices() -> PriceResponse {
		let convertedPrices = self.price.map { $0 / 1000 }
		return PriceResponse(licenseInfo: self.licenseInfo,
							 unixSeconds: self.unixSeconds,
							 price: convertedPrices,
							 unit: "EUR/kWh",
							 deprecated: self.deprecated)
	}
}
struct PricePoint: Identifiable {
	let id: UUID = UUID()
	let timestamp: Date
	let price: Double
}

// MARK: - API Error
enum APIError: Error, LocalizedError {
	case invalidURL
	case networkError(Error)
	case decodingError(Error)
	case unknownError
	
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .networkError(let error):
			return "Network error: \(error.localizedDescription)"
		case .decodingError(let error):
			return "Decoding error: \(error.localizedDescription)"
		case .unknownError:
			return "An unknown error occurred"
		}
	}
}
