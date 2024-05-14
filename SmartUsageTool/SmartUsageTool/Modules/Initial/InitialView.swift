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
                    Label(Localize.myHome, systemImage: "house.fill")
                }
            ListView()
                .tabItem {
                    Label(Localize.list, systemImage: "tablecells")
                }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    InitialView()
}
