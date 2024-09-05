/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays information about a trail.
*/

import SwiftUI

struct TrailDetailView: View {
    @Environment(NavigationModel.self) private var navigationModel
    @Environment(TrailDataManager.self) private var trailManager
    
    var trail: Trail

    private let distanceFormatter = MeasurementFormatter()
    
    var body: some View {
        List {
        #if !os(watchOS)
            TrailInfoView(trail: trail)
        #endif
            detailSection
        }
        .navigationTitle(trail.name)
        
    #if os(iOS) || os(visionOS)
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
    #endif
    }
    
    private var detailSection: some View {
        Section("Details") {
        #if os(watchOS)
            DetailItem(label: "Trail", value: trail.name)
            DetailItem(label: "Location", value: trail.regionDescription)
        #endif
            DetailItem(label: "Current Conditions", value: trail.currentConditions)
            DetailItem(label: "Trail Length", value: distanceFormatter.string(from: trail.trailLength))
            DetailItem(label: "Distance To Trail",
                       value: distanceFormatter.string(from: trail.distanceToTrail))
            DetailItem(label: "Coordinate", value: trail.coordinate.formattedDisplayValue)
        }
    }
}
