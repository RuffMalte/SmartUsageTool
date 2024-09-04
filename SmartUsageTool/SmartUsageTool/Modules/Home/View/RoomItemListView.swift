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
	@State private var isShowingEditSheet = false
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(NSLocalizedString(room.name.capitalized, comment: ""))
					.font(.system(.headline, design: .rounded, weight: .bold))
					.foregroundStyle(.foreground)
				Spacer()
			}
			Group {
				if UIImage(named: room.name) != nil {
					Image(room.name)
						.resizable()
						.scaledToFit()
				} else {
					Image("other")
						.resizable()
						.scaledToFit()
				}
			}
			
		}
		.padding()
//		.frame(width: UIScreen.main.bounds.width / 2 - 40, height: UIScreen.main.bounds.width / 2 - 40)
		.background(
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.lightGrayBackground)
		)
		.contextMenu {
			Button {
				isShowingEditSheet.toggle()
			} label: {
				Label(Localize.edit, systemImage: "pencil")
			}
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
		.sheet(isPresented: $isShowingEditSheet) {
			ModifyRoomSheetView(room: room, isNewRoom: false)
		}
	}
}

#Preview {
	RoomItemListView(room: RoomModel.preview)
}
