//
//  ElectricityMapsAPIKeyController.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//
import SwiftUI
import Observation

@Observable
class ElectricityMapsAPIKeyController: ObservableObject {
	var apiKey: String = ""
	private let keychainService = "com.SmartUsageTool.electricitymaps"
	private let keychainAccount = "apiKey"
	
	init() {
		loadAPIKey()
	}
	
	// Create (and Update) API Key
	func saveAPIKey(_ newKey: String) {
		apiKey = newKey
		if let data = newKey.data(using: .utf8) {
			KeychainManager.shared.save(data, service: keychainService, account: keychainAccount)
		}
	}
	
	func loadAPIKey() {
		if let data = KeychainManager.shared.retrieve(service: keychainService, account: keychainAccount),
		   let key = String(data: data, encoding: .utf8) {
			apiKey = key
		}
	}
	
	func deleteAPIKey() {
		apiKey = ""
		KeychainManager.shared.delete(service: keychainService, account: keychainAccount)
	}
}
