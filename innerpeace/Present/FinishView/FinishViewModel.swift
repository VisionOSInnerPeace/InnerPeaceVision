//
//  FinishViewController.swift
//  innerpeace
//
//  Created by 신효성 on 8/19/24.
//

import Combine
import HealthKit
import SwiftUI

class FinishViewModel: ObservableObject {
	private var cancels: Set<AnyCancellable> = []
	private let repo = HKRepository()

	//MARK: - Properties

	@Published var heartRateResult: HKHeartRateResult?

	init() {
		binding()
	}

	func binding() {
		repo.$heartRateResult.sink { value in
			self.heartRateResult = value
		}.store(in: &cancels)
	}

	func presentDetailView(_ windowAction: OpenWindowAction) {
		windowAction.openWindow(.hkDetail)
	}
	func dismissDetailView(_ windowAction: DismissWindowAction) {
		windowAction.dismissWindow(.hkDetail)
	}
    
    func fetchHeartRateResult() {
        repo.fetchHeartRateStaticsDummy()
    }

}
