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

    @State private var tabViewCustomization = TabViewCustomization()

    var body: some View {
        TabView {
            Tab("All island images", systemImage: "seal") {
                NavigationStack {
                    List(dataModel.islandImages) { islandImage in
                        NavigationLink(value: islandImage) {
                            HStack {
                                Image(islandImage.imageName)
                                    .resizable()
                                    .frame(width: 50, height:
                                            50)
                                Text(islandImage.name)
                            }
                        }
#if os(iOS)
                        .matchedTransitionSource(id: islandImage.id, in: namespace)
#endif
                    }
                    .navigationDestination(for: IslandImage.self) { islandImage in
                        IslandImageView(islandImage: islandImage)
#if os(iOS)
                            .toolbarVisibility(.hidden, for: .navigationBar)
                            .navigationTransition(.zoom(sourceID: islandImage.id, in: namespace))
#endif
                    }
                }
            }

            TabSection {
                ForEach(dataModel.islandImages) { islandImage in
                    Tab(islandImage.name, systemImage: islandImage.imageName) {
                        IslandImageView(islandImage: islandImage)
                    }
                    .customizationID(islandImage.id.uuidString)
                }
            } header: {
                Label("All images", systemImage: "photo.fill")
            }
            .defaultVisibility(.hidden, for: .tabBar)
            .customizationID("imageSelection")
        }
        .tabViewCustomization($tabViewCustomization)
        .tabViewStyle(.sidebarAdaptable)
        .tabViewSidebarFooter {
            VStack(alignment: .leading) {
                Button {
                    // Do something
                } label: {
                    Label("Reset sidebar", systemImage: "clockwise.circle")
                }
                .buttonStyle(.plain)

                Spacer()
                VStack {
                    Text("SealIsland v1.0.0")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    ContentView()
}
