//
//  HomeView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var text = ""
    @ObservedObject var viewModel = HomeViewModel()
    @Query private var items: [RoomModel]
    @State private var isPresentedNewRoom = false
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        contentView
    }
    
}

private extension HomeView {
    var contentView: some View {
        VStack {
            headerView
            collectionView
        }
        .sheet(isPresented: $isPresentedNewRoom) {
               NewRoom(isPresented: $isPresentedNewRoom)
           }
        
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("My Home")
                    .fontWeight(.bold)
                Spacer()
                Button(action: { isPresentedNewRoom.toggle() }, label: {
                    Image(systemName: "plus")
                        .tint(.black)
                })
            }
            
            Text("Total cost: $0,00")
            
            HStack {
                Text("USD")
                    .padding(10)
                    .background(
                                   RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                               )
                    .frame(height: 48)
                TextField("0,00", text: $text)
                        .padding(10)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                        .background(
                                       RoundedRectangle(cornerRadius: 10)
                                        .fill(.white)
                                   )
                Text("per kWh")
            }
        }
        .padding()
        .background(Color.background)
    }
    
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { room in
                    Image(room.type.rawValue)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: UIScreen.main.bounds.width / 2 - 40)
                        .background(
                                       RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightGrayBackground)
                                   )
//                        .padding(10)
                }
            }
            .padding(10)
        }
        .padding(20)
    }
}

#Preview {
    HomeView()
}
