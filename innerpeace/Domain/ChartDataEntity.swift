//
//  ChartDataEntity.swift
//  innerpeace
//
//  Created by 신효성 on 8/21/24.
//

import SwiftUI

struct HKChartData: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var index: Int
    var data: Double
    var type: HKTypeName
}

struct HKChartEntity: Hashable, Codable {
    var type: HKTypeName
    var date: Date = Date.now
    var datas: [HKChartData]
}


enum HKTypeName: CustomStringConvertible,Codable {
    var description: String {
        switch self {
        case.heartRate:
            "Pulse stability"
        case.respiratoryRate:
            ///MARK: - 애플 워치 8부터 지원
            "Breathing stability"
        }
    }
    
    var color: Color {
        switch self {
        case.heartRate:
                .red
        case.respiratoryRate:
                .green
        }
    }
    case heartRate
    case respiratoryRate
    

}
