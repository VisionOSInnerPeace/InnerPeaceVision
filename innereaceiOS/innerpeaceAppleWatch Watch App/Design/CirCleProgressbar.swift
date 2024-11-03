//
//  RoundedProgressbar.swift
//  innereaceiOS
//
//  Created by 신효성 on 11/3/24.
//
import SwiftUI
struct CirCleProgressbar: View {
    @Binding var progress: Double
    
    private let minValue: Double = 20
    private let maxValue: Double = 180
    private let lineWidth: Double = 12
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.2)
                .foregroundStyle(Color(hex: "FFECD2"))
            Circle()
                .trim(from: 0.0, to: CGFloat((min(max(self.progress, minValue), maxValue) - minValue) / (maxValue - minValue)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [
                    Color(hex: "FF9B9F"),Color(hex: "FECFEF")
                ], startPoint: .top, endPoint: .bottom))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            Text(String(format: "%.f", min(max(self.progress, minValue), maxValue)))
                .font(.title2)
                .bold()
        }
    }
}


//Color(hex: "FF9B9F"),
//Color(hex: "FECFEF")
