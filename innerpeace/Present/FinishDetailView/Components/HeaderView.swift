//
//  Header.swift
//  innerpeace
//
//  Created by 신효성 on 8/26/24.
//
import SwiftUI
struct FinishDetailViewHeader: View {
    let title: String = "Inner Peace"
    let url: URL
    
    init(userProfileUrl: String = "") {
        self.url = URL(string: userProfileUrl) ?? URL(string:  "https://nng-phinf.pstatic.net/MjAyNDAyMTRfNDMg/MDAxNzA3OTA5MTQ5NDU4.G5K-PKWURUPk7PC42iPSXn6YSOBF2I2PAW1Smzt0Wk4g.nwSoSF4VAZshbbuf2ksHk68NA5dZTqhFequVgvGWEHgg.JPEG/333333.jpg")!
    
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 40))
                .fontWeight(.heavy)
            Spacer()
            AsyncImage(url: self.url) {
                $0.image?.resizable()
                    .scaledToFill()
            }.frame(width: 52, height: 52)
                .clipShape(Circle())
        }.padding()
            .padding(.horizontal, 16)
    }
}
