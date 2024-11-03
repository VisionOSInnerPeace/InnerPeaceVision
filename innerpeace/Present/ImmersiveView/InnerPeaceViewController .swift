//
//  InnerPeaceViewController .swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//

import Combine
import Foundation

final class innerpeaceViewController: ObservableObject {
	private var repo: HKRepository
	private var cancels = Set<AnyCancellable>()

	@Published var BpmSamples: [Double] = []
	@Published var Bpm: Double = 0

	init() {
		self.repo = HKRepository()
		bindRepository()
	}

	private func bindRepository() {

        repo.$hearRateSamples
            .sink { value in
                
            }
            .store(in: &cancels)
	}

	func startHearRateMonitoring() {

	}


}
