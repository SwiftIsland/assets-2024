//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

extension ContainerValues {
    @Entry var isCorrect: Bool = false
}

extension View {
    func isCorrect(_ value: Bool) -> some View {
        containerValue(\.isCorrect, value)
    }
}

struct ColorsList<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var stack: some View {
        VStack(spacing: 0) {
            ForEach(subviews: content) { item in
                item
                    .frame(width: 60, height: 60)
                    .overlay(alignment: .bottomTrailing) {
                        if item.containerValues.isCorrect {
                            Image(systemName: "checkmark")
                                .padding(6)
                        }
                    }
            }
        }
    }

    var body: some View {
        stack
            .border(Color.gray, width: 4)
    }
}
