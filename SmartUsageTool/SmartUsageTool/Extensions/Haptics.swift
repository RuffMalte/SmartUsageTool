//
//  Haptics.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//
import SwiftUI

func playFeedbackHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
	let generator = UIImpactFeedbackGenerator(style: style)
	generator.impactOccurred()
}


func playNotificationHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
	let generator = UINotificationFeedbackGenerator()
	generator.notificationOccurred(type)
}
