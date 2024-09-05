//
//  ColorModel.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ColorModel: EmptyIdentifiable, Equatable {
    let id: Int
    let color: Color
    var hint: Bool
}
