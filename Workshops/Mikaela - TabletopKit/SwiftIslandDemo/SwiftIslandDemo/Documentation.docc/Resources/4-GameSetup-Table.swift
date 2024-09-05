import RealityKit
import TabletopKit
import RealityKitContent

@MainActor
class GameSetup {
    let root: Entity
    var setup: TableSetup
    
    var seats = [PlayerSeat]()
    
    init(root: Entity) {
        self.root = root
        
        setup = TableSetup(tabletop: Table())
        
        for (index, pose) in PlayerSeat.seatPoses.enumerated() {
            let seat = PlayerSeat(id: TableSeatIdentifier(index), pose: pose)
            seats.append(seat)
            setup.add(seat: seat)
        }
    }
}
