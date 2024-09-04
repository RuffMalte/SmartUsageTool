//
//  NewRoom.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 12.04.2024.
//

import SwiftUI
import SwiftData

struct NewRoom: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var name: String = ""
    
    @State private var selectedRoom: Room? = nil
    let rooms: [Room] = Room.allCases
	@State private var searchTextField: String = ""
	@FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        contentView
			.ignoresSafeArea(edges: .bottom)
    }
}

private extension NewRoom {
	var contentView: some View {
		ZStack {
			NavigationView {
				VStack {
					if selectedRoom == nil {
						roomPickerView
							.overlay {
								VStack {
									Spacer()
									HStack {
										textfieldView
										if isSearchFieldFocused {
											collapseButton
												.transition(.move(edge: .trailing))
										}
									}
								}
								.padding()
							}
					} else {
						selectedRoomDetailView
					}
				}
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle(Localize.addRoom)
				.navigationBarItems(leading: Button(Localize.cancel) {
					isPresented.toggle()
				},
									trailing: Button(Localize.save) {
					addItem()
					isPresented.toggle()
				})
			}
		}
	}
	
	var nameView: some View {
		VStack(alignment: .leading) {
			if selectedRoom == .other {
				textfieldView
					.padding(30)
			} else {
				roomPickerView
					.ignoresSafeArea(edges: .bottom)
			}
		}
	}
	
	var textfieldView: some View {
		TextField(Localize.enterName, text: $name)
			.padding()
			.textFieldStyle(.plain)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(.bar)
					.shadow(radius: 5)
			)
			.focused($isSearchFieldFocused)
			.onChange(of: isSearchFieldFocused, { oldValue, newValue in
				withAnimation {
					isSearchFieldFocused = newValue
				}
			})
	}
	
	var collapseButton: some View {
		Button {
			withAnimation {
				isSearchFieldFocused = false
			}
		} label: {
			Image(systemName: "keyboard.chevron.compact.down")
				.padding()
				.background(
					RoundedRectangle(cornerRadius: 10)
						.foregroundStyle(.bar)
						.shadow(radius: 5)
				)
		}
	}
	
	var roomPickerView: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]) {
					ForEach(validRoomsWithImages, id: \.self) { room in
						Button {
							handleRoomSelection(room: room)
						} label: {
							validRoomsWithImagesCellView(for: room)
						}
						.buttonStyle(.plain)
					}
				}
				.animation(.default, value: validRoomsWithImages)
			}
		}
		.padding([.top, .horizontal], 8)
	}
	
	func handleRoomSelection(room: Room) {
		withAnimation {
			selectedRoom = room
			if room.rawValue != Localize.other {
					isPresented = false
					addItem()
			}
		}
	}
	
	func validRoomsWithImagesCellView(for room: Room) -> some View {
		VStack {
			HStack {
				Text(room.localizedName)
					.font(.system(.subheadline, design: .rounded, weight: .bold))
					.foregroundStyle(.foreground)
				Spacer()
			}
			.lineLimit(2)
			if let image = findImageForRoom(roomName: room.caseName) {
				image
					.resizable()
					.scaledToFit()
			}
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 10)
				.foregroundStyle(.bar)
		}
	}
	
	var selectedRoomDetailView: some View {
		VStack {
			if let image = findImageForRoom(roomName: selectedRoom?.rawValue ?? Localize.other) {
				image
					.resizable()
					.scaledToFit()
			}
			textfieldView
			
			Spacer()
			
			Button {
				withAnimation {
					selectedRoom = nil
				}
			} label: {
				Text("Back to Selection")
			}
		}
		.padding()
	}
	
	private var validRoomsWithImages: [Room] {
		let roomsWithImages = rooms.filter { findImageForRoom(roomName: $0.caseName) != nil }
		
		var filteredRooms = roomsWithImages.filter {
			$0.rawValue.lowercased().contains(name.lowercased()) || name.isEmpty
		}
		
		if let otherRoom = rooms.first(where: { $0.rawValue == Localize.other}) {
			if !filteredRooms.contains(otherRoom) {
				filteredRooms.append(otherRoom)
			} else {
				filteredRooms.removeAll(where: { $0.rawValue == Localize.other })
				filteredRooms.append(otherRoom)
			}
		}
		
		return filteredRooms
	}
	
	private func findImageForRoom(roomName: String) -> Image? {
		if let uiImage = UIImage(named: roomName) {
			return Image(uiImage: uiImage)
		} else {
			return nil
		}
	}
}


private extension NewRoom {
    func addItem() {
		let name = selectedRoom == .other ? name : selectedRoom?.localizedName ?? ""
		let newItem = RoomModel(type: RoomType.checkBy(name: name), name: name)
        modelContext.insert(newItem)
    }
}

#Preview {
    NewRoom(isPresented: .constant(true))
}
