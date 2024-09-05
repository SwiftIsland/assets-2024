//
//  ColorModel+Helpers.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import struct SwiftUI.Color

extension ColorModel {
    static var emptyId: Int { 0 }

    static let initialColors = {
        var result = [ColorModel]()

        let steps = 10
        let stepSize = 1.0 / Double(steps - 1)

        for i in 1...steps {
            result.append(
                ColorModel(
                    id: i,
                    color: Color.red.mix(with: .blue, by: Double(i) * stepSize),
                    hint: false
                )
            )
        }
        return result
    }()
}
