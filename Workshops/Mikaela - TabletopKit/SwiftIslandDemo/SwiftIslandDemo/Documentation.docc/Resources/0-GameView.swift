import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct GameView: View {
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "Beginning", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    GameView()
}
