//
//  ContentView.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/2/24.
//

import SwiftUI
import HealthKit



struct ContentView: View {
    @StateObject private var heartRateManager = HeartRateManager()
    
    
    init() {
        SessionManager.shared.startSession()
    }
    
    var body: some View {
        VStack {
            Text("실시간 심박수")
                .font(.title)
            Text("\(Int(heartRateManager.heartRate)) BPM")
                .font(.largeTitle)
                .foregroundColor(.red)
                .padding()
            Button("Watch에 메시지 보내기") {
                heartRateManager.sendMessageToWatch()
            }
            .padding()
            .foregroundColor(.blue)
        }
        .onAppear {
            print("ContentView appeared, attempting to connect to Watch.")
        }
    }
}

