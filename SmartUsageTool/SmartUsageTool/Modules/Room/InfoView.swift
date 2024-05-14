//
//  InfoView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import SwiftUI

struct InfoView: View {
    let initialValue: Double
    let type: String
    let title: String
    var formattedValue: String {
        let formatted = String(format: "%.1f", initialValue)
        return formatted.replacingOccurrences(of: ".0", with: "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            HStack {
                Text(formattedValue)
                Spacer()
                Text(type)
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(.lightGrayBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    InfoView(initialValue: 0.5, type: "hrs", title: "Daily Usage")
}
