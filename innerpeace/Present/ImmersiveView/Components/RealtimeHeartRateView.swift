//
//  RealtimeHeartRateView.swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//

import SwiftUI

struct RealtimeHeartRateView: View {
	@State private var scale: CGFloat = 1.0
	@State private var opacity: Double = 1.0

    @StateObject
	var vc: innerpeaceViewController = innerpeaceViewController()
	var body: some View {
		VStack {

			Image(systemName: "heart.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundColor(.red)
				.scaleEffect(scale)
				.opacity(opacity)
				.onAppear {
					vc.startHearRateMonitoring()
					print(vc.Bpm)
					withAnimation(
						Animation.easeInOut(duration: 0.8).repeatForever(
							autoreverses: true)
					) {
						scale = 1.2
						opacity = 0.8
					}
                }.onDisappear {
                }
			Button("stop") {

			}

			Button("start") {
				print("started")
			}

		}
	}
}

#Preview(windowStyle: .plain) {
	RealtimeHeartRateView()
}
