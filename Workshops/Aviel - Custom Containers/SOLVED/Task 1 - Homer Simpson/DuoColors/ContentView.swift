//
//  ContentView.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var colors: [ColorModel]

    var body: some View {
        VStack {
            customContainerContent
            variadicViewFooter
        }
    }

    var variadicViewFooter: some View {
        _VariadicView.Tree(FooterVStackLayout(alignment: .leading)) {
            Text("How to play:")
                .bold()
            VStack(alignment: .leading) {
                Text("Drag to organize the colors in order, once you finish - the game ends!")
                Text("When a color is in the correect place, it will have a \(Image(systemName: "checkmark")).")
            }
            .font(.caption)
            .foregroundStyle(Color.secondary)
            .multilineTextAlignment(.leading)
        }
        .padding([.horizontal, .top])
    }

    var customContainerContent: some View {
        ColorsList {
            ReorderableForEach(items: colors, itemHeight: 60) { item in
                item.color
                    .isCorrect(isCorrect(item))
            } moveAction: { from, to in
                colors.move(fromOffsets: .init(integer: from), toOffset: to)
            }
        }
    }

    func isCorrect(_ item: ColorModel) -> Bool {
        return colors.firstIndex(of: item)! + 1 == item.id
    }
}
