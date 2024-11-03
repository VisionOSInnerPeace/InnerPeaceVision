//
//  FinishView.swift
//  innerpeace
//
//  Created by 신효성 on 8/19/24.
//

import SwiftUI

struct FinishView: View {
	@StateObject
	var vm: FinishViewModel = FinishViewModel()

	@Environment(\.openWindow) var openWindow
	@Environment(\.dismissWindow) var dismissWindow

	@State private var scale: CGFloat = 1.0
	@State private var opacity: Double = 1.0

	var body: some View {

		VStack(alignment: .center, spacing: 30) {
			Text("InnerPeace Result")
                .font(.system(size: 30))
				.fontWeight(.bold)
			Image(systemName: "heart.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundColor(.red)
				.scaleEffect(scale)
				.opacity(opacity)
				.onAppear {
					withAnimation(
						Animation.easeInOut(duration: 0.8).repeatForever(
							autoreverses: true)
					) {
						scale = 1.2
						opacity = 0.8
					}
				}
            Text("Your avg bpm : \(String(format: "%0.1f", vm.heartRateResult?.avg ?? 0))")
                .font(.system(size: 20))
                .fontWeight(.semibold)
				.colorMultiply(.red)
                
			Button("more detail", action: { vm.presentDetailView(openWindow) })
		}
		//TODO: 하단바와 괴리감이 있음
		.frame(maxWidth: 400, maxHeight: 500)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.glassBackgroundEffect()
		.onAppear {
            vm.fetchHeartRateResult()
		}
		.onDisappear {
			vm.dismissDetailView(dismissWindow)
		}
	}
}

#Preview {
	FinishView()
}
