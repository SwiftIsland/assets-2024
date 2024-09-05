import SwiftUI

@main
struct SwiftIslandDemoApp: App {

    var body: some Scene {
        WindowGroup {
            GameView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.5, height: 1.5, depth: 1.5, in: .meters)
    }
}
