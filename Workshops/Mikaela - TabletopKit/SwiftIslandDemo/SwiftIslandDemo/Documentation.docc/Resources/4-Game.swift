import Foundation
import TabletopKit

@Observable
class Game {
    let tabletopGame: TabletopGame
    let setup: GameSetup
    
    let renderer: GameRenderer
    
    @MainActor
    init() async {
        renderer = GameRenderer()
        
        setup = GameSetup(root: renderer.root)
        self.tabletopGame = TabletopGame(tableSetup: setup.setup)
    }
}
