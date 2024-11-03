import Foundation
import HealthKit

final class HKRepository: ObservableObject {
	private let hkStore = HKHealthStore()
	private let hkUnit = HKUnit(from: "count/min")

	//MARK: - HKType
	private let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
	private let respiratoryRateType = HKQuantityType.quantityType(
		forIdentifier: .respiratoryRate)!

	//MARK: - Published
	@Published public var activitySamples: [HKActivitySummary] = []

	@Published public var heartRateResult: HKHeartRateResult = .init(avg: 0, min: 0, max: 0)
	@Published public var hearRateSamples: [Int: Double] = [:]
    @Published public var respiratoryRateSamples: [Int: Double] = [:]
	//MARK: - init
	init() {
	}

	//MARK: - function
	func requestAuthorization() {
		guard HKHealthStore.isHealthDataAvailable() else {
			print(" HealthKit is not available on this device")
			return
		}

		let readTypes: Set<HKQuantityType> = [heartRateType, respiratoryRateType]

		hkStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
			if let error = error {
				print("auth error: \(error.localizedDescription)")
			}
		}
	}

	func isAuthorized() -> Bool {
		return [heartRateType, respiratoryRateType].allSatisfy {
			hkStore.authorizationStatus(for: $0) == .sharingAuthorized
		}
	}

	func fetchHeartRateSample() {
		let startDate = Calendar.current.date(
			byAdding: .minute, value: -20, to: Date())!
		let predicate = makePredicate(.minute, startTime: -20)

		// HealthKit Query
		let query = HKSampleQuery(
			sampleType: heartRateType, predicate: predicate,
			limit: HKObjectQueryNoLimit, sortDescriptors: nil
		) { (query, samples, error) in
			guard let samples = samples as? [HKQuantitySample], error == nil else {
				return
			}
			let calendar = Calendar.current

			// 데이터를 분 단위로 그룹화합니다.
			var heartRatePerMinute = [Int: (totalBPM: Double, count: Int)]()  // [분: [BPM 리스트]]

			for sample in samples {
				let bpm = sample.quantity.doubleValue(
					for: self.hkUnit)

				// 각 샘플의 시작 시간이 속한 분을 기준으로 그룹화합니다.
				let minutesFromStart =
					calendar.dateComponents(
						[.minute], from: startDate, to: sample.startDate
					).minute ?? 0

				if heartRatePerMinute[minutesFromStart] != nil {
					heartRatePerMinute[minutesFromStart]!.totalBPM += bpm
					heartRatePerMinute[minutesFromStart]!.count += 1
				} else {
					heartRatePerMinute[minutesFromStart] = (bpm, 1)
				}
			}

			DispatchQueue.main.async {
				self.hearRateSamples = heartRatePerMinute.mapValues { value in
					value.totalBPM / Double(value.count)
				}
			}
		}

		hkStore.execute(query)
	}

	func fetchHkActivitySummary() {
		let query = HKActivitySummaryQuery(predicate: makePredicate(.day, startTime: -1)) {
			query, summarys, error in
			if let error = error {
				print("error: \(error.localizedDescription)")
				return
			}
			if let summarys = summarys {
				DispatchQueue.main.async {
					self.activitySamples = summarys
				}
			}
		}
		hkStore.execute(query)
	}

	///bpm 가져옴
	func fetchHeartRateStatistics() {
		let query = HKStatisticsQuery(
			quantityType: heartRateType,
			quantitySamplePredicate: makePredicate(.minute, startTime: -20),
			options: [.discreteAverage, .discreteMax, .discreteMin]
		) { query, result, error in
			if let error = error {
				print("Error fetching statistics: \(error.localizedDescription)")
				return
			}

			if let result = result {
				let avgHeartRate =
					result.averageQuantity()?.doubleValue(
						for: self.hkUnit) ?? 0.0
				let maxHeartRate =
					result.maximumQuantity()?.doubleValue(
						for: self.hkUnit) ?? 0.0	
				let minHeartRate =
					result.minimumQuantity()?.doubleValue(
						for: self.hkUnit) ?? 0.0

				DispatchQueue.main.async {
					self.heartRateResult = .init(
						avg: avgHeartRate, min: minHeartRate,
						max: maxHeartRate)
				}
			}
		}
		hkStore.execute(query)
	}

   
	// MARK: - Private Methods
	private func makePredicate(_ component: Calendar.Component, startTime: Int) -> NSPredicate {
		let now = Date()
		let startDate = Calendar.current.date(
			byAdding: component, value: startTime, to: now)!
		return HKQuery.predicateForSamples(
			withStart: startDate, end: now, options: .strictStartDate)
	}
}
