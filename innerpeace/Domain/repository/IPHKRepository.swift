//
//  IPHealthKitRepository.swift
//  innerpeace
//
//  Created by 신효성 on 10/2/24.
//
import HealthKit

protocol IPHKRepository {
    
    func fetchUserHeartRateSamples(predicate: NSPredicate) async throws -> [HKSample]
    
    func fetchUserRespiratoryRateSamples(predicate: NSPredicate) async throws -> [HKSample]
    
    func fetchHeartRateStatics(predicate: NSPredicate) async throws -> [Double]
    
    func fetchRespiratoryRateStatics(predicate: NSPredicate) async throws -> [Double]
    
    func requestHealthKitPermission() async
}
