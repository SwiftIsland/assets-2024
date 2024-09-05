import Foundation

@Observable
class Game {
    let tabletopGame: TabletopGame
    let setup: GameSetup
    
    let renderer: GameRenderer
    
    @MainActor
    init() async {
        renderer = GameRenderer()
        
        setup = GameSetup(root: renderer.root)
        tabletopGame = TabletopGame(tableSetup: setup.setup)
        tabletopGame.addRenderDelegate(renderer)
        
        tabletopGame.claimAnySeat()
    }
    
    deinit {
        tabletopGame.removeRenderDelegate(renderer)
    }
}
