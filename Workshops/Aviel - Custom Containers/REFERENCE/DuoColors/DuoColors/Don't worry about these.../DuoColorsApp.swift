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

    @AppStorage("swift.island.easyMode") private var easyMode = false

    func updateColors(isEasyMode: Bool) {
        if isEasyMode {
            var mutableColors = ColorModel.initialColors.dropLast().dropFirst().shuffled()
            for i in 0..<mutableColors.count {
                mutableColors[i].hint = Int.random(in: 1...3) == 3
            }
            colors = mutableColors
        } else {
            colors = ColorModel.initialColors.shuffled()
        }
    }

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            ContentView(easyMode: $easyMode, colors: $colors)
                .onAppear {
                    updateColors(isEasyMode: easyMode)
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
        .onChange(of: easyMode) { oldValue, newValue in
            guard oldValue != newValue else { return }
            updateColors(isEasyMode: newValue)
        }
        .onChange(of: colors) { oldValue, newValue in
            guard oldValue != newValue else { return }

            let result = if easyMode {
                [ColorModel.initialColors.first!] + colors + [ColorModel.initialColors.last!]
            } else {
                colors
            }

            let initialIDs = ColorModel.initialColors.map { $0.id }
            let resultIDs = result.map { $0.id }
            let inOrder = initialIDs == resultIDs
            let reverseOrder = initialIDs.reversed() == resultIDs
            didWin = inOrder || reverseOrder
        }
        .onChange(of: didWin) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue {
                updateColors(isEasyMode: easyMode)
            }
        }
    }
}
