/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A utility file with custom errors that are localized and eligible for use in an intent.
*/

import Foundation

/**
 An intent can throw custom `Error` values. If the `Error` conforms to `CustomLocalizedStringResourceConvertible`, the system will use
 the localized text as part of the error handling.
 */
enum TrailIntentError: Error, CustomLocalizedStringResourceConvertible {
    case trailNotFound
    
    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .trailNotFound:
            return "Could not find the requested trail."
        }
    }
}
