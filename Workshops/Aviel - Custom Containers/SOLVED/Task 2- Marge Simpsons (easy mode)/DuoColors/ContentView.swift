//
//  ContentView.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var easyMode: Bool
    @Binding var colors: [ColorModel]

    var body: some View {
        VStack {
            customContainerContent
            variadicViewFooter
        }
    }

    var variadicViewFooter: some View {
        _VariadicView.Tree(FooterVStackLayout(alignment: .leading)) {
            Toggle("Easy Mode", isOn: $easyMode)
            Text("Start with first and last tiles locked in place, some tiles with a hint, and a checkmark when a tile is in the right spot")
                .font(.caption)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding([.horizontal, .top])
    }

    var customContainerContent: some View {
        ColorsList(easyMode: easyMode) {

            if easyMode {
                let item = ColorModel.initialColors.first!
                item.color
                    .colorHint(item.id)
                    .isCorrect(true)
            }

            ReorderableForEach(items: colors, itemHeight: 60) { item in
                item.color
                    .colorHint(item.hint ? item.id : nil)
                    .isCorrect(isCorrect(item))
            } moveAction: { from, to in
                colors.move(fromOffsets: .init(integer: from), toOffset: to)
            }

            if easyMode {
                let item = ColorModel.initialColors.last!
                item.color
                    .colorHint(item.id)
                    .isCorrect(true)
            }

        }
    }

    func isCorrect(_ item: ColorModel) -> Bool {
        return colors.firstIndex(of: item)! + 1 + (easyMode ? 1 : 0) == item.id
    }
}
