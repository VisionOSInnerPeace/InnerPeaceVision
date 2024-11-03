//
//  Conditionview.swift
//  innerpeace
//
//  Created by 신효성 on 8/28/24.
//
import SwiftUI

struct EmotionView: View {
	@State private var selectedEmotion: String = "today"
	@State private var sliderValue: Double = 73.0

	var body: some View {
		VStack {
			HStack {
				Text("Emotion")
				Spacer()
				IPPicker(selectedItem: $selectedEmotion)
					.onChange(of: selectedEmotion) { oldValue, newValue in
						if oldValue != newValue {
							switch newValue {
							case "today":
								sliderValue = 73.0
							case "yesterday":
								sliderValue = 60.0
							case "weekly":
								sliderValue = 80
							default:
								sliderValue = 73
							}
						}
					}
			}
			Spacer()

			Slider(value: $sliderValue, in: 0...100)
				.padding(.horizontal)
			HStack {
				Text("Bad")
					.foregroundColor(.white)
				Spacer()
				Text("Good")
					.foregroundColor(.white)
			}
			Spacer()

		}.padding(20)
			.glassBackgroundEffect()

	}
}
