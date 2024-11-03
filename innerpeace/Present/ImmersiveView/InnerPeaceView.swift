//
//  InnerPeaceView.swift
//  innerpeace
//
//  Created by 신효성 on 8/27/24.
//

import RealityKit
import RealityKitContent
import SwiftUI
import VisionKit
import Then
struct InnerPeaceView: View {
    let pointLight = PointLight()
    let directionalLight = DirectionalLight()
    let spotLight = SpotLight()
    
    
    let redLight = PointLight()
    let blueLight = PointLight()
    let greenLight = PointLight()
    
    
    var body: some View {
        
        
        RealityView { content in
            let anchor = AnchorEntity(world: [0, 1, 0]) // 월드 좌표계에 앵커를 설정
            content.add(anchor)

            let scene = "Scene"
            //let test = "test"
            
            if let immersiveContentEntity = try? await Entity(
                named: scene, in: realityKitContentBundle)
            {
                immersiveContentEntity.setPosition(SIMD3<Float>(0, 0, 0), relativeTo: nil)
                immersiveContentEntity.scale = .init(1,1,1)
                anchor.addChild(immersiveContentEntity)
            }
        }
    }
}

