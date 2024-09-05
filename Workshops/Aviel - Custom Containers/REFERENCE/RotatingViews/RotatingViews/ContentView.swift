//
//  ContentView.swift
//  RotatingViews
//
//  Created by Aviel Gross on 07.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RotatingViews {
            VStack { Image(systemName: "globe"); Text("Hello, world!") }
            VStack { Image(systemName: "sailboat"); Text("Hello, Swift Island!") }
            VStack { Image(systemName: "music.mic"); Text("Hello, Taylor Swift!") }
            VStack { Image(systemName: "figure.dance"); Text("Hello, Beyonce!") }
        }
    }
}

struct RotatingViews<Content: View>: View {
    let content: Content

    @State private var count = 0
    @State private var index = 0

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Group(subviews: content) { children in
            if children.count == 0 {
                EmptyView()
            } else {
                ZStack {
                    Color.random
                    children[index]
                        .font(.largeTitle)
                        .foregroundColor(.random)
                }
                .animation(.default, value: index)
                .onAppear {
                    count = children.count
                }
            }
        }
        .task {
            rotate() /// wait 1 second then change `index`
        }
    }

    private func rotate() {
        Task {
            try? await Task.sleep(for: .seconds(3))
            if index == count - 1 {
                index = 0
            } else {
                index += 1
            }
            rotate()
        }
    }
}

extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0.3...1),
            green: Double.random(in: 0.3...1),
            blue: Double.random(in: 0.3...1)
        )
    }
}

#Preview {
    ContentView()
}
