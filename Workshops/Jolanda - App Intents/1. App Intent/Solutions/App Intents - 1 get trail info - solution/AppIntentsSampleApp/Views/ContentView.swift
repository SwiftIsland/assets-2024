/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view of the app.
*/

import SwiftUI

struct ContentView: View {
    
    @Environment(NavigationModel.self) private var navigationModel
    
    var body: some View {
        @Bindable var navigationModel = navigationModel
        NavigationSplitView(columnVisibility: $navigationModel.columnVisibility) {
            SidebarColumn()
                .navigationSplitViewColumnWidth(min: 200, ideal: 350)
        } content: {
            TrailList()
        } detail: {
            TrailDetailColumn()
        }
    }
}
