//
//  File.swift
//  innerpeace
//
//  Created by 신효성 on 8/19/24.
//

import Foundation
import SwiftUI




extension OpenWindowAction {
    func openWindow(_ window: IPWindow) {
        self.callAsFunction(id: window.id)
    }
    
    func openWindow(_ window: IPWindow, value: any Codable & Hashable) {
        self.callAsFunction(id: window.id, value: value)
    }
}
