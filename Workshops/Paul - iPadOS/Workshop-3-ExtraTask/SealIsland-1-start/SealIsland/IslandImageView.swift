//
//  IslandImageView.swift
//  SealIsland
//
//  Created by Paul Peelen on 2024-08-25.
//

import SwiftUI

struct IslandImageView: View {
    var islandImage: IslandImage

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image
            Image(islandImage.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()

            VStack(alignment: .center) {
                Text(islandImage.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 4)

                Text(islandImage.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            }
            .padding(.vertical)
            .background(.regularMaterial)
        }
    }
}

#Preview {
    IslandImageView(islandImage: IslandImage(
        imageName: "seal1",
        name: "Arctic Wanderer",
        description: "Arctic Wanderer is the calm and introspective type. Known for its solitary adventures in the icy waters, it loves exploring remote corners."
    ))
}
