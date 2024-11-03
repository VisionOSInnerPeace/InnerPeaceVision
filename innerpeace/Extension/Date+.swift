//
//  Date+.swift
//  innerpeace
//
//  Created by 신효성 on 8/21/24.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toString() -> String {
        return toString(format: "yy-MM-dd")
    }
}

