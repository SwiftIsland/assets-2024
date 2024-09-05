import Foundation
import TabletopKit
import RealityKit
import RealityKitContent

extension EquipmentIdentifier {
    static var tableID: Self { .init(0) }
}

struct Table: Tabletop {
    var shape: TabletopShape = .rectangular(width: GameMetrics.tableEdge, height: GameMetrics.tableEdge, thickness: 0)
    
    var id: EquipmentIdentifier = .tableID
}

struct Board: Equipment {
    let id: ID

    var initialState: BaseEquipmentState {
        .init(parentID: .tableID,
              seatControl: .restricted([]),
              pose: .init(position: .init(), rotation: .degrees(45)),
              boundingBox: .init(center: .zero, size: .init(GameMetrics.boardEdge, GameMetrics.boardHeight, GameMetrics.boardEdge)))
    }
}

struct PlayerSeat: TableSeat {
    let id: ID
    var initialState: TableSeatState

    /* There are three seats around the edges of the table.
    Each seat faces the center of the table. */
    @MainActor static let seatPoses: [TableVisualState.Pose2D] = [
        .init(position: .init(x: 0, z: Double(GameMetrics.tableEdge)), rotation: .degrees(0)),
        .init(position: .init(x: -Double(GameMetrics.tableEdge), z: 0), rotation: .degrees(-90)),
        .init(position: .init(x: Double(GameMetrics.tableEdge), z: 0), rotation: .degrees(90))
    ]
    
    init(id: TableSeatIdentifier, pose: TableVisualState.Pose2D) {
        self.id = id
        let spatialSeatPose: TableVisualState.Pose2D = .init(position: pose.position,
                                                             rotation: pose.rotation)
        initialState = .init(pose: spatialSeatPose)
    }
}

struct PlayerPawn: EntityEquipment {
    public enum AnimationState: String, Codable, Sendable, Equatable, CaseIterable {
        case idleA
        case jumpJoy
        case sad
    }

    enum CuteBotColor: Sendable {
        case red
        case purple
        case blue
    }

    let id: ID
    let cuteBotColor: CuteBotColor
    let entity: Entity

    var initialState: BaseEquipmentState
    
    static let pawns: [(String, CuteBotColor)] = [
        ("player_pawn_red_assembly", .red),
        ("player_pawn_purple_assembly", .purple),
        ("player_pawn_blue_assembly", .blue)
    ]

    init(id: ID, seat: PlayerSeat, cuteBotColor: CuteBotColor, entity: Entity) {
        self.id = id
        self.cuteBotColor = cuteBotColor
        self.entity = entity
        let pawnToSeat: TableVisualState.Pose2D = .init(position: .init(x: -0.2, z: -0.3), rotation: .init())
        let seatToTable = seat.initialState.pose
        let pawnToTable = pawnToSeat * seatToTable
        initialState = .init(parentID: .tableID, pose: pawnToTable, entity: self.entity)
    }
}

struct ConveyorTile: Equipment, Sendable {
    enum Category: String, Sendable {
        case red
        case green
        case grey
    }
    
    let id: ID
    let category: ConveyorTile.Category
    let initialState: BaseEquipmentState
    
    static let positionScale = 0.4
    
    /* The conveyor belt is a lifted, rotated square with tiles placed around the borders.
     Lay out the tiles on a unit square, and then transform and scale it to match the conveyor belt.
     The tiles belong to the board area, which is lifted and rotated. */
    @MainActor static let tiles: [(TableVisualState.Point2D, ConveyorTile.Category)] = [
        // Top row, left to right.
        (.init(x: 0.04, z: 0.04), .grey),
        (.init(x: 0.2, z: 0), .grey),
        (.init(x: 0.35, z: 0), .green),
        (.init(x: 0.5, z: 0), .grey),
        (.init(x: 0.65, z: 0), .grey),
        (.init(x: 0.81, z: 0), .red),

        // Right column, top to bottom.
        (.init(x: 0.96, z: 0.04), .green),
        (.init(x: 1, z: 0.2), .grey),
        (.init(x: 1, z: 0.35), .green),
        (.init(x: 1, z: 0.5), .grey),
        (.init(x: 1, z: 0.65), .grey),
        (.init(x: 1, z: 0.81), .red),

        // Bottom row, right to left.
        (.init(x: 0.96, z: 0.96), .grey),
        (.init(x: 0.81, z: 1), .green),
        (.init(x: 0.65, z: 1), .grey),
        (.init(x: 0.5, z: 1), .red),
        (.init(x: 0.35, z: 1), .grey),
        (.init(x: 0.2, z: 1), .green),

        // Left column, bottom to top.
        (.init(x: 0.04, z: 0.96), .red),
        (.init(x: 0, z: 0.81), .grey),
        (.init(x: 0, z: 0.65), .green),
        (.init(x: 0, z: 0.5), .grey),
        (.init(x: 0, z: 0.35), .grey),
        (.init(x: 0, z: 0.2), .red)
    ]

    init(id: ID, boardID: EquipmentIdentifier, position: TableVisualState.Point2D, category: ConveyorTile.Category) {
        self.id = id
        self.category = category
        initialState = .init(parentID: boardID,
                             seatControl: .restricted([]),
                             pose: .init(position: position, rotation: .init()),
                             boundingBox: .init(center: .zero, size: .init(x: 0.06, y: 0, z: 0.06)))
    }
}
