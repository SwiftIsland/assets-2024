import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct GameView: View {
    
    let rootOffset: Vector3D = .init(x: 0, y: -0.7, z: 0)
    
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "static_scene", in: realityKitContentBundle) {
                scene.transform.translation = .init(rootOffset)
                content.add(scene)
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    GameView()
}
