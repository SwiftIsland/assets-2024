//
//  DataModel.swift
//  SealIsland
//
//  Created by Paul Peelen on 2024-08-25.
//

import Foundation

class IslandImageDataModel: ObservableObject {
    @Published var islandImages: [IslandImage] = []

    init() {
        loadJSON()
    }

    func loadJSON() {
        if let url = Bundle.main.url(forResource: "IslandImages", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([IslandImage].self, from: data)
                self.islandImages = decodedData
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Failed to locate island_images.json in bundle.")
        }
    }
}
