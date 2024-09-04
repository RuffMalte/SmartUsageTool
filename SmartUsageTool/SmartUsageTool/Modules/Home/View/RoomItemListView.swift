//
//  RoomItemListView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 02.09.24.
//

import SwiftUI
import SwiftData

struct RoomItemListView: View {
	
	@Bindable var room: RoomModel
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	@State private var showingConfirmation = false
	
    var body: some View {
		VStack {
			Image(room.type.rawValue)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.cornerRadius(10)
			HStack {
				Text(room.name)
					.foregroundStyle(.black)
				Spacer()
			}
		}
		.padding()
		.frame(width: UIScreen.main.bounds.width / 2 - 40, height: UIScreen.main.bounds.width / 2 - 40)
		.background(
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.lightGrayBackground)
		)
		.contextMenu {
			Button(role: .destructive) {
				showingConfirmation.toggle()
			} label: {
				Label(Localize.delete, systemImage: "trash")
			}
		}
		.confirmationDialog(Localize.areYouSure, isPresented: $showingConfirmation, titleVisibility: .visible) {
			Button(Localize.delete, role: .destructive) {
				withAnimation {
					modelContext.delete(room)
					try? modelContext.save()
				}
			}
			Button(Localize.cancel, role: .cancel) {
				dismiss()
			}
		}
    }
}

#Preview {
	RoomItemListView(room: RoomModel.preview)
}
