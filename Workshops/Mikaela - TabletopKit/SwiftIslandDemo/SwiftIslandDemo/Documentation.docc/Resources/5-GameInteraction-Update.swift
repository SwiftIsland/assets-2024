import TabletopKit
import RealityKit

struct GameInteraction: TabletopInteraction.Delegate {
    let game: Game
    
    mutating func update(interaction: TabletopInteraction) {
        if interaction.value.phase == .started {
            onPhaseStarted(interaction: interaction)
        }
        
        if interaction.value.gesturePhase == .ended {
            onGesturePhaseEnded(interaction: interaction)
        }

        if interaction.value.phase == .ended {
            onPhaseEnded(interaction: interaction)
        }
    }
    
    func onPhaseStarted(interaction: TabletopInteraction) {
        if game.tabletopGame.equipment(of: PlayerPawn.self, matching: interaction.value.startingEquipmentID) != nil {
            // Only allow pawns to move to conveyor tiles.
            interaction.setAllowedDestinations(.restricted(game.tabletopGame.equipment(of: ConveyorTile.self).map(\.id)))
        }

        if game.tabletopGame.equipment(of: Die.self, matching: interaction.value.startingEquipmentID) != nil {
            // Don't let the die land on any other equipment, just the table.
            interaction.setAllowedDestinations(.restricted([]))
        }
    }
    
    func onGesturePhaseEnded(interaction: TabletopInteraction) {
        if let die = game.tabletopGame.equipment(of: Die.self, matching: interaction.value.startingEquipmentID) {
            // Play a sound when a player tosses a die.
            Task { @MainActor in
                if let audioLibraryComponent = die.entity.components[AudioLibraryComponent.self] {
                    if let soundResource = audioLibraryComponent.resources["dieSoundShort.mp3"] {
                        die.entity.playAudio(soundResource)
                    }
                }
            }
            // Pick a random value for the result of the die toss and toss the die.
            let nextValue = Int.random(in: 1 ... 6)
            interaction.addAction(.updateEquipment(die, state: .init(value: nextValue, parentID: .tableID, entity: die.entity)))
            interaction.toss(equipmentID: interaction.value.startingEquipmentID, as: die.representation)
            // Move the die back to the starting pose on the table after toss animation finishes.
            interaction.addAction(.moveEquipment(matching: die.id, childOf: .tableID, pose: die.initialState.pose))
        }
    }
    
    func onPhaseEnded(interaction: TabletopInteraction) {
        /* If there isn't a proposed destination, there's nothing to do here.
         Objects moving back to their original group animate there smoothly by default. */
        guard let destination = interaction.value.proposedDestination else {
            return
        }
        
        if let pawn = game.tabletopGame.equipment(of: PlayerPawn.self, matching: interaction.value.startingEquipmentID) {
            // Move the pawn to its new proposed destination with a default pose (centered in new destination).
            interaction.addAction(.moveEquipment(matching: pawn.id, childOf: destination.equipmentID, pose: .init()))
        }
    }
}
