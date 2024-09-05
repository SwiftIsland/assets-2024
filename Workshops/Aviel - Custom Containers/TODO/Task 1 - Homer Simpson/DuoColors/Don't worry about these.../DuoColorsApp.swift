//
//  DuoColorsApp.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

@main
struct DuoColorsApp: App {
    @State private var colors: [ColorModel] = ColorModel.initialColors

    @State private var didWin = false

    func updateColors() {
        colors = ColorModel.initialColors.shuffled()
    }

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            ContentView(colors: $colors)
                .onAppear {
                    updateColors()
                }
                .sheet(isPresented: $didWin) {
                    Text("Amazing! 🎉")
                        .font(.largeTitle)
                    Button {
                        didWin = false
                    } label: {
                        Text("Play Again")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding()
                            .background {
                                Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                    }
                }
        }
        .onChange(of: colors) { oldValue, newValue in
            guard oldValue != newValue else { return }

            let result = colors

            let initialIDs = ColorModel.initialColors.map { $0.id }
            let resultIDs = result.map { $0.id }
            let inOrder = initialIDs == resultIDs
            let reverseOrder = initialIDs.reversed() == resultIDs
            didWin = inOrder || reverseOrder
        }
        .onChange(of: didWin) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue {
                updateColors()
            }
        }
    }
}
