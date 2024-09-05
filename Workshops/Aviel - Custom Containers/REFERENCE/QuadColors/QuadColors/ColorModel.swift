//
//  ColorModel.swift
//  QuadColors
//
//  Created by Aviel Gross on 10.08.2024.
//

import SwiftUI

struct ColorModel: EmptyIdentifiable, Equatable {
    var id: Int { column * 10 + order }
    let column: Int
    let order: Int
    let color: Color
    var hint: Bool

    static var emptyId: Int { 0 }
}
