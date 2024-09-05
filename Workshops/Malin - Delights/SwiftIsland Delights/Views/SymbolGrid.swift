//
//  SymbolGrid.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct SymbolGrid: View {
    @Binding var selectedSymbol: HabitSymbol
    let symbols: [HabitSymbol] = HabitSymbol.allCases
    
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 44), spacing: Constants.tightSpacing)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: Constants.tightSpacing) {
            ForEach(symbols) { symbol in
                Button {
                    selectedSymbol = symbol
                } label: {
                    Image(systemName: symbol.rawValue)
                        .frame(minWidth: 44, minHeight: 44)
                }
                .contentShape(.rect)
                .buttonStyle(.symbolGridButtonStyle(isSelected: symbol == selectedSymbol))
            }
        }
        .padding(Constants.spacing)
        .background(
            RoundedRectangle(cornerRadius: Constants.regularCornerRadius, style: .continuous)
                .fill(Color.secondarySystemGroupedBackground)
        )
    }
}

#Preview {
    SymbolGrid(selectedSymbol: .constant(HabitSymbol.bicycle))
}
