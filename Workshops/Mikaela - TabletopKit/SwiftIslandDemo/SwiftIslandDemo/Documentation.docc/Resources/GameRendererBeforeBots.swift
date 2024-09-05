import TabletopKit
import RealityKit
import RealityKitContent
import SwiftUI

@MainActor
class GameRenderer {
    let root: Entity
    
    /// The root offset controls the height of the table inside the app volume.
    let rootOffset: Vector3D = .init(x: 0, y: -0.7, z: 0)
    
    init(root: Entity) {
        self.root = Entity()
        
        // Move everything down within the volume so the tabletop is easier to see.
        root.transform.translation = .init(rootOffset)
        
        Task {
            await loadAssets()
        }
    }
    
    @MainActor
    func loadAssets() async {
        let staticSceneEntity = try! await Entity(named: "static_scene", in: realityKitContentBundle)
        staticSceneEntity.setParent(root)
    }
}
