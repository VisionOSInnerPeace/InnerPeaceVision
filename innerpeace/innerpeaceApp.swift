//
//  innerpeaceApp.swift
//  innerpeace
//
//  Created by 신효성 on 8/13/24.
//

import SwiftUI

@main
struct innerpeaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
