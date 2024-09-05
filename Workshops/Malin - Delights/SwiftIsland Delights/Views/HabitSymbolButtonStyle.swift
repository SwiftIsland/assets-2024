//
//  HabitSymbolButtonStyle.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-22.
//

import SwiftUI

struct HabitSymbolButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.medium)
            .foregroundStyle(configuration.isPressed ? .secondaryAccent : .accent)
            .padding(Constants.spacing)
            .background {
                Circle()
                    .fill(configuration.isPressed ? .secondaryAccent.opacity(colorScheme == .light ? 0.2 : 0.3) : .accent.opacity(colorScheme == .light ? 0.1 : 0.2))
            }
    }
}

extension ButtonStyle where Self == HabitSymbolButtonStyle {
    static var habitSymbolButtonStyle: Self { Self() }
}
