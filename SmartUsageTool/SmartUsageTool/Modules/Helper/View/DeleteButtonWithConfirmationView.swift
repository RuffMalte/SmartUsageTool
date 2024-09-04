//
//  DeleteButtonWithConfirmationView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 02.09.24.
//

import SwiftUI

struct DeleteButtonWithConfirmationView: View {
	
	var action: () -> Void = {}
	@State private var showingConfirmation = false
	
	
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		VStack {
			
			Button {
				showingConfirmation.toggle()
			} label: {
				Label(Localize.delete, systemImage: "trash")
			}
			.confirmationDialog(Localize.areYouSure, isPresented: $showingConfirmation) {
				Button(Localize.delete, role: .destructive) {
					action()
				}
				Button(Localize.cancel, role: .cancel) {
					dismiss()
				}
			}
			
		}
    }
}

#Preview {
    DeleteButtonWithConfirmationView()
}
