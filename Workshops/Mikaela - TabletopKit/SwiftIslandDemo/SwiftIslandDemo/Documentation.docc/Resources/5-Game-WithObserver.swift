import Foundation

@Observable
class Game {
    let tabletopGame: TabletopGame
    let observer: GameObserver
    let setup: GameSetup
    
    let renderer: GameRenderer
    
    @MainActor
    init() async {
        renderer = GameRenderer()
        
        setup = GameSetup(root: renderer.root)
        tabletopGame = TabletopGame(tableSetup: setup.setup)
        observer = GameObserver(tabletop: tabletopGame, renderer: renderer)
        
        tabletopGame.addObserver(observer)
        tabletopGame.addRenderDelegate(renderer)
        
        tabletopGame.claimAnySeat()
    }
    
    deinit {
        tabletopGame.removeRenderDelegate(renderer)
        tabletopGame.removeObserver(observer)
    }
}
