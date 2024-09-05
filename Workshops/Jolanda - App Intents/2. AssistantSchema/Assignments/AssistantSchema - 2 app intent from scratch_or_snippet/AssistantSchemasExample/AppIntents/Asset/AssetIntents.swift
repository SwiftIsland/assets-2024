/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Actions that the app exposes to system experiences as app intents.
*/

import AppIntents
import Foundation
import SwiftUI

enum IntentError: Error {
    case noEntity
}

@AssistantIntent(schema: .photos.createAssets)
struct CreateAssetsIntent: AppIntent {
    var files: [IntentFile]

    @Dependency
    var library: MediaLibrary

    @MainActor
    func perform() async throws -> some ReturnsValue<[AssetEntity]> {
        guard !files.isEmpty else {
            throw IntentError.noEntity
        }

        var toReturn: [AssetEntity] = []

        // Process input
        for file in files {
            let image = Image(from: file.data)
            let asset = try await library.createAsset(from: image)
            toReturn.append(asset.entity)
        }
        
        return .result(value: toReturn)
    }
}

@AssistantIntent(schema: .photos.openAsset)
struct OpenAssetIntent: OpenIntent {
    var target: AssetEntity

    @Dependency
    var library: MediaLibrary

    @Dependency
    var navigation: NavigationManager

    @MainActor
    func perform() async throws -> some IntentResult {
        let assets = library.assets(for: [target.id])
        guard let asset = assets.first else {
            throw IntentError.noEntity
        }

        navigation.openAsset(asset)
        return .result()
    }
}

// TODO: Add App Intent from scratch (with Xcode Snippet)
// Hint: Start by typing the photos domain name, schema = updateAsset
// Hint: You're going to need a dependancyt on MediaLibrary to map the target to an actual asset.


@AssistantIntent(schema: .photos.deleteAssets)
struct DeleteAssetsIntent: DeleteIntent {
    static let openAppWhenRun = true

    var entities: [AssetEntity]

    @Dependency
    var library: MediaLibrary

    @MainActor
    func perform() async throws -> some IntentResult {
        let identifiers = entities.map(\.id)
        let assets = library.assets(for: identifiers)
        try await library.deleteAssets(assets)
        return .result()
    }
}

@AssistantIntent(schema: .photos.search)
struct SearchAssetsIntent: ShowInAppSearchResultsIntent {
    static let searchScopes: [StringSearchScope] = [.general]

    var criteria: StringSearchCriteria

    @Dependency
    var navigation: NavigationManager

    @MainActor
    func perform() async throws -> some IntentResult {
        navigation.openSearch(with: criteria.term)
        return .result()
    }
}
