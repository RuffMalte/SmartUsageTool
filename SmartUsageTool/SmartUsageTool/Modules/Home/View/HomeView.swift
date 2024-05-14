//
//  HomeView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var text = String(format: "%.2f", UserDefaults.dayPrice)
    @State private var night = String(format: "%.2f", UserDefaults.nightPrice)
    @ObservedObject var viewModel = HomeViewModel()
    @Query private var items: [RoomModel]
    @State private var isPresentedNewRoom = false
    private var totalCost: Double {
        let sum = items.reduce(0.0) { $0 + $1.expenses }
        return sum
    }
    private var totalCostString: String {
        return Localize.currencySymbol + String(format: "%.2f", totalCost)
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            contentView
                .onTapGesture {
                    hideKeyboard()
                }
                .onChange(of: text) { oldValue, newValue in
                    UserDefaults.setDay(price: Double(newValue) ?? 0)
                }
                .onChange(of: night) { oldValue, newValue in
                    UserDefaults.setNight(price: Double(newValue) ?? 0)
                }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                Text(Localize.myHome)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { isPresentedNewRoom.toggle() }, label: {
                    Image(systemName: "plus")
                        .tint(.black)
                })
            }
            
            Text(Localize.totalCost + totalCostString)
            
            HStack(alignment: .bottom) {
                
                Text(Localize.currency)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    )
                //                        .frame(height: 48)
                
                
                VStack {
                    if UserDefaults.isNightPrice {
                        Text(Localize.day)
                    }
                    TextField("0,00", text: $text)
                        .padding(10)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                }
                
                if UserDefaults.isNightPrice {
                    VStack {
                        Text(Localize.night)
                        TextField("0,00", text: $night)
                            .padding(10)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.numberPad)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                            )
                    }
                    
                }
                
                Text(Localize.wattPerHour)
            }
        }
        .padding()
        .background(Color.background)
    }
    
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { room in
                    NavigationLink(
                        destination: RoomView(room: room),
                        label: {
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
                        }
                    )
                    //                        .buttonStyle(PlainButtonStyle())  Avoid default button style
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
