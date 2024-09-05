/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Render objects other than equipment.
*/
import TabletopKit
import RealityKit
import SwiftUI
import TabletopGameSampleContent

@MainActor
class GameRenderer: TabletopGame.RenderDelegate {
    let root: Entity
    var cuteBots: [Entity] = []
    /// The root offset controls the height of the table inside the app volume.
    let rootOffset: Vector3D = .init(x: 0, y: -0.7, z: 0)
    weak var game: Game?
    
    @MainActor
    init() {
        
        root = Entity()
        root.transform.translation = .init(rootOffset)

        Task {
            await loadAssets()
        }
    }
    
    @MainActor
    func loadAssets() async {
        let staticSceneEntity = try! await Entity(named: "static_scene", in: tabletopGameSampleContentBundle)
        staticSceneEntity.setParent(root)
        
        await loadCuteBots()
    }

    @MainActor
    func loadCuteBots() async {
        // Load the smaller robots separately because they animate independently.
        let cuteBotTransforms: [(String, Transform)] = [
            ("cutebot_01", .init(translation: .init(x: -0.3, y: 0.019, z: 0.3)) ),
            ("cutebot_02", .init(rotation: .init(angle: (.pi / 2), axis: .init(x: 0, y: 1, z: 0)), translation: .init(x: 0.3, y: 0.019, z: 0.3))),
            ("cutebot_03", .init(rotation: .init(angle: (-.pi / 2), axis: .init(x: 0, y: 1, z: 0)), translation: .init(x: -0.3, y: 0.019, z: -0.3)))
        ]
        
        cuteBots = .init(repeating: Entity(), count: cuteBotTransforms.count)
        for index in 0...cuteBotTransforms.count - 1 {
            let bot = cuteBotTransforms[index]
            let botName = bot.0
            cuteBots[index] = try! await Entity(named: "\(botName)_assembly", in: tabletopGameSampleContentBundle)
            
            var libComponent = AnimationLibraryComponent()
            for animationState in PlayerPawn.AnimationState.allCases {
                let rootEntity = try! await Entity(named: "anim_\(animationState.rawValue)_\(botName)", in: tabletopGameSampleContentBundle)
                if let animationEntity = rootEntity.findEntity(named: "cutebot_bind") {
                    if let animation = animationEntity.availableAnimations.first {
                        libComponent.animations[animationState.rawValue] = animation
                    }
                } else {
                    fatalError("Didn't find animation entity for \(animationState.rawValue) for \(botName)")
                }
            }
            cuteBots[index].components.set(libComponent)
            // Start off with each robot doing the idle animation on loop until an interaction occurs.
            if let idle = getAnimation(entity: cuteBots[index], animation: .idleA) {
                playAnimation(entity: cuteBots[index], animation: idle.repeat())
            }
            
            cuteBots[index].transform = bot.1
            cuteBots[index].setParent(root)
        }
    }

    @MainActor
    func getAnimation(entity: Entity, animation: PlayerPawn.AnimationState) -> AnimationResource? {
        if let component = entity.components[AnimationLibraryComponent.self] {
            return component.animations[animation.rawValue]
        }
        return nil
    }
    
    @MainActor
    func playAnimation(entity: Entity, animation: AnimationResource) {
        if let rigGroup = entity.findEntity(named: "cutebot_bind") {
            rigGroup.playAnimation(animation, transitionDuration: 1, startsPaused: false)
        }
    }
    
    @MainActor
    func playAnimationForTile(category: ConveyorTile.Category, cuteBotColor: PlayerPawn.CuteBotColor) {
        switch category {
            case .green:
                let cuteBotEntity = cuteBotEntity(for: cuteBotColor)
                if let celebrate = getAnimation(entity: cuteBotEntity, animation: .jumpJoy),
                   let idle = getAnimation(entity: cuteBotEntity, animation: .idleA) {
                    playAnimation(entity: cuteBotEntity, animation: try! .sequence(with: [celebrate, idle.repeat()]))
                }
            case .grey:
                // Just keep idling.
                break
            case .red:
                let cuteBotEntity = cuteBotEntity(for: cuteBotColor)
                if let sad = getAnimation(entity: cuteBotEntity, animation: .sad),
                   let idle = getAnimation(entity: cuteBotEntity, animation: .idleA) {
                    playAnimation(entity: cuteBotEntity, animation: try! .sequence(with: [sad, idle.repeat()]))
                }
        }
    }

    @MainActor
    func cuteBotEntity(for cuteBotColor: PlayerPawn.CuteBotColor) -> Entity {
        switch cuteBotColor {
        case .red:
            return cuteBots[0]
        case .blue:
            return cuteBots[1]
        case .purple:
            return cuteBots[2]
        }
    }
}
