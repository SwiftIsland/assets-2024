//
//  ContentView.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct ContentView: View {
    @State private var habits: [Habit] = Habit.exampleHabits

    @State private var isPresentingNewHabit: Bool = false
    @State private var habitDetailsToDisplay: Habit?
    
    var body: some View {
        NavigationStack {
            HabitsOverview(habitToDisplay: $habitDetailsToDisplay, habits: $habits)
                .navigationTitle("Habits")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isPresentingNewHabit = true
                        } label: {
                            Label("New Habit", systemImage: "plus")
                        }
                    }
                }
        }
        .sheet(item: $habitDetailsToDisplay) { habit in
            HabitDetailView(habit: habit)
                .presentationDetents([.fraction(0.35)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isPresentingNewHabit) {
            NewHabitView(habits: $habits)
        }
    }
}

#Preview {
    ContentView()
}
