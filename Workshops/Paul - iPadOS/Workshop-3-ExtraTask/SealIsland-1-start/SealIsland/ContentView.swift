//
//  ContentView.swift
//  SealIsland
//
//  Created by Paul Peelen on 2024-08-25.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    @StateObject var dataModel = IslandImageDataModel()

    var body: some View {
        TabView {
            NavigationSplitView {
                VStack(alignment: .leading) {
                    Spacer()
                    VStack {
                        Text("SealIsland v1.0.0")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            } detail: {
                NavigationStack {
                    List(dataModel.islandImages) { islandImage in
                        NavigationLink(value: islandImage) {
                            HStack {
                                Image(islandImage.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(islandImage.name)
                            }
                        }
                        .toolbarVisibility(.hidden, for: .navigationBar)
                    }
                    .navigationDestination(for: IslandImage.self) { islandImage in
                        IslandImageView(islandImage: islandImage)
                    }
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
