//
//  HomeView.swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct HomeView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var showingBottomSheet = false
    @State var immersiveSpaceShown = true
    @State var isFinished = false
    
    var body: some View {
        RealityView { content in
            if let entity = try? await Entity(named: "Scene", in: realityKitContentBundle){
                content.add(entity)
            }
            
        }
    }
}

struct Switchview: View {
	@Binding var isFinished: Bool
	var body: some View {
		if isFinished {
			FinishView().opacity(isFinished ? 1 : 0)
		} else {
			RealityView { content in

			}
		}
	}
}
#Preview {
	HomeView()
}
