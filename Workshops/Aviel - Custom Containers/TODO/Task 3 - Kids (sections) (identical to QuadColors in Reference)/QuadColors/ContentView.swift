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
        <#Create ColorsList, give it each row in colors as a section. Pass sectionContent() to row index to get a row#>
    }

    func sectionContent(at index: Int) -> some View {
        ReorderableForEach(items: colors[index], itemHeight: 60) { item in
            item.color
        } moveAction: { from, to in
            colors[index].move(fromOffsets: .init(integer: from), toOffset: to)
        }
    }
}
