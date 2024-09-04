//
//  InfoView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.04.2024.
//

import SwiftUI

struct DeviceInfoView: View {
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
//                .lineLimit(1)
//                .minimumScaleFactor(0.5)
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
	DeviceInfoView(initialValue: 0.5, type: "hrs", title: "Daily Usage")
}

import SwiftUI

struct DeviceInfoWithTextfield: View {
	let initialValue: Double
	let type: String
	let title: String
	let onValueChanged: (Double) -> Void
	let minValue: Double?
	let maxValue: Double?
	let usePicker: Bool?
	
	@State private var textFieldValue: String
	@State private var pickerValue: Double
	
	init(initialValue: Double, type: String, title: String, minValue: Double? = nil, maxValue: Double? = nil, usePicker: Bool? = nil, onValueChanged: @escaping (Double) -> Void) {
		self.initialValue = initialValue
		self.type = type
		self.title = title
		self.onValueChanged = onValueChanged
		self.minValue = minValue
		self.maxValue = maxValue
		self.usePicker = usePicker
		
		let formatted = String(format: "%.1f", initialValue)
		self._textFieldValue = State(initialValue: formatted.replacingOccurrences(of: ".0", with: ""))
		self._pickerValue = State(initialValue: initialValue)
	}
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text(title)
					.fontWeight(.semibold)
				
				if let usePickerValue = usePicker, usePickerValue {
					pickerView
				} else {
					textFieldView
				}
			}
		}
	}
	
	private var pickerView: some View {
		Picker(title, selection: $pickerValue) {
			let range = stride(from: minValue ?? 0, through: maxValue ?? 100, by: 1)
			ForEach(Array(range), id: \.self) { value in
				Text(String(format: "%.0f", value)).tag(value)
			}
		}
		.pickerStyle(.wheel)
		.onChange(of: pickerValue) { oldValue, newValue in
			let constrainedValue = constrain(value: newValue, minValue: minValue, maxValue: maxValue)
			onValueChanged(constrainedValue)
		}
	}
	
	private var textFieldView: some View {
		HStack {
			TextField("Enter \(title)", text: $textFieldValue)
				.keyboardType(.decimalPad)
				.font(.system(.headline, design: .monospaced, weight: .regular))
			
			Spacer()
			
			Text(type)
				.foregroundStyle(.gray)
		}
		.padding()
		.background(Color(.systemGray6))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.onChange(of: textFieldValue) { oldValue, newValue in
			if let doubleValue = Double(newValue) {
				let constrainedValue = constrain(value: doubleValue, minValue: minValue, maxValue: maxValue)
				if constrainedValue != doubleValue {
					DispatchQueue.main.async {
						self.textFieldValue = String(format: "%.1f", constrainedValue)
					}
				}
				onValueChanged(constrainedValue)
			}
		}
	}
	
	private func constrain(value: Double, minValue: Double?, maxValue: Double?) -> Double {
		var result = value
		if let minVal = minValue {
			result = Swift.max(minVal, result)
		}
		if let maxVal = maxValue {
			result = Swift.min(maxVal, result)
		}
		return result
	}
}
#Preview {
	DeviceInfoWithTextfield(initialValue: 0.5, type: "hrs", title: "Daily Usage") { value in
		print(value)
	}
}

struct DeviceInfoViewSmall: View {
	var initialValue: Double
	var type: String
	var icon: String?
	var formattedValue: String {
		let formatted = String(format: "%.1f", initialValue)
		return formatted.replacingOccurrences(of: ".0", with: "")
	}
	
	var body: some View {
		HStack {
			if let icon = icon {
				Image(systemName: icon)
			}
			
			Text(formattedValue)
				.font(.system(.subheadline, design: .monospaced, weight: .semibold))
			Text(type)
				.foregroundStyle(.gray)
		}
		
	}
}
