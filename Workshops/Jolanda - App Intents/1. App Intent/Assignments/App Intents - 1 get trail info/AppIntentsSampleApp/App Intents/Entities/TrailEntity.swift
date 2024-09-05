/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A trail entity that represents trail data retrieved from the app through an intent.
*/

import AppIntents
import CoreLocation
import Foundation

/**
 Through its conformance to `AppEntity`, `TrailEntity` represents `Trail` instances in an intent, such as a parameter.
 
 This sample implements a separate structure for `AppEntity` rather than adding conformance to the `Trail` structure. When deciding whether to
 conform an existing structure in an app to `AppEntity`, or to create a separate structure instead, consider the data that the intent uses, and
 tailor the structure to contain the minimum data required. For example, `Trail` declares a separate `recentImages` property that none of the
 intents need. Because this property may be sizable or expensive to retrieve, the system omits this property from the definition of `TrailEntity`.
 */
struct TrailEntity: AppEntity {

    /**
     A localized name representing this entity as a concept people are familiar with in the app, including
     localized variations based on the plural rules defined in the app's `.stringsdict` file (referenced
     through the `table` parameter). The app may show this value to people when they configure an intent.
     */
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(
            name: LocalizedStringResource("Trail", table: "AppIntents"),
            numericFormat: LocalizedStringResource("\(placeholder: .int) trails", table: "AppIntents")
        )
    }
    
    /**
     Provide the system with the interface required to query `TrailEntity` structures.
     - Tag: default_query
     */
    static var defaultQuery = TrailEntityQuery()

    /// The `AppEntity` identifier must be unique and persistant, as people may save it in a shortcut.
    var id: Trail.ID
  
    /**
     The trail's name. The `EntityProperty` property wrapper makes this property's data available to the system as part of the intent,
     such as when an intent returns a trail in a shortcut.
     - Tag: entity_property
     */
    @Property(title: "Trail Name")
    var name: String
    
    /**
     The name of the featured image. Since people can't query for the image name in this app's intents, it isn't declared as an `EntityProperty` with
    `@Property`. `displayRepresentation` uses the value of this property.
     */
    var imageName: String
    
    /// A description of the trail's location, such as a nearby city name, or the national park encompassing it.
    @Property(title: "Region")
    var regionDescription: String
    
    /// The length of the trail.
    @Property(title: "Trail Length")
    var trailLength: Measurement<UnitLength>

    /// Information on the trail's condition, such as whether it is open or closed, or contains hazards.
    var currentConditions: String
    
    /**
     Information on how to display the entity to people — for example, a string like the trail name. Include the optional subtitle
     and image for a visually rich display.
     */
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)",
                              subtitle: "\(regionDescription)",
                              image: DisplayRepresentation.Image(named: imageName))
    }
    
    init(trail: Trail) {
        self.id = trail.id
        self.imageName = trail.featuredImage
        self.currentConditions = trail.currentConditions
        self.name = trail.name
        self.regionDescription = trail.regionDescription
        self.trailLength = trail.trailLength
    }
}
