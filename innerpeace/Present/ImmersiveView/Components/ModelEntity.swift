//
//  ModelEntity.swift
//  innerpeace
//
//  Created by 신효성 on 8/27/24.
//

import ARKit
import RealityKit
import RealityKitContent

@Observable
@MainActor
class EntityModel {
	let session = ARKitSession()
	let sceneReconstruction = SceneReconstructionProvider()

	var sceneMeshMaterial: Material = SimpleMaterial(color: .green, isMetallic: false)

	var contentEntity = Entity()

	var discoballEntity = Entity()

    var ballPosition: SIMD3<Float> = SIMD3(0, 0, 0) {
		didSet {
			guard var mat = sceneMeshMaterial as? ShaderGraphMaterial else { return }
			do {
				try mat.setParameter(
					name: "DiscoballPosition", value: .simd3Float(ballPosition))
				sceneMeshMaterial = mat
				for mesh in meshEntities.values {
					guard
						var modelComponent = mesh.components[
							ModelComponent.self]
					else { return }
                    modelComponent.materials = [mat]
                    mesh.components.set(modelComponent)
				}
			} catch {
				print("error: \(error)")
			}
		}
	}

	private var meshEntities = [UUID: ModelEntity]()

	var errorState = false

	func setupContentEntity() -> Entity {
		return contentEntity
	}

	var dataProvidersAreSupported: Bool {
        return SceneReconstructionProvider.isSupported && HandTrackingProvider.isSupported
	}

	var isReadyToRun: Bool {
        sceneReconstruction.state == .initialized
	}
    
    func processReconstructionUpdates() async {
        for await update in sceneReconstruction.anchorUpdates {
            let meshAnchor = update.anchor
            guard (try? await ShapeResource.generateStaticMesh(from: meshAnchor)) != nil else { continue }
            switch update.event {
            case.added:
                let entity = ModelEntity()
                entity.transform = Transform(matrix: meshAnchor.originFromAnchorTransform)
                await updateModelComponent(geom: meshAnchor.geometry, entity: entity)
                
                meshEntities[meshAnchor.id] = entity
                contentEntity.addChild(entity)
            case.updated:
                guard let entity = meshEntities[meshAnchor.id] else { continue }
                entity.transform = Transform(matrix: meshAnchor.originFromAnchorTransform)
                
                await updateModelComponent(geom: meshAnchor.geometry, entity: entity)
            case.removed:
                meshEntities[meshAnchor.id]?.removeFromParent()
                meshEntities.removeValue(forKey: meshAnchor.id)
            }
        }
    }
    
    func updateModelComponent(geom: MeshAnchor.Geometry, entity: ModelEntity) async {
        var desc = MeshDescriptor()
    }

}
