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
    
    @State private var selectedRoom: Room = .livingRoom
    let rooms: [Room] = Room.allCases
    
    var body: some View {
        contentView
    }
}

private extension NewRoom {
    var contentView: some View {
        ZStack {
            NavigationView {
                VStack {
                    Image("NewRoom")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    nameView
                    Spacer()
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
            Text(Localize.room)
                .fontWeight(.semibold)
            if selectedRoom == .other {
                textfieldView
            } else {
                roomPickerView
            }
       
        }
        .padding(30)
    }
    
    var textfieldView: some View {
        TextField(Localize.enterName, text: $name)
            .padding()
            .textFieldStyle(.plain)
            .background(
                RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
            )
    }
    
    var roomPickerView: some View {
        HStack {
            Picker(Localize.selectRoom, selection: $selectedRoom) {
                        ForEach(rooms, id: \.self) { room in
                                Text(room.localizedName)
                                    .font(.system(size: 14))
                        }
                    }
            .pickerStyle(.menu)
            Spacer()
        }
        .padding(.vertical,8)
        .background(
            RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
        )

    }
}

private extension NewRoom {
    func addItem() {
        let name = selectedRoom == .other ? name : selectedRoom.localizedName
        let newItem = RoomModel(type: RoomType.checkBy(name: name), name: name)
        modelContext.insert(newItem)
    }
}

#Preview {
    NewRoom(isPresented: .constant(true))
}
