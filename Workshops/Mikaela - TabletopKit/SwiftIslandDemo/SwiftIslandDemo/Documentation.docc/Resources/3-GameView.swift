import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct GameView: View {
    
    @State private var game: Game?
    
    var body: some View {
        ZStack {
            if let game {
                RealityView { content in
                    content.entities.append(game.renderer.root)
                }
            }
        }
        .task {
            game = await Game()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    GameView()
}
