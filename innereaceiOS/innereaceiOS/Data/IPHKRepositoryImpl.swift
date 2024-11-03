//
//  IPHealthKitRepository.swift
//  innerpeace
//
//  Created by 신효성 on 10/2/24.
//

import Combine
import HealthKit

final class IPHKRepositoryImpl: IPHKRepository {

	//MARK: - HealthKit Setup

	private final let hkStore = HKHealthStore()
	private final let hkUnit = HKUnit(from: "count/min")

	private final let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
	private final let respiratoryRateType = HKQuantityType.quantityType(
		forIdentifier: .respiratoryRate)!

	//MARK: - Implement

	func fetchUserHeartRateSamples(predicate: NSPredicate) async throws -> [HKSample] {
		return try await withCheckedThrowingContinuation { continuation in
			let query = HKSampleQuery(
				sampleType: heartRateType, predicate: predicate,
				limit: HKObjectQueryNoLimit, sortDescriptors: nil
			) { (query, samples, error) in
				if let error = error {
					continuation.resume(with: .failure(error))
				} else if let samples = samples {
					continuation.resume(with: .success(samples))
				} else {
					continuation.resume(with: .failure([] as! Error))
				}

			}
			hkStore.execute(query)
		}
	}

	func fetchUserRespiratoryRateSamples(predicate: NSPredicate) async throws -> [HKSample] {
		return try await withCheckedThrowingContinuation { continuation in
			let query = HKSampleQuery(
				sampleType: respiratoryRateType, predicate: predicate,
				limit: HKObjectQueryNoLimit, sortDescriptors: nil
			) { (query, samples, error) in
				if let error = error {
					continuation.resume(with: .failure(error))
				} else if let samples = samples {
					continuation.resume(with: .success(samples))
				} else {
					continuation.resume(with: .failure([] as! Error))
				}
			}

			hkStore.execute(query)
		}
	}

	func fetchHeartRateStatics(predicate: NSPredicate) async throws -> [Double] {
		return try await withCheckedThrowingContinuation { continuation in
			let query = HKStatisticsQuery(
				quantityType: heartRateType, quantitySamplePredicate: predicate
			) { (query, result, error) in
				if let error = error {
					continuation.resume(with: .failure(error))
				} else if let result = result {
					let avg =
						result.averageQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0
					let min =
						result.minimumQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0
					let max =
						result.maximumQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0

					continuation.resume(with: .success([avg, max, min]))
				} else {
					continuation.resume(with: .failure([] as! Error))
				}
			}
			hkStore.execute(query)
		}
	}

	func fetchRespiratoryRateStatics(predicate: NSPredicate) async throws -> [Double] {
		return try await withCheckedThrowingContinuation { continuation in
			let query = HKStatisticsQuery(
				quantityType: respiratoryRateType,
				quantitySamplePredicate: predicate
			) { (query, result, error) in
				if let error = error {
					continuation.resume(with: .failure(error))
				} else if let result = result {
					let avg =
						result.averageQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0
					let min =
						result.minimumQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0
					let max =
						result.maximumQuantity()?.doubleValue(
							for: self.hkUnit) ?? 0

					continuation.resume(with: .success([avg, max, min]))
				} else {
					continuation.resume(with: .failure([] as! Error))
				}
			}

			hkStore.execute(query)
		}

	}

	func requestHealthKitPermission() async {
		guard HKHealthStore.isHealthDataAvailable() else { return }
		do {
			try await hkStore.requestAuthorization(
				toShare: [], read: [heartRateType, respiratoryRateType])
		} catch {
			print("failed to request authorization \(error)")
		}
	}
    
    private var heartRateMonitoringQuery: HKAnchoredObjectQuery?

    
    func startHeartrateQuery(a: Bool) async throws -> Double {
        return try await withCheckedThrowingContinuation { continuation in
            self.heartRateMonitoringQuery = HKAnchoredObjectQuery(
                type: heartRateType,
                predicate: nil,
                anchor: nil,
                limit: HKObjectQueryNoLimit
            ) { (query, samples, _, _, error) in
                guard let samples = samples else { return }
                if let error = error {
                    continuation.resume(throwing: error)
                }
                
                let sample = samples.last as! HKQuantitySample
                continuation.resume(returning: sample.quantity.doubleValue(for: self.hkUnit))
            }
            if let query = heartRateMonitoringQuery {
                hkStore.execute(query)
            }else{
                continuation.resume(throwing: IPHKError.queryNotFound)
            }

        }
    }
    
	func startHeartRateQuery() async {
        heartRateMonitoringQuery = HKAnchoredObjectQuery(
			type: heartRateType,
			predicate: nil,
			anchor: nil,
			limit: HKObjectQueryNoLimit
		) { (query, samples, _, _, error) in
			guard let samples = samples else { return }
			if let error = error {
				print("heart rate error : \(error)")
                return	
			}
            
            samples.forEach { sample in
                let qSample = sample as! HKQuantitySample
                let hearRate = qSample.quantity.doubleValue(for: self.hkUnit)
            }
            
            
        }
        if let query = heartRateMonitoringQuery {
            hkStore.execute(query)
        }else{
            print("failed start query")
        }
	}
    
    func stopHeartRateQuery() {
        if let query = heartRateMonitoringQuery{
            hkStore.stop(query)
            heartRateMonitoringQuery = nil
        }
    }

	//MARK: - Private Function

	private func handleHeartRateSamples(_ samples: [HKSample]) async throws -> Double {
		return try await withCheckedThrowingContinuation { continuation in

			for sample in samples {
				guard let quantitySample = sample as? HKQuantitySample else { continue }
				let heartRateValue = quantitySample.quantity.doubleValue(
                    for: hkUnit)
				continuation.resume(returning: heartRateValue)
			}
		}
	}
}
