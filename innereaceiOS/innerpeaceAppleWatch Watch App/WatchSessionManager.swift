//
//  WatchSessionManager.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/3/24.
//

import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()
    private override init() {}
    
    func startSession() {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // iPhone으로 데이터 전송하는 메서드
    func sendDataToiPhone(data: [String: Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(data, replyHandler: nil) { error in
                print("Error sending message to iPhone: \(error.localizedDescription)")
            }
        }
    }
    
    // WCSessionDelegate 메서드
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // 활성화 상태 확인
        if activationState == .activated {
            print("Watch session activated")
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        // Reachability 상태가 변경될 때 호출
        print("iPhone reachability: \(session.isReachable)")
    }
}
