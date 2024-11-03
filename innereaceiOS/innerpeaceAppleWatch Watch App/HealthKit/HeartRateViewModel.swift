//
//  HeartRateViewModel.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/3/24.
//

import Foundation
import HealthKit

struct HeartRateModel {
    var heartRate: Double
}

class HeartRateViewModel: ObservableObject {
    
    
    
    @Published var heartRateModel: HeartRateModel = HeartRateModel(heartRate: 0.0)
    
    func startHeartRateQuery() {
        HeartRateManager.shared.startHeartRateQuery { [weak self] samples in
            self?.process(samples)
        }
    }
    
    private func process(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else {
            return
        }

        DispatchQueue.main.async {
            self.heartRateModel.heartRate = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            print(self.heartRateModel.heartRate)
        }
    }
}
