//
//  HomeBottomToolbarView.swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//
import SwiftUI

struct HomeBottomToolbarView: View {
	@Binding var isPresent: Bool
	@Binding var isShowing: Bool


	var body: some View {

		HStack {
			Button("", systemImage: "timer") {
				isPresent.toggle()
			}.padding()

			Button("", systemImage: "User") {

			}.padding()

			Button("", systemImage: "globe") {
				isShowing.toggle()
			}
			.padding()
		}
		//일단 밑으로 뺌
		.sheet(
			isPresented: $isPresent,
			content: {
				VStack {
					Button("Meditation Time") {
						isPresent = false
					}
					.padding()

					HStack {
						Button("3 min") {
							isPresent.toggle()
						}
						.padding()

						Button("5 min") {
							isPresent.toggle()
						}.padding()

						Button("10 min") {
							isPresent.toggle()
						}.padding()
					}

				}
			}
		)
		.sheet(
			isPresented: $isShowing,
			content: {
				VStack {
					Button("My Page") {
						isShowing = false
					}
					.padding()

					HStack {
						//버튼 눌렀을때 시간 설정되게 프로그램과 연결

						Button("") {
							isShowing.toggle()
						}
						.padding()

						Button("") {
							isShowing.toggle()
						}.padding()

						Button("") {
							isShowing.toggle()
						}.padding()
					}

				}
			}
		)
	}
}
