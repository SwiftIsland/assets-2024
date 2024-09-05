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

// TODO: Conform existing App Intent to a schema with AssistantSchemas API
struct OpenAssetIntent: OpenIntent {
    static var title: LocalizedStringResource = "Open Asset"
    
    @Parameter(title: "Asset")
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
