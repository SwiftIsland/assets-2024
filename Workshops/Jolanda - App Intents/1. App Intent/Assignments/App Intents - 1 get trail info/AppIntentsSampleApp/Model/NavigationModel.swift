/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An object that manages selection in the app's UI.
*/

import Foundation
import Observation
import SwiftUI

/// An observable object that manages the selection events for `NavigationSplitView`.
@MainActor
@Observable class NavigationModel {

    /// The selected item in `SidebarColumn`.
    var selectedCollection: TrailCollection?
    
    /// The selected item in the `NavigationSplitView` content view.
    var selectedTrail: Trail?
    
    /// The column visibility in the `NavigationSplitView`.
    var columnVisibility: NavigationSplitViewVisibility
    
    init(selectedCollection: TrailCollection? = nil, columnVisibility: NavigationSplitViewVisibility = .all) {
        self.selectedCollection = selectedCollection
        self.columnVisibility = columnVisibility
    }
}
