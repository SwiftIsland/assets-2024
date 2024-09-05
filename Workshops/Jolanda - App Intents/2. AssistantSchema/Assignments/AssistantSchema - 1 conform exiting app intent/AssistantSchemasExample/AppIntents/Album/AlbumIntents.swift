/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
App intents that represent actions that a person performs on photo albums.
*/

import AppIntents
import Foundation

@AssistantIntent(schema: .photos.createAlbum)
struct CreateAlbumIntent: AppIntent {
    var name: String

    @Dependency
    var library: MediaLibrary

    func perform() async throws -> some ReturnsValue<AlbumEntity> {
        let album = try await library.createAlbum(with: name)
        return .result(value: album.entity)
    }
}

@AssistantIntent(schema: .photos.openAlbum)
struct OpenAlbumIntent: OpenIntent {
    var target: AlbumEntity

    @Dependency
    var library: MediaLibrary

    @Dependency
    var navigation: NavigationManager

    @MainActor
    func perform() async throws -> some IntentResult {
        let albums = library.albums(for: [target.id])
        guard let album = albums.first else {
            throw IntentError.noEntity
        }

        navigation.openAlbum(album)
        return .result()
    }
}

@AssistantIntent(schema: .photos.updateAlbum)
struct UpdateAlbumIntent: AppIntent {
    var target: AlbumEntity
    var name: String

    @Dependency
    var library: MediaLibrary

    func perform() async throws -> some IntentResult {
        let albums = await library.albums(for: [target.id])
        for album in albums {
            try await album.setTitle(name)
        }
        
        return .result()
    }
}

@AssistantIntent(schema: .photos.deleteAlbum)
struct DeleteAlbumIntent: DeleteIntent {
    static let openAppWhenRun = true

    var entities: [AlbumEntity]

    @Dependency
    var library: MediaLibrary

    @MainActor
    func perform() async throws -> some IntentResult {
        let identifiers = entities.map(\.id)
        let albums = library.albums(for: identifiers)
        try await library.deleteAlbums(albums)
        return .result()
    }
}
