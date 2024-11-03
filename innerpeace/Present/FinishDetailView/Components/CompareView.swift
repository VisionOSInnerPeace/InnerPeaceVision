import Charts
//
//  CompareView.swift
//  innerpeace
//
//  Created by 신효성 on 8/28/24.
//
import SwiftUI

struct CompareView: View {

	@Binding
	var current: [HKChartEntity]?

	@StateObject var repo = HKRepository()

	@State var selected: String = "yesterday"

	let options: [String] = ["yesterday", "weekly"]

	var body: some View {
		VStack(spacing: 20) {
			HStack {
                Text("Compare \(current?.first?.type.description ?? "")")
					.font(.system(size: 32))
					.fontWeight(.bold)
				Spacer()
				Picker("Select", selection: $selected) {
					ForEach(options, id: \.self) { item in
						Text(item)
					}
				}.pickerStyle(.segmented).frame(maxWidth: 600)
			}
			HStack(spacing: 20) {
                Chart(current?.first?.datas.sorted { $0.index < $1.index } ?? []) {
					LineMark(
						x: .value("Time", $0.index),
						y: .value("Stability", $0.data)
					)
					.foregroundStyle($0.type.color)
				}
                if selected == "yesterday" {
                    Chart(current?[1].datas.sorted { $0.index < $1.index } ?? []) {
                        LineMark(
                            x: .value("Time", $0.index),
                            y: .value("Stability", $0.data)
                        )
                        .foregroundStyle($0.type.color)
                    }
                }else {
                    Chart(current?[2].datas.sorted { $0.index < $1.index } ?? []) {
                        LineMark(
                            x: .value("Time", $0.index),
                            y: .value("Stability", $0.data)
                        )
                        .foregroundStyle($0.type.color)
                    }
                }

			}
		}.padding()
			.onAppear {

			}

	}
}
