//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

extension ContainerValues {
    <#Add an optional hint entry#>

    @Entry var isCorrect: Bool = false
}

extension View {
    <#If you want - add a function here to make it easier to set the hint for a view#>

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
                        <#If we have a color hint, show it as a text or some symbol...#>
                        <#Tip: You might want to call .allowsHitTesting(false) here#>
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if <#Only show the checkmark if the item is correct AND we're in easy mode!#> {
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
