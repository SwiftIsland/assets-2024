//
//  FooterStack.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

/// Mostly from https://movingparts.io/variadic-views-in-swiftui
struct FooterVStackLayout: _VariadicView_UnaryViewRoot {
    let alignment: HorizontalAlignment

    func body(children: _VariadicView.Children) -> some View {
        let last = children.last?.id

        VStack(alignment: alignment) {
            ForEach(children) { child in
                child

                if child.id != last {
                    Divider()
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 4).fill(Color.secondary.opacity(0.2))
        }
    }
}
