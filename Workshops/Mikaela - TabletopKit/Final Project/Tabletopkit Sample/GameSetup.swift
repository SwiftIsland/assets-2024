/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Setup of the table for the game.
*/

import TabletopKit
import RealityKit
import SwiftUI
import TabletopGameSampleContent
import Spatial

enum GameMetrics {
    static let tableEdge: Float = 0.7
    static let tableThickness: Float = 0.0146
    static let playerAreaDistanceFromCenter: Float = 0.29
    static let boardEdge: Float = 0.4
    static let smallHeight: Float = 0.001
    static let boardHeight: Float = 0.055
    static let playerAreaSize: SIMD2<Float> = SIMD2(0.4, 0.1)
    static let playerHandSize: SIMD2<Float> = SIMD2(0.2, 0.1)
}

@MainActor
class GameSetup {
    let root: Entity
    var setup: TableSetup
    let board: Board
    var pawns: [PlayerPawn] = []
    var seats: [PlayerSeat] = []

    // This is an incrementing counter to generate unique IDs for each piece of equipment.
    struct IdentifierGenerator {
        private var count = 0

        mutating func newId() -> Int {
            count += 1
            return count
        }
    }
    var idGenerator = IdentifierGenerator()

    /*
     The table has a board in the center,
     with a hand and a pawn for each player around the sides.
     The side without a seat has the deck and the die.
     
            +---+
            |die|   +------+
            +---+   | deck |
                    +------+
       pawn
       +-+     +---+-+-+-+-+-+-+---+
       +-+     |   | | | | | | |   |
               +---+-+-+-+-+-+-+---+  +-----+
     +-----+   |---|           |---|  |     |
     |     |   |---|           |---|  |hand |
     |hand |   |---|  board    |---|  |     |
     |     |   |---|           |---|  |     |
     |     |   |---|           |---|  |     |
     |     |   +---+-+-+-+-+-+-+---+  +-----+
     +-----+   |   | | | | | | |   |
               +---+-+-+-+-+-+-+---+    +-+
                                        +-+
           +-+   +-----------+          pawn
           +-+   |           |
           pawn  |   hand    |
                 +-----------+
     */
    init(root: Entity) {
        self.root = root
        // STEP 1 make table
        setup = TableSetup(tabletop: Table())

        // STEP 2 position seats
        for (index, pose) in PlayerSeat.seatPoses.enumerated() {
            let seat = PlayerSeat(id: TableSeatIdentifier(index), pose: pose)
            seats.append(seat)
            setup.add(seat: seat)
        }

        // STEP 3 place equipment (board)
        board = Board(id: EquipmentIdentifier(self.idGenerator.newId()))
        setup.add(equipment: board)

        // STEP 3b place equipment (die)
        let die = Die(id: EquipmentIdentifier(self.idGenerator.newId()))
        setup.add(equipment: die)
        
        loadConveyorTiles()
        
        loadPawns()
    }
    
    // step 3c place equipment (conveyor tiles)
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
    
    // step 3d place equipment pawns
    func loadPawns() {
        for (index, pawnInfo) in PlayerPawn.pawns.enumerated() {
            let pawn = PlayerPawn(id: PlayerPawn.ID(self.idGenerator.newId()),
                                  seat: seats[index],
                                  cuteBotColor: pawnInfo.1,
                                  entity: try! Entity.load(named: pawnInfo.0, in: tabletopGameSampleContentBundle))
            pawns.append(pawn)
            setup.add(equipment: pawn)
        }
    }
}
