import Combine
import HealthKit
import WatchConnectivity




class HeartRateManager: NSObject, ObservableObject, WCSessionDelegate {
    private var healthStore = HKHealthStore()
    private var session: WCSession?
    
    @Published var heartRate: Double = 0.0

    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        } else {
            print("WCSession is not supported on this device")
        }
    }

    // WatchConnectivity 세션 활성화
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
            return
        }
        print("WCSession activated with state: \(activationState.rawValue)")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession became inactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession deactivated")
        WCSession.default.activate()
    }

    // 메시지 수신 시 심박수 업데이트
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let heartRateValue = message["bpm"] as? Double {
            DispatchQueue.main.async {
                self.heartRate = heartRateValue
                print("Updated heart rate: \(heartRateValue) BPM")
            }
        } else {
            print("Received message but no heart rate data found")
        }
    }

    // Watch로 메시지 전송 요청
    func sendMessageToWatch() {
        if let validSession = session, validSession.isReachable {
            let message = ["request": "heartRate"]
            validSession.sendMessage(message, replyHandler: { response in
                if let heartRateValue = response["heartRate"] as? Double {
                    DispatchQueue.main.async {
                        self.heartRate = heartRateValue
                        print("Received heart rate from watch: \(heartRateValue) BPM")
                    }
                }
            }, errorHandler: { error in
                print("Error sending message to watch: \(error.localizedDescription)")
            })
        } else {
            print("WCSession is not reachable")
        }
    }
}
