/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A parent container to organize classes for the game.
*/
import TabletopKit
import RealityKit
import SwiftUI
import TabletopGameSampleContent

@Observable
class Game {
    let tabletopGame: TabletopGame
    let renderer: GameRenderer
    let observer: GameObserver
    let setup: GameSetup

    @MainActor
    init() async {
        renderer = GameRenderer()
        setup = GameSetup(root: renderer.root)
        
        tabletopGame = TabletopGame(tableSetup: setup.setup)
        
        observer = GameObserver(tabletop: tabletopGame, renderer: renderer)
        tabletopGame.addObserver(observer)
        
        tabletopGame.addRenderDelegate(renderer)
        renderer.game = self

        // Claim any seat when launching in single-player mode; a player must be seated to interact with the game.
        tabletopGame.claimAnySeat()

        resetGame()
    }
    
    deinit {
        tabletopGame.removeObserver(observer)
        tabletopGame.removeRenderDelegate(renderer)
    }
}

extension Game {
    @MainActor
    func resetGame() {
        // Move pawns back to their starting location.
        for pawn in setup.pawns {
            tabletopGame.addAction(.moveEquipment(matching: pawn.id, childOf: .tableID, pose: pawn.initialState.pose))
        }
    }
}
