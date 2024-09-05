//
//  ContentView.swift
//  QuadColors
//
//  Created by Aviel Gross on 10.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var colors: [[ColorModel]]

    var body: some View {
        VStack {
            content
        }
    }

    var content: some View {
        ColorsList {
            ForEach(colors.indices, id: \.self) { index in
                Section {
                    sectionContent(at: index)
                }
            }
        }
    }

    func sectionContent(at index: Int) -> some View {
        ReorderableForEach(items: colors[index], itemHeight: 60) { item in
            item.color
                .colorHint(item.hint ? item.id : nil)
        } moveAction: { from, to in
            colors[index].move(fromOffsets: .init(integer: from), toOffset: to)
        }
    }
}
