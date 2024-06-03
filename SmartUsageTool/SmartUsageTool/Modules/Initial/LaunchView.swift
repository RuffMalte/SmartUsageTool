//
//  LaunchView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 17.04.2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var showNextScreen = false
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("LaunchIcon")
                Text("ELEСTRYKA")
                    .font(.system(size: 25, weight: .bold))
                NavigationLink(destination: InitialView(), isActive: $isActive) {
                               EmptyView()
                           }
            }
            .opacity(showNextScreen ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.5).delay(0.5))
            .onAppear {
                         withAnimation {
                             showNextScreen = true
                         }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
                     }
        }
   
    }
}

#Preview {
    LaunchView()
}
