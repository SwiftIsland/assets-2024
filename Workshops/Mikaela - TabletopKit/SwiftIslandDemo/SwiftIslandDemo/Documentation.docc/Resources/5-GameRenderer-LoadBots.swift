import TabletopKit
import RealityKit
import RealityKitContent
import SwiftUI

@MainActor
class GameRenderer: TabletopGame.RenderDelegate {
    let root: Entity
    
    var cuteBots = [Entity]()
    
    /// The root offset controls the height of the table inside the app volume.
    let rootOffset: Vector3D = .init(x: 0, y: -0.7, z: 0)
    
    init() {
        self.root = Entity()
        
        // Move everything down within the volume so the tabletop is easier to see.
        root.transform.translation = .init(rootOffset)
        
        Task {
            await loadAssets()
        }
    }
    
    @MainActor
    func loadAssets() async {
        let staticSceneEntity = try! await Entity(named: "static_scene", in: realityKitContentBundle)
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
            cuteBots[index] = try! await Entity(named: "\(botName)_assembly", in: realityKitContentBundle)
            
            var libComponent = AnimationLibraryComponent()
            for animationState in PlayerPawn.AnimationState.allCases {
                let rootEntity = try! await Entity(named: "anim_\(animationState.rawValue)_\(botName)", in: realityKitContentBundle)
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
}
