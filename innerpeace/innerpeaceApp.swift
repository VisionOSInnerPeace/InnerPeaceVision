//
//  innerpeaceApp.swift
//  innerpeace
//
//  Created by 신효성 on 8/13/24.
//

import SwiftUI
@main
struct innerpeaceApp: App {

	@StateObject var userSettings = UserSettings()

	var body: some Scene {
		WindowGroup {
            HomeView()
                .environmentObject(userSettings)

		}
		.windowStyle(.plain)

		WindowGroup(id: IPWindow.hkSummary.id) {
			FinishView()
				.environmentObject(userSettings)
		}
		.defaultSize(CGSize(width: 400, height: 500))
		//GeometryReader
		WindowGroup(id: IPWindow.hkDetail.id) {
			FinishDetailView()
				.environmentObject(userSettings)
		}
        
        WindowGroup(id: IPWindow.compare.id, for: [HKChartEntity].self) { item in
            CompareView(current: item)
                
        }.defaultSize(CGSize(width: 1200, height: 500))
        
        
        
        
        
//        WindowGroup(id: IPWindow.compare.id, for: HKChartEntity.self) { item in
//            CompareView(current: item)
//        }
        
        

		ImmersiveSpace(id: IPImmersiveSpace.innerPeace.id) {
			InnerPeaceView()
		}.immersionStyle(selection: .constant(.full), in: .full)
	}
}

enum IPWindow {
	var id: String {
		switch self {
		case .hkSummary:
			"hkSummary"
		case .hkDetail:
			"HKDetail"
        case .compare:
            "compare"
		case .settings:
			"settings"
		}
	}

	case settings
	case hkDetail
	case hkSummary
    case compare
}

enum IPImmersiveSpace {
	var id: String {
		switch self {

		case .innerPeace:
			return "innerPeace"
		}
	}

	case innerPeace
}
