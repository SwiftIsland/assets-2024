//
//  QuadColorsApp.swift
//  QuadColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

@main
struct QuadColorsApp: App {
    static let initialColors = {
        var result = [[ColorModel]]()

        let steps = 5
        let stepSize = 1.0 / Double(steps - 1)

        for i in 0..<steps {
            let top = Color.red.mix(with: .blue, by: Double(i) * stepSize)
            let bottom = Color.green.mix(with: .yellow, by: Double(i) * stepSize)

            var row = [ColorModel]()
            for j in 0..<steps {
                row.append(
                    ColorModel(
                        column: i,
                        order: j,
                        color: top.mix(with: bottom, by: Double(j) * stepSize )
                    )
                )
            }
            result.append(row)
        }
        return result
    }()

    @State private var colors: [[ColorModel]] = []

    @State private var didWin = false

    func updateColors() {
        colors = Self.initialColors.map{ $0.shuffled() }
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

            var allInOrder = true
            var allInReverse = true
            for index in 0..<colors.count {
                let initialIDs = Self.initialColors[index].map { $0.id }
                let resultIDs = colors[index].map { $0.id }
                if initialIDs != resultIDs {
                    allInOrder = false
                }
                if initialIDs.reversed() != resultIDs {
                    allInReverse = false
                }
            }

            didWin = allInOrder || allInReverse
        }
        .onChange(of: didWin) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue {
                updateColors()
            }
        }
    }
}
