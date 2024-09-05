/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Setup of the scene and views for the app.
*/
import Foundation
import SwiftUI
import TabletopKit
import RealityKit

// Breaking down the working Xcode 16.1 project, this will be the final project for the workshop

// MARK: App entrypoint
@MainActor
@main
struct SampleApp: App {
    var body: some SwiftUI.Scene {
        WindowGroup(id: "Volumetric") {
            GameView()
                .volumeBaseplateVisibility(.hidden)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.5, height: 1.5, depth: 1.5, in: .meters)
    }
}

@MainActor
struct GameView: View {
    @Environment(\.realityKitScene) private var scene
    @State private var game: Game?
    @State private var activityManager: GroupActivityManager?

    var body: some View {
        ZStack {
            if let loadedGame = game, activityManager != nil {
                RealityView { content in
                    content.entities.append(loadedGame.renderer.root)
                }
                .toolbar {
                    GameToolbar(game: loadedGame)
                }
                .tabletopGame(loadedGame.tabletopGame, parent: loadedGame.renderer.root) { _ in
                    // step 4 monitor interactions
                    GameInteraction(game: loadedGame)
                }
            }
        }
        .task {
            game = await Game()
            activityManager = .init(tabletopGame: game!.tabletopGame)
        }
    }
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
            Spacer()
            Button("SharePlay", systemImage: "shareplay") {
               Task {
                    try! await Activity().activate()
               }
            }
        }
    }
}
