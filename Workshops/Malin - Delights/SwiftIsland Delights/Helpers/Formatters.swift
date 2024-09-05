//
//  Formatters.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import Foundation

enum Formatters {
    static let monthDayStyle: Date.FormatStyle = {
        Date.FormatStyle.dateTime.month().day()
    }()
}
