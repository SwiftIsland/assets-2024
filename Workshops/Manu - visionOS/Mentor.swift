//
// Created by Paul Peelen for the use in the Swift Island app
// Copyright © 2023 AppTrix AB. All rights reserved.
//

import Foundation

public struct Mentor: Response, Hashable {
    public let description: String
    public let imageName: String
    public let name: String
    public let twitter: String?
    public let web: String?
    public let linkedIn: String?
    public let mastodon: String?
    public let order: Int
    public let latitude: Float
    public let longitude: Float

    public var twitterUrl: URL? {
        guard let twitter else { return nil }
        return URL(string: "https://twitter.com/\(twitter)")
    }

    public var webUrl: URL? {
        guard let web else { return nil }
        return URL(string: web)
    }

    public var linkedInUrl: URL? {
        guard let linkedIn else { return nil }
        return URL(string: "https://linkedin.com/in/\(linkedIn)")
    }

    public var mastodonUrl: URL? {
        guard let mastodon else { return nil }
        return URL(string: mastodon)
    }
    
    public var firstName: String {
        name.split(separator: " ").first?.lowercased() ?? " "
    }
}

extension Mentor: Identifiable {
    public var id: String { name }
}

extension Mentor {
    public static func forPreview(description: String = "Lorem ipsum dolor sit amet, **consectetur adipiscing elit**. _Proin vitae cursus_ lectus. Mauris feugiat ipsum sed vulputate gravida. Nunc a risus ac odio consequat ornare nec sit amet arcu. In laoreet elit egestas sem ornare, at maximus sem maximus. Nulla molestie suscipit mollis. Cras gravida pellentesque mattis. Etiam at nisl lorem. Nullam viverra non arcu eget elementum. Nullam a velit laoreet, luctus risus at, dapibus dolor. Aliquam nec euismod augue, id lacinia nulla.",
                                  imageName: String = ["speaker-paul-2024", "speaker-manu-2024", "speaker-malin-2024"].randomElement()!,
                                  name: String = "John Appleseed",
                                  twitter: String? = ["ppeelen", "x"].randomElement(),
                                  web: String? = "https://www.swiftisland.nl",
                                  linkedIn: String? = "ppeelen",
                                  mastodon: String? = nil,
                                  order: Int = 0,
                                  latitude: Float = 0,
                                  longitude: Float = 0) -> Mentor {
        Mentor(
            description: description,
            imageName: imageName,
            name: name,
            twitter: twitter,
            web: web,
            linkedIn: linkedIn,
            mastodon: mastodon,
            order: order,
            latitude: latitude,
            longitude: longitude
        )
    }
    
    public static var forWorkshop: [Mentor] {
        [
            Mentor.forPreview(description: "Audrey discovered iOS when she first bought an iPhone Edge in 2008. Since then, she is working passionately on Apple platforms, enjoying SwiftUI and even CoreData while building the macOS Drive app at Proton. When she is not coding, watching football and playing basketball are her favorite activities. As a huge movie addict,  Audrey is avoiding trailers as much as possible.", imageName: "speaker-audrey-2024", name: "Audrey Zebaze", twitter: "MvpOhhhDrey", web: nil, linkedIn: "-audrey-sobgou-zebaze-0428a768", mastodon: nil, order: 1, latitude: 48.85, longitude: 2.23),
//            Mentor.forPreview(description: "Aviel Gross is a senior iOS engineer who currently leads the development of the Behance app at Adobe. He has been in the field since 2013 and previously worked on the Facebook app. He is known as a professional bikeshedder in SwiftUI and app performance.", imageName: "speaker-aviel-2024", name: "Aviel Gross", twitter: nil, web: nil, linkedIn: "avielg", mastodon: nil, order: 2, latitude: 39.95, longitude: -75.16),
//            Mentor.forPreview(description: "Malin loves working on everything related to building delightful products. From designing an intuitive interface and creating app icons to developing apps and writing server-side code. Malin is also passionate about the Apple developer community, organizing online and in-person meetups. When not immersed in tech, she likes to visit snobby coffee shops and explore the local Vancouver hiking trails.", imageName: "speaker-malin-2024", name: "Malin Sundberg", twitter: "malinsundberg", web: "https://tripleglazedstudios.com/", linkedIn: "malin-sundberg-82171ab5", mastodon: nil, order: 3, latitude: 49.23, longitude: -123.11),
//            Mentor.forPreview(description: "Zeyad grew up in Cairo, Egypt. He studied computer engineering before moving to Berlin to work for Zalando. After a couple of really fun years at Zalando, Zeyad moved to London to join Meta (Facebook then)  where he's still working 7 years later. For the past few years he's been working on WhatsApp. Kickstarting the effort to bring WhatsApp to Mac using catalyst. He's currently working on a similar effort to bring the WhatsApp app to another popular platform…", imageName: "speaker-zeyad-2024", name: "Zeyad Salloum", twitter: "zeyadsalloum", web: nil, linkedIn: "zeyad-salloum-95b47a90", mastodon: nil, order: 4, latitude: 30.04, longitude: 31.23),
            Mentor.forPreview(description: "Paul Peelen is a Staff Engineer at PayPal, specializing in iOS development with over 15 years of experience. From the Netherlands but Based in Stockholm, Sweden, he has developed more than 30 apps and is an active co-organizer of CocoaHeads Stockholm. Paul frequently shares his expertise through detailed tutorials on his blog. A fun fact about Paul is that he created the first versions of the Swift Island app.", imageName: "speaker-paul-2024", name: "Paul Peelen", twitter: "ppeelen", web: "https://PaulPeelen.com", linkedIn: "https://www.linkedin.com/in/nataliyapatsovska/", mastodon: "https://mastodon.nu/@ppeelen", order: 4, latitude: 59.32, longitude: 18.07),
//            Mentor.forPreview(description: "Mikaela Caron is an independent iOS Engineer who actively shares her expertise on social media, focusing on iOS development, building apps in public, and freelancing. She develops her own indie apps, works part-time as a freelancer, and is an organizer for iOSDevHappyHour. Mikaela loves giving back to the community.", imageName: "speaker-mikaela-2024", name: "Mikaela Caron", twitter: nil, web: "https://mikaelacaron.com/", linkedIn: "mikaelacaron", mastodon: nil, order: 5, latitude: 39.76, longitude: -86.15),
            Mentor.forPreview(description: "I was there, in the room, in San Francisco, at Moscone, January 2007, when Steve said \"Are you getting it?\". That moment sparked my career as an iOS developer, starting with the SDK a year later. I've since experienced every major Apple release: the iPad, various iPhone and iPad models, Apple TV, and Apple Watch. Vision Pro and visionOS have been as revolutionary for me as the iPhone and iOS. I\'ve been deeply involved with this new platform since its keynote and even more so since the SDK release and my visit to Apple in Munich. I ordered Vision Pro the day it was available and will bring it to Texel — the revolution has begun.", imageName: "speaker-manu-2024", name: "Manu Carrasco Molina", twitter: nil, web: "https://carrascomolina.com/", linkedIn: "carrascomolina", mastodon: nil, order: 6, latitude: 50.80, longitude: 6.48),
            Mentor.forPreview(description: "Jolanda Arends is a freelance native iOS developer. With her background in Human Technology, she's always looking for the best way to create a good user experience and customer value. In recent years she has worked for several webshops, being Bol.com, Restocks (RIP 🪦) and currently Wehkamp (Retail Group). She can also frequently be found (helping) at meetups and conferences (f.e. CocoaheadsNL, Do-iOS). Key phrases that describe her work attitude: keep things simple, solid (literally and figuratively), user-friendly and of course: fun! Loves, among other things, Pizza, F1, Running/Cycling/SUP/walking the dog, fantasy books.", imageName: "speaker-jolanda-2024", name: "Jolanda Arends", twitter: nil, web: "https://jolandaarends.com/", linkedIn: "jolandaarends", mastodon: nil, order: 7, latitude: 52.37, longitude: 4.89)
        ]
    }
}
