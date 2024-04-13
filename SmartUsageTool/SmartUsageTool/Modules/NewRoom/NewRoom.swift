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
                    .navigationTitle("Add Room")
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented.toggle()
                    },
                                        trailing: Button("Save") {
                        addItem()
                        isPresented.toggle()
                    })
             
            }
        }
    }
    
    var nameView: some View {
        VStack(alignment: .leading) {
            Text("Room Name")
                .fontWeight(.semibold)
            TextField("Enter name", text: $name)
                          .padding()
                          .textFieldStyle(.plain)
                          .background(
                            RoundedRectangle(cornerRadius: 10).fill(.lightGrayBackground)
                          )
        }
        .padding(30)
    }
}

private extension NewRoom {
     func addItem() {
         let newItem = RoomModel(type: RoomType.checkBy(name: name), name: name)
            modelContext.insert(newItem)
    }
}

#Preview {
    NewRoom(isPresented: .constant(true))
}
