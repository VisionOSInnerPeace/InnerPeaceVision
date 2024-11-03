//
//  HealthEntity.swift
//  innerpeace
//
//  Created by 신효성 on 8/19/24.
//

import Foundation

struct HKDetailEntity: Identifiable, Hashable {
    var id =  UUID()
    var heartRateStatics: [Double]
    var respiratoryRateStatics: [Double]
    var time: [Date]
}

//struct HKSummaryEntity: Hashable {
//    var averageRespiratoryRate: Double
//    var detail: HKDetailEntity
//}


struct HKHeartRateResult: Hashable {
    var avg: Double
    var min: Double
    var max: Double
}


