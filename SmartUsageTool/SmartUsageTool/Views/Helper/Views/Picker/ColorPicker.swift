//
//  ColorPicker.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 17.09.24.
//


import SwiftUI

struct ColorPicker: View {
	
	@Binding var selectedColor: ColorEnum
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(ColorEnum.allCases) { color in
					Button {
						withAnimation(.easeInOut(duration: 0.1)) {
							playNotificationHaptic(.success)
							selectedColor = color
						}
					} label: {
						Image(systemName: "checkmark")
							.foregroundStyle(.primary)
							.font(.system(.title3, design: .default, weight: .bold))
							.opacity(selectedColor == color ? 1 : 0)
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 4)
									.foregroundStyle(color.toColor.gradient)
									.shadow(radius: 2)
							}
					}
					
					.buttonStyle(.plain)
				}
				
			}

		}
	}
}

#Preview {
	Form {
		Section {
			ColorPicker(selectedColor: .constant(ColorEnum.red))
		}
	}
}
