//
//  HomeView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My Home")
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}, label: {
                   Image(systemName: "plus")
                })
            }
            
        Text("Total cost: $0,00")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
