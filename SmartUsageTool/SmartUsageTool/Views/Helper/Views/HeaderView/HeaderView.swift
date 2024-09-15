//
//  HeaderView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 10.09.24.
//

import SwiftUI

struct HeaderView: View {
	
	
	var title: any View
	
    var body: some View {
		HStack {
			AnyView(title)
				.font(.system(.largeTitle, weight: .bold))

			Spacer()
		}
		.padding()
		.background(Color.background)
    }
}

#Preview {
	HeaderView(title: Text("Helloooooo"))
}
