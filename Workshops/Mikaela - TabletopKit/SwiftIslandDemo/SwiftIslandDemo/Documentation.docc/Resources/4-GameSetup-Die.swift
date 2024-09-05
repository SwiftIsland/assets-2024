import RealityKit
import TabletopKit
import RealityKitContent

@MainActor
class GameSetup {
    let root: Entity
    var setup: TableSetup
    let board: Board
    
    var seats = [PlayerSeat]()
    
    /// This is an incrementing counter to generate unique IDs for each piece of equipment.
    struct IdentifierGenerator {
        private var count = 0
        
        mutating func newId() -> Int {
            count += 1
            return count
        }
    }
    var idGenerator = IdentifierGenerator()
    
    init(root: Entity) {
        self.root = root
        
        setup = TableSetup(tabletop: Table())
        
        for (index, pose) in PlayerSeat.seatPoses.enumerated() {
            let seat = PlayerSeat(id: TableSeatIdentifier(index), pose: pose)
            seats.append(seat)
            setup.add(seat: seat)
        }
        
        board = Board(id: EquipmentIdentifier(self.idGenerator.newId()))
        setup.add(equipment: board)
        
        let die = Die(id: EquipmentIdentifier(self.idGenerator.newId()))
        setup.add(equipment: die)
    }
}
