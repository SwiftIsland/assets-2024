import Foundation

@Observable
class Game {
    let renderer: GameRenderer
    
    @MainActor
    init() async {
        renderer = GameRenderer()
    }
}
