//
//  ListView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query private var items: [RoomModel]
    
    private var totalCost: Double {
       let sum = items.reduce(0.0) { $0 + $1.expenses }
        return sum
    }
    var body: some View {
contentView
    }
}

private extension ListView {
    
    var contentView: some View {
        VStack {
            headerView
//            Spacer()
            listView
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("List")
                .font(.system(size: 28, weight: .semibold))
            HStack {
                Text("Total cost:")
                Text(String(format: "$%.2f", totalCost))
                    .font(.system(size: 22))
                Spacer()
            }
            
   
        }
        .padding(30)
        .padding(.bottom, 10)

        .background(Color.background)
    }
    
    var listView: some View {
        List {
            ForEach(items) { room in
                Section(header: HStack {
                    Text(room.name)
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                    Text(String(format: "$%.2f", room.expenses))
                        .font(.title)
                        .foregroundColor(.black)
                }) {
                    ForEach(room.devices) { device in
                        VStack {
                            HStack {
                                Text(device.name)
                                Spacer()
                                Text(String(format: "$%.2f", device.expenses))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Daily usage")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.gray)
                                    Text("\(device.dayTime, specifier: "%.1f") hrs")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.gray)
                                }
                                Spacer()
                                if UserDefaults.isNightPrice {
                                    VStack(alignment: .leading) {
                                        Text("Nightly usage")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.gray)
                                        Text("\(device.nightTime, specifier: "%.1f") hrs")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Power")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.gray)
                                    Text("\(device.power) W")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                 
                    }
                }
            }
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    ListView()
}
