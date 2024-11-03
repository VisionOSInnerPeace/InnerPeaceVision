import HealthKitUI
//
//  Untitled.swift
//  innerpeace
//
//  Created by 신효성 on 8/27/24.
//
import SwiftUI

struct HKRingView: UIViewRepresentable {
    @Binding var hkSummary: HKActivitySummary?
    
    
    let ringView = HKActivityRingView()
    func updateUIView(_ uiView: UIViewType, context: Context) {
        ringView.setActivitySummary(hkSummary, animated: true)
    }
    
    func makeUIView(context: Context) -> some UIView {
        ringView.backgroundColor = .clear
        return ringView
    }
    

}

struct FinishDetailRingView: View {
    @Binding var selectedItem: String
    @Binding var hkSummary: HKActivitySummary?
    
	var body: some View {
		VStack {
            HStack {
                Text("Stress")
                    .font(.headline)
                Spacer()
                IPPicker(selectedItem: $selectedItem)
            }.padding(.horizontal)
            HKRingView(hkSummary: $hkSummary)
		}
		.padding(20)
		.glassBackgroundEffect()
        .clipShape(RoundedRectangle(cornerRadius: 0))
        
	}
}
