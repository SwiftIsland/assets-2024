import RealityKit
import TabletopKit
import RealityKitContent

@MainActor
class GameSetup {
    let root: Entity
    var setup: TableSetup
    
    init(root: Entity) {
        self.root = root
        
        setup = TableSetup(tabletop: Table())
    }
}
