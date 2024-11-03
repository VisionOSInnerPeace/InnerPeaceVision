//
//  DismissWindowAction+.swift
//  innerpeace
//
//  Created by 신효성 on 8/20/24.
//

import SwiftUI

extension DismissWindowAction {
    func dismissWindow(_ window: IPWindow) {
        self.callAsFunction(id: window.id)
    }
    
    func dismissWindow(_ window: IPWindow, value: any Hashable & Codable) {
        self.callAsFunction(id: window.id, value: value)
    }
}
