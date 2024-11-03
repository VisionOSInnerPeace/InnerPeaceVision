//
//  WatchSessionManager.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/3/24.
//
import WatchConnectivity

final class SessionManager: NSObject, WCSessionDelegate {
	func startSession() {
		if WCSession.isSupported() {
			WCSession.default.delegate = self
			WCSession.default.activate()
		}
	}

	func session(
		_ session: WCSession,
		activationDidCompleteWith activationState: WCSessionActivationState,
		error: (any Error)?
	) {
		if let error = error {
			print(
				"WCSession activation failed with error: \(error.localizedDescription)"
			)
		} else {
			print("WCSession activated with state: \(activationState.rawValue)")
		}
	}

	func sessionDidBecomeInactive(_ session: WCSession) {
		print("sessionDidBecomeInactive")
	}

	func sessionDidDeactivate(_ session: WCSession) {
		print("sessionDidDeactivate")
	}

	static let shared = SessionManager()
	private override init() {}

	func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
		message.forEach { (key, value) in
			print("\(key): \(value)")
		}
	}
}
