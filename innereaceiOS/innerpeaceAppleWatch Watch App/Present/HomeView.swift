//
//  Home.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/3/24.
//
import SwiftUI

struct HomeView: View {
	@StateObject private var vm = HeartRateViewModel()
	@State private var size: CGSize = .zero
	var body: some View {
		GeometryReader { geo in
			ZStack {
				ZStack {
                    
                    //TODO: 나중에 이거 relative하게 바꾸기
					Circle()
						.fill(Color(hex: "A28DD2"))
						.frame(width: 95, height: 95)
                        .position(CGPoint(x: 149, y: 62))
                        .blur(radius: 50)
                    Circle()
                        .fill(Color(hex: "AD5A3F"))
                        .frame(width: 95, height: 95)
                        .position(CGPoint(x: 59, y: 77))
						.blur(radius: 50)
				}
				VStack(spacing: 10) {
					CirCleProgressbar(progress: $vm.heartRateModel.heartRate)
						.frame(width: 98, height: 98)
					VStack(spacing: 0) {
						Text("Pulse")
							.font(.title2)
						Text("TODAY")
							.font(.title3)
							.foregroundStyle(Color(hex: "FF9B9F"))
					}
				}
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background {
                    Color(hex: "3E3215")
                        .ignoresSafeArea()
                        .opacity(0.2)
                }
			}
            .frame(maxWidth: .infinity,maxHeight: .infinity)
			.onAppear {
				vm.startHeartRateQuery()
				calcSize(geo: geo)
			}
		}
	}

	private func calcSize(geo: GeometryProxy) {
	}
}

#Preview {
	HomeView()
}
