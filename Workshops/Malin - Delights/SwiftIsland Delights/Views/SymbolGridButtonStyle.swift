//
//  SymbolGridButtonStyle.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-22.
//

import SwiftUI

struct SymbolGridButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    let isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.medium)
            .foregroundStyle(.accent)
            .background {
                Color.accentColor.opacity(isSelected ? (colorScheme == .light ? 0.17 : 0.27) : (colorScheme == .light ? 0.05 : 0.12))
                    .cornerRadius(Constants.lightCornerRadius)
            }
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: Constants.lightCornerRadius)
                        .stroke(Color.accentColor, lineWidth: 2)
                }
            }
            .opacity(configuration.isPressed ? 0.4 : 1)
    }
}

extension ButtonStyle where Self == SymbolGridButtonStyle {
    static func symbolGridButtonStyle(isSelected: Bool) -> Self {
        Self(isSelected: isSelected)
    }
}
