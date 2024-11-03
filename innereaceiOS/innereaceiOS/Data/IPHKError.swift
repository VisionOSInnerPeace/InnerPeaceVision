//
//  IPHKError.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/2/24.
//

enum IPHKError: Error, CustomStringConvertible {
    var description: String {
        switch self {
        case .notAvailable:
            return "HealthKit is not available on this"
        case .queryNotFound:
            return "HKAnchoredQuery not found"
        }
    }
    
    
    case notAvailable
    case queryNotFound
}

