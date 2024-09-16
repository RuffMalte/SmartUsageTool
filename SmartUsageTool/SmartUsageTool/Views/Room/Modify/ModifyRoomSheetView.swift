//
//  ModifyRoomSheetView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 04.09.24.
//

import SwiftUI
import SwiftData

struct ModifyRoomSheetView: View {
	@Bindable var room: RoomModel
	let isNewRoom: Bool
	@Environment(\.modelContext) private var modelContext
	@Query private var rooms: [RoomModel]
	@Environment(\.dismiss) private var dismiss
	@State private var searchText: String = ""
	@State private var isCustomNamingActive = false
	let roomEnums: [Room] = Room.allCases
	
	@State private var isShowingConfirmation = false
	
	var body: some View {
		NavigationStack {
			VStack {
				ScrollView(.vertical, showsIndicators: false) {
					if !isNewRoom {
						Button(role: .destructive) {
							isShowingConfirmation.toggle()
						} label: {
							HStack {
								Spacer()
								Label(Localize.delete, systemImage: "trash")
									.font(.system(.body, design: .rounded, weight: .bold))
								Spacer()
							}
							
						}
						.padding()
						.background(.red.opacity(0.1))
						.clipShape(.rect(cornerRadius: 10))
					}
					
					LazyVGrid(columns: [
						GridItem(.adaptive(minimum: 100)),
						GridItem(.adaptive(minimum: 100))
					]) {
						ForEach(roomEnums.filter { searchText.isEmpty ? true : $0.localizedName.localizedCaseInsensitiveContains(searchText) }, id: \.rawValue) { ro in
							if ro == .other {
								NavigationLink {
									CustomRoomNameView(roomName: $room.name) { roomName in
										saveRoom(for: roomName)
									}
								} label: {
									roomButton(for: ro)
								}
							} else {
								Button {
									saveRoom(for: ro.caseName.lowercased())
								} label: {
									roomButton(for: ro)
								}
							}
						}
						.buttonStyle(.plain)

					}
					.animation(.default, value: searchText)
				}
			}
			.overlay {
				VStack {
					Spacer()
					TextField(Localize.enterName, text: $searchText)
						.font(.system(.body, design: .default, weight: .bold))
						.padding()
						.background(Color(.systemGray6))
						.clipShape(.rect(cornerRadius: 10))
				}
				.shadow(radius: 10)
			}
			.padding(.horizontal)
			.navigationTitle(Localize.addRoom)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(Localize.save) {
						if isNewRoom {
							modelContext.insert(room)
						}
						try? modelContext.save()
						dismiss()
					}
				}
				ToolbarItem(placement: .cancellationAction) {
					Button(Localize.cancel) {
						dismiss()
					}
				}
			}
			.confirmationDialog(Localize.areYouSure, isPresented: $isShowingConfirmation, titleVisibility: .visible) {
				Button(Localize.delete, role: .destructive) {
					withAnimation {
						modelContext.delete(room)
						try? modelContext.save()
						dismiss()
					}
				}
				Button(Localize.cancel, role: .cancel) {
					isShowingConfirmation.toggle()
				}
			}
		}
	}
	
	private func roomButton(for ro: Room) -> some View {
		VStack(alignment: .leading) {
			Text(ro.localizedName)
				.font(.system(.headline, design: .rounded, weight: .bold))
				.foregroundStyle(.foreground)
			
			Group {
				if UIImage(named: ro.caseName.lowercased()) != nil {
					Image(ro.caseName.lowercased())
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
		.background(.bar)
		.clipShape(.rect(cornerRadius: 10))
	}
	
	func saveRoom(for roomName: String) {
		room.name = roomName
		if isNewRoom {
			modelContext.insert(room)
		}
		try? modelContext.save()
		dismiss()
	}
}

struct CustomRoomNameView: View {
	@Binding var roomName: String
	@Environment(\.dismiss) private var dismiss

	var onSave: (String) -> Void
	var body: some View {
		Form {
			TextField(Localize.enterName, text: $roomName)
		}
		.navigationTitle(Localize.addRoom)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button(Localize.save) {
					dismiss()
					onSave(roomName)
				}
			}
		}
	}
}


#Preview {
	ModifyRoomSheetView(room: RoomModel.new, isNewRoom: true)
}
