//
//  ColorEnum.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 17.09.24.
//


import Foundation
import SwiftUI

enum ColorEnum: String, Codable, CaseIterable, Identifiable {
	var id: Self { return self }

	case red
	case orange
	case yellow
	case green
	case blue
	case indigo
	case purple
	case pink
	
	var toColor: Color {
		switch self {
		case .red:
			Color.red
		case .orange:
			Color.orange
		case .yellow:
			Color.yellow
		case .green:
			Color.green
		case .blue:
			Color.blue
		case .indigo:
			Color.indigo
		case .purple:
			Color.purple
		case .pink:
			Color.pink
		}
	}
	
}