//
//  FinishDetailVIewController.swift
//  innerpeace
//
//  Created by 신효성 on 8/20/24.
//

import Combine
import Foundation
import HealthKit

final class FinishDetailViewModel: ObservableObject {
	private var cancels: Set<AnyCancellable> = []
	private var repo: HKRepository = HKRepository()

	@Published var heartRateData: HKChartEntity?
    @Published var respiratoryRateData: HKChartEntity?
	@Published var activitySummary: HKActivitySummary?
    @Published var remainTime: String = ""
    @Published var remainTimePercent: Double = 0
    private var settings: UserSettings = .init()
    init() {
		self.binding()
	}

	func binding() {
		repo.$activitySamples.sink { value in
			self.activitySummary = value.first
		}.store(in: &cancels)
        
        repo.$hearRateSamples.sink { value in
            self.heartRateData = HKChartEntity(type: .heartRate, datas: value.map { HKChartData(index: $0.key, data: $0.value, type: .heartRate) })
        }.store(in: &cancels)
        
        repo.$respiratoryRateSamples.sink { value in
            self.respiratoryRateData = HKChartEntity(type: .respiratoryRate, datas: value.map { HKChartData(index: $0.key, data: $0.value, type: .respiratoryRate) })
        }.store(in: &cancels)
        
	}
    
    func fetchSamples() {
        repo.fetchHeartRateSampleDummy()
        repo.fetchRespiratoryRateSampleDummy()
    }
    
    //MARK: - MeditationView
    
    func calcRemainTime()  {
        let min = Int(settings.timeInterval / 60)
        let sec = Int(settings.timeInterval - Double(min * 60))
        remainTime = "\(min):\(sec)"
    }
    
    func calcRemainTimePercent() {
        let total = Double(20 * 60)
        let remain = Double(settings.timeInterval)
        remainTimePercent =  remain / total
    }


}
