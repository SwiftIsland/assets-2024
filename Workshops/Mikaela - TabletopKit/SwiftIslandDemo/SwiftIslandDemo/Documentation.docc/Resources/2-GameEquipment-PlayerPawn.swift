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
