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
                .toolbar {
                    GameToolbar(game: game)
                }
                .tabletopGame(game.tabletopGame, parent: game.renderer.root) { _ in
                    GameInteraction(game: game)
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

struct GameToolbar: ToolbarContent {
    let game: Game
    
    init(game: Game) {
        self.game = game
    }

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomOrnament) {
            Button("Reset", systemImage: "arrow.counterclockwise") {
                game.resetGame()
            }
        }
    }
}
