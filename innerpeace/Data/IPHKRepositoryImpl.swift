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
                quantityType: heartRateType, quantitySamplePredicate: predicate) { (query, result, error) in
                    if let error = error {
                        continuation.resume(with: .failure(error))
                    } else if let result = result {
                        let avg = result.averageQuantity()?.doubleValue(for: self.hkUnit) ?? 0
                        let min = result.minimumQuantity()?.doubleValue(for: self.hkUnit) ?? 0
                        let max = result.maximumQuantity()?.doubleValue(for: self.hkUnit) ?? 0

                        continuation.resume(with: .success([avg,max,min]))
                    } else {
                        continuation.resume(with: .failure([] as! Error))
                    }
                }
            hkStore.execute(query)
        }
    }
    
    func fetchRespiratoryRateStatics(predicate: NSPredicate) async throws -> [Double] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: respiratoryRateType, quantitySamplePredicate: predicate) { (query, result, error) in
                if let error = error {
                    continuation.resume(with: .failure(error))
                }else if let result = result {
                    let avg = result.averageQuantity()?.doubleValue(for: self.hkUnit) ?? 0
                    let min = result.minimumQuantity()?.doubleValue(for: self.hkUnit) ?? 0
                    let max = result.maximumQuantity()?.doubleValue(for: self.hkUnit) ?? 0
                    
                    continuation.resume(with: .success([avg,max,min]))
                }else{
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

	//MARK: - Private Function

}
