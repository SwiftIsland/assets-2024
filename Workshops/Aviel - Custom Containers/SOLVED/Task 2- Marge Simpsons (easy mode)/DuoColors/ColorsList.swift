//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

extension ContainerValues {
    @Entry var colorHint: String?
    @Entry var isCorrect: Bool = false
}

extension View {
    func colorHint(_ value: Int?) -> some View {
        containerValue(\.colorHint, value.map(String.init))
    }

    func isCorrect(_ value: Bool) -> some View {
        containerValue(\.isCorrect, value)
    }
}

struct ColorsList<Content: View>: View {
    let easyMode: Bool
    let content: Content

    init(easyMode: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.easyMode = easyMode
    }

    var stack: some View {
        VStack(spacing: 0) {
            ForEach(subviews: content) { item in
                item
                    .frame(width: 60, height: 60)
                    .overlay {
                        if let hint = item.containerValues.colorHint {
                            Text(hint)
                                .allowsHitTesting(false)
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if item.containerValues.isCorrect && easyMode {
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
