//
//  FinishDetailView.swift
//  innerpeace
//
//  Created by 신효성 on 8/19/24.
//

import Charts
import SwiftUI

struct FinishDetailView: View {

	@EnvironmentObject var userSettings: UserSettings

    @Environment(\.dismissWindow) var dismissWindow
    
	@ObservedObject
	var vm: FinishDetailViewModel = FinishDetailViewModel()
	@State private var targetDate = Date.now
	@State private var isModalPresent = false

	@State private var selectedItem: String? = "today"
	var indexCount: [Int] = Array(0..<20)

	var body: some View {
		GeometryReader { geo in
			NavigationStack {
				VStack {
					FinishDetailViewHeader()
					Spacer()
					LazyVGrid(
						columns: [
							GridItem(.flexible()),
							GridItem(.flexible()),
							//GridItem(.flexible()),
						], spacing: 10
					) {
						MeditationSessionView(
							progress: $vm.remainTimePercent,
							remainingTime: $vm.remainTime
						)
						.frame(height: geo.size.height / 2 - 120)
						.padding()
						ChartView(
							hkName: .heartRate,
							chartData: $vm.heartRateData
						)
						.frame(height: geo.size.height / 2 - 120)
						EmotionView()
							.frame(height: geo.size.height / 2 - 120)
							.padding()
						ChartView(
							hkName: .respiratoryRate,
							chartData: $vm.respiratoryRateData
						)
						.frame(height: geo.size.height / 2 - 80).padding()
					}.padding()
					Spacer()
				}
			}
		}.onAppear {
			vm.fetchSamples()
			vm.calcRemainTime()
			vm.calcRemainTimePercent()
		}

	}
}

#Preview {
	FinishDetailView()
}
