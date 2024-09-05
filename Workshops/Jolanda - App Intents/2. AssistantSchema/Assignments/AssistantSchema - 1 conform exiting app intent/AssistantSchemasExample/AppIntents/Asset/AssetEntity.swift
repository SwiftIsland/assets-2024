/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app entity that describes an asset.
*/

import AppIntents
import CoreLocation
import CoreTransferable

struct AssetEntity: IndexedEntity {
    static let typeDisplayRepresentation = TypeDisplayRepresentation("Asset")
    // MARK: Static

    static let defaultQuery = AssetQuery()

    // MARK: Properties

    let id: String
    let asset: Asset
    
    @Property(title: "Title")
    var title: String?

    @Property(title: "Creation Date")
    var creationDate: Date?
    
    @Property(title: "Location")
    var location: CLPlacemark?
    
    @Property(title: "Asset Type")
    var assetType: AssetType?
    
    @Property(title: "Favorite")
    var isFavorite: Bool
    
    @Property(title: "Hidden")
    var isHidden: Bool

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: title.map { "\($0)" } ?? "Unknown",
            subtitle: assetType?.localizedStringResource ?? "Photo"
        )
    }
}

extension AssetEntity: Transferable {

    struct AssetQuery: EntityQuery {
        @Dependency
        var library: MediaLibrary

        @MainActor
        func entities(for identifiers: [AssetEntity.ID]) async throws -> [AssetEntity] {
            library.assets(for: identifiers).map(\.entity)
        }

        @MainActor
        func suggestedEntities() async throws -> [AssetEntity] {
            library.assets.prefix(3).map(\.entity)
        }
    }

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { entity in
            try await entity.asset.pngData()
        }
    }
}
