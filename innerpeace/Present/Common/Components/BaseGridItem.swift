//
//  ri.swift
//  innerpeace
//
//  Created by 신효성 on 8/28/24.
//
import SwiftUI

struct BaseGridItem<Content: View>: View {

	@Environment(\.openWindow) var openWindow
	@Environment(\.dismissWindow) var dismissWindow

	@Binding var selectedItem: String?
	@State var title: String
	let content: Content
	init(title: String, @ViewBuilder content: () -> Content) {
        self.init(title: title, pickerItem: .constant(nil), content: content() as! () -> Content)
	}

	init(title: String, pickerItem: Binding<String?>, @ViewBuilder content: () -> Content) {
		self.title = title
		_selectedItem = pickerItem
		self.content = content()
	}

	var body: some View {
		VStack {
			HStack {
				Text(title)
					.font(.headline)
					.fontWeight(.semibold)
				Spacer()
				if let selectedItem = selectedItem {
				}
			}
			.padding(.bottom)
			content
		}
		.padding(20)
		.glassBackgroundEffect()
	}
}
