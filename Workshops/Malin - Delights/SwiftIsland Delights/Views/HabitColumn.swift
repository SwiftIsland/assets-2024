//
//  HabitColumn.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct HabitColumn: View {
    @Binding var habit: Habit
    @Binding var habitToDisplay: Habit?
    
    var body: some View {
        Button {
            habitToDisplay = habit
        } label: {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.headline)
                    
                    Text(habit.streakText)
                        .font(.caption)
                        .monospacedDigit()
                }
                
                Spacer(minLength: 0)
                
                HabitSymbolButton()
                    .hidden()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondarySystemGroupedBackground)
            )
        }
        .buttonStyle(.plain)
        .overlay {
            HStack {
                Spacer()
                
                HabitSymbolButton()
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private func HabitSymbolButton() -> some View {
        Button {
            habit.complete()
        } label: {
            Label("Complete", systemImage: habit.symbolName)
                .labelStyle(.iconOnly)
        }
        .buttonStyle(.habitSymbolButtonStyle)
    }
}

#Preview {
    VStack {
        HabitColumn(habit: .constant(Habit.exampleHabits.first!), habitToDisplay: .constant(nil))
            .frame(width: 200, height: 60)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.systemGroupedBackground)
}
