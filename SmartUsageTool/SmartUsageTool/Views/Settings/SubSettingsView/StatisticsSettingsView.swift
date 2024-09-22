//
//  StatisticsSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//

import SwiftUI

struct StatisticsSettingsView: View {
	@EnvironmentObject private var apiKeyController: ElectricityMapsAPIKeyController
	@EnvironmentObject private var apiController: ElectricityMapsAPIController
	@State private var newApiKey = ""
	@State private var isSecure = true
	

	@State private var showAlert = false
	@State private var alertMessage = ""
	
	@State private var isShowingAPIKeyExplanation = false
	var body: some View {
		NavigationStack {
			Form {
				
				Section {
					HStack {
						if isSecure {
							SecureField(Localize.EnterAPIKey, text: $newApiKey)
						} else {
							TextField(Localize.EnterAPIKey, text: $newApiKey)
						}
						Spacer()
						Button(action: {
							isSecure.toggle()
						}) {
							Image(systemName: isSecure ? "eye.slash" : "eye")
						}
					}
					.font(.system(.subheadline, design: .monospaced, weight: .semibold))
					
				} header: {
					HStack {
						Text(Localize.EnergyMapsAPIKey)
						Spacer()
						Link(destination: URL(string: "https://www.electricitymaps.com/free-tier-api")!) {
							Image(systemName: "globe")
						}
					}
				}
				.onAppear {
					newApiKey = apiKeyController.apiKey
				}
				
				Section {
					HStack {
						Button {
							isShowingAPIKeyExplanation.toggle()
						} label: {
							Image(systemName: "info.circle.fill")
								.foregroundStyle(.primary)
						}
						.buttonStyle(.plain)
						.font(.title2)
						.padding()
						.background(.bar)
						.clipShape(.rect(cornerRadius: 10))
						.popover(isPresented: $isShowingAPIKeyExplanation) {
							VStack(alignment: .leading) {
								ScrollView {
									Link(destination: URL(string: "https://www.electricitymaps.com/free-tier-api")!) {
										Label(Localize.getYourOwnAPIKey, systemImage: "globe")
											.font(.subheadline)
											.fontWeight(.bold)
									}
									.padding(.bottom)
									
									Text(Localize.energyUseCalculationDefinition)
										.padding(.vertical)
										.font(.headline)
										.foregroundStyle(.tint)
									Text(Localize.whatIsAnAPIKey)
								}
							}
							.frame(width: 300, height: 300)
								.padding()
								.presentationCompactAdaptation(.popover)
						}
						
						Button {
							testAPIKey()
						} label: {
							if apiController.isLoading {
								ProgressView()
							} else {
								Image(systemName: "testtube.2")
									.foregroundStyle(.primary)
							}
						}
						.buttonStyle(.plain)
						.font(.title2)
						.padding()
						.background(.bar)
						.clipShape(.rect(cornerRadius: 10))
						.disabled(apiKeyController.apiKey.isEmpty || apiController.isLoading)

						Button {
							apiKeyController.saveAPIKey(newApiKey)
						} label: {
							HStack {
								Spacer()
								Text(Localize.save)
									.fontDesign(.rounded)
									.fontWeight(.bold)
									.foregroundStyle(.white)
								Spacer()
							}
						}
						.buttonStyle(.plain)
						.font(.title2)
						.padding()
						.background(content: {
							RoundedRectangle(cornerRadius: 10)
								.foregroundStyle(.tint)
						})
						.disabled(newApiKey.isEmpty)

						if !apiKeyController.apiKey.isEmpty {
							Button(role: .destructive) {
								newApiKey = ""
								apiKeyController.deleteAPIKey()
							} label: {
								Image(systemName: "trash")
									.foregroundStyle(.white)
							}
							.buttonStyle(.plain)
							.font(.title2)
							.padding()
							.background(.red)
							.clipShape(.rect(cornerRadius: 10))
						}
					}
				}
				.listRowInsets(EdgeInsets())
				.listRowBackground(Color.clear)
				
			}
			.navigationTitle(Localize.statisticSettings)
			.alert(isPresented: $showAlert) {
				Alert(title: Text(Localize.apiTestResult), message: Text(alertMessage), dismissButton: .default(Text(Localize.ok)))
			}
		}
	}
	
	private func testAPIKey() {
		apiController.getCurrentCarbonIntensityData(for: "DE", authToken: apiKeyController.apiKey)
		
		// Wait for the API call to complete
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
			if apiController.currentCarbonIntensityData != nil {
				alertMessage = Localize.apiTestSuccess
			} else {
				alertMessage = Localize.apiTestFailed
			}
			showAlert = true
		}
	}
}

#Preview {
    StatisticsSettingsView()
		.withEnvironmentObjects()
}
