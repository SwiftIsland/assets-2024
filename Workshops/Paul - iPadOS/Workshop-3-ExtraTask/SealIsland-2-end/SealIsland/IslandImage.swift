//
//  IslandImage.swift
//  SealIsland
//
//  Created by Paul Peelen on 2024-08-25.
//

import Foundation

struct IslandImage: Identifiable, Codable, Hashable {
    var id = UUID()
    var imageName: String
    var name: String
    var description: String
}
