//
//  NewHabitView.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var habits: [Habit]
    
    @State private var habitName: String = ""
    @State private var habitSymbol: HabitSymbol = HabitSymbol.bicycle
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit Name", text: $habitName)
                }
                
                Section("Symbol") {
                    SymbolGrid(selectedSymbol: $habitSymbol)
                }
                .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveHabit()
                    }
                    .disabled(habitName.isEmpty)
                }
            }
        }
    }
    
    func saveHabit() {
        habits.append(Habit(name: habitName, symbolName: habitSymbol.rawValue, completedAt: []))
        
        dismiss()
    }
}

#Preview {
    NewHabitView(habits: .constant(Habit.exampleHabits))
}
