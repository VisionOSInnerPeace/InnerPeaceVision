//
//  YujinTest.swift
//  innerpeace
//
//  Created by 신효성 on 8/27/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct YujinTest: View {
    var body: some View {
        Model3D(named: "YujinScene", bundle: realityKitContentBundle)
    }
}

#Preview {
    YujinTest()
}
