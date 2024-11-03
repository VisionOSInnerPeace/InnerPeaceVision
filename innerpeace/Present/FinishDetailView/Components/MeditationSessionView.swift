import SwiftUI

struct MeditationSessionView: View {
    @EnvironmentObject var userSettings: UserSettings

	@Binding var progress: Double
	@Binding var remainingTime: String

	var body: some View {
		VStack {
			HStack {
				Text("Meditation session")
					.font(.headline)
					.fontWeight(.bold)
				Spacer()
            }.padding(.horizontal)
                .padding(.bottom)
			ZStack {
				Circle()
					.stroke(Color.gray.opacity(0.2), lineWidth: 15)

				Circle()
					.trim(from: 0.0, to: progress)
					.stroke(
						AngularGradient(
							gradient: Gradient(colors: [
								Color.red, Color.orange,
								Color.green,
							]),
							center: .center
						),
						style: StrokeStyle(lineWidth: 15, lineCap: .round)
					)
					.rotationEffect(.degrees(-90))

				
				Text(remainingTime)
					.font(.system(size: 40, weight: .bold))
					.foregroundColor(.white)
            }.padding()

		}
		.padding()
		.glassBackgroundEffect()
		.cornerRadius(20)
		.shadow(radius: 10)
        
	}
}
//
//  MeditationSessionView.swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//
