//
//  ContentView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("My Home", systemImage: "house.fill")
                }
            ListView()
                .tabItem {
                    Label("List", systemImage: "tablecells")
                }
        }
    }
}

#Preview {
    InitialView()
}
