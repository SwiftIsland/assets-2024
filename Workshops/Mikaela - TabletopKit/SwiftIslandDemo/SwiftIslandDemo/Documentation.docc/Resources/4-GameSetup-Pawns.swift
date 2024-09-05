import RealityKit
import TabletopKit
import RealityKitContent

@MainActor
class GameSetup {
    let root: Entity
    var setup: TableSetup
    let board: Board
    
    var seats = [PlayerSeat]()
    var pawns = [PlayerPawn]()
    
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
        
        loadConveyorTiles()
        loadPawns()
    }
    
    func loadConveyorTiles() {
        for tileConfig in ConveyorTile.tiles {
            // Transform from a pose on a unit square to an absolute pose in the table's coordinate space.
            let positionX = (tileConfig.0.x - 0.5) * ConveyorTile.positionScale
            let positionY = (tileConfig.0.z - 0.5) * ConveyorTile.positionScale
            let tile = ConveyorTile(id: EquipmentIdentifier(self.idGenerator.newId()),
                                    boardID: board.id,
                                    position: .init(x: positionX, z: positionY),
                                    category: tileConfig.1)
            setup.add(equipment: tile)
        }
    }
    
    func loadPawns() {
        for (index, pawnInfo) in PlayerPawn.pawns.enumerated() {
            let pawn = PlayerPawn(id: PlayerPawn.ID(self.idGenerator.newId()),
                                  seat: seats[index],
                                  cuteBotColor: pawnInfo.1,
                                  entity: try! Entity.load(named: pawnInfo.0, in: realityKitContentBundle))
            pawns.append(pawn)
            setup.add(equipment: pawn)
        }
    }
}
