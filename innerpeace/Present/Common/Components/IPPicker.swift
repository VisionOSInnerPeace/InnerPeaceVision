//
//  IPPicker.swift
//  innerpeace
//
//  Created by 신효성 on 8/27/24.
//
import SwiftUI
struct IPPicker: View {
    @Binding var selectedItem: String
    
    let items: [String] = ["today","yesterday","weekly"]
    var body: some View {
        Picker("Select", selection: $selectedItem) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.system(size: 4))
                    .background(selectedItem == item ? Color.blue : Color.clear)
                    .cornerRadius(8)
            }
        }.pickerStyle(.segmented)
            .frame(maxWidth: 350)
    }
}
