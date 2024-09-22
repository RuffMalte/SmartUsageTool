//
//  EnergyCalculationInformationView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//

import SwiftUI

struct EnergyCalculationInformationView: View {
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ScrollView(.vertical) {
			
			HStack {
				Spacer()
				VStack(spacing: 20) {
					Image(systemName: "bolt")
						.font(.largeTitle)
					
					VStack(spacing: 10) {
						Text(Localize.introduction)
							.font(.system(.title, design: .rounded, weight: .bold))
						Text(Localize.energyUseTutorial)
							.font(.system(.title3, design: .rounded, weight: .regular))
					}
				}
				Spacer()
			}
			.ignoresSafeArea()
			.padding()
			.background(Color.background.gradient)
			
			HStack {
				VStack(alignment: .leading) {
					Text(Localize.energyUseCalculationDefinition)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.energyUseCalculationDefinitionText)
					
					Text(Localize.energyMonitoringImportance)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.energyMonitoringImportanceText)
						.padding(.bottom)
					
					Text(Localize.understandingEnergyCosts)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.understandingEnergyCostsText)
						.padding(.bottom)
					
					Text(Localize.factorsAffectingConsumption)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.factorsAffectingConsumptionText)
						.padding(.bottom)
					
					Text(Localize.calculatingEnergyCosts)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.calculatingEnergyCostsText)
						.padding(.bottom)
					
					Text(Localize.tipsForReducingConsumption)
						.font(.system(.title3, design: .rounded, weight: .semibold))
						.foregroundStyle(.tint)
						.padding(.vertical)
					
					Text(Localize.tipsForReducingConsumptionText)
						.padding(.bottom)
					
					Link(destination: URL(string: "https://www.analog.com/en/resources/technical-articles/energy-use-calculation-tutorial.html")!) {
						Label(Localize.Source, systemImage: "globe")
					}
					.padding(.top)
				
				}
				
				
				
				Spacer()
			}
		
			.padding()
			
		}
		.overlay {
			VStack {
				HStack {
					Spacer()
					Button {
						dismiss()
					} label: {
						Image(systemName: "xmark")
					}
					.buttonStyle(.plain)
					.font(.headline)
					.foregroundStyle(.secondary)
					.padding(7)
					.background {
						Circle()
							.foregroundStyle(.bar)
					}
					.padding()
					
				}
				Spacer()
			}
		}
    }
}

#Preview {
	Text("Hello")
		.sheet(isPresented: .constant(true)) {
			EnergyCalculationInformationView()
		}
}
