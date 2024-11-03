//
//  IPHealthKitService.swift
//  innerpeace
//
//  Created by 신효성 on 10/2/24.
//
import HealthKit

final class IPHealthKitService: IPHealthKitServiceProtocol {
    private let hkRepository: IPHKRepositoryImpl
    private final let hkUnit = HKUnit(from: "count/min")

    @Published var hearRate: Double = .zero
    
    
    init(hkRepository: IPHKRepositoryImpl) {
        self.hkRepository = hkRepository
    }
    
    func fetchCurrentHeartRate() async throws  {
    }

    
    func monitorHeartRate() async throws {
        hearRate = try await hkRepository.startHeartrateQuery(a: true)
        
    }
}
