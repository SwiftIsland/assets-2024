/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An array of intents that the app makes available as App Shortcuts.
*/

import Foundation
import AppIntents

/**
 An `AppShortcut` wraps an intent to make it automatically discoverable throughout the system. An `AppShortcutsProvider` manages the shortcuts the app
 makes available. The app can update the available shortcuts by calling `updateAppShortcutParameters()` as needed.
 */
class TrailShortcuts: AppShortcutsProvider {
    
    /// The color the system uses to display the App Shortcuts in the Shortcuts app.
    static var shortcutTileColor = ShortcutTileColor.navy
    
    /**
     This sample app contains several examples of different intents, but only the intents this array describes make sense as App Shortcuts.
     Put the App Shortcut most people will use as the first item in the array. This first shortcut shouldn't bring the app to the foreground.
     
     Every phrase that people use to invoke an App Shortcut needs to contain the app name, using the `applicationName` placeholder in the provided
     phrase text, as well as any app name synonyms declared in the `INAlternativeAppNames` key of the app's `Info.plist` file. These phrases are
     localized in a string catalog named `AppShortcuts.xcstrings`.
     
     - Tag: open_favorites_app_shortcut
     */
    static var appShortcuts: [AppShortcut] {
        /// `OpenFavorites` brings the app to the foreground and displays the contents of the Favorites collection in the UI.
        AppShortcut(intent: OpenFavorites(), phrases: [
            "Open Favorites in \(.applicationName)",
            "Show my favorite \(.applicationName)"
        ],
        shortTitle: "Open Favorites",
        systemImageName: "star.circle")
    }
}
