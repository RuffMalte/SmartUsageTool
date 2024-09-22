//
//  ContractLengthSettingsView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 21.09.24.
//

import SwiftUI

struct ContractLengthSettingsView: View {
	
	@State var useContractEndTime = UserDefaults.useContractEndTime
	@State var contractEndTime: Date = (UserDefaults.currentContractEndTime ?? Date())
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Toggle(isOn: $useContractEndTime) {
						Label(Localize.alertOnContractEndTime, systemImage: "clipboard")
					}
					.onChange(of: useContractEndTime) { old, new in
						UserDefaults.setUseContractEndTime(new)
					}
				} footer: {
					Text(Localize.alertOnContractEndTimeDescription)
				}
				
				if useContractEndTime {
					Section {
						DatePicker(selection: $contractEndTime, displayedComponents: .date) {
							Label(Localize.selectDate, systemImage: "calendar")
						}
					}
					.onChange(of: contractEndTime) { oldValue, newValue in
						UserDefaults.setcurrentContractEndTime(newValue)
					}
				}
			}
			.onAppear(perform: {
				useContractEndTime = UserDefaults.useContractEndTime
				contractEndTime = UserDefaults.currentContractEndTime ?? Date()
			})
			.navigationTitle(Localize.contractMangement)
		}
    }
}

#Preview {
    ContractLengthSettingsView()
}
