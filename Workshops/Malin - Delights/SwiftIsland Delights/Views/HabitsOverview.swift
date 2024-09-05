//
//  HabitsOverview.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct HabitsOverview: View {
    @Binding var habitToDisplay: Habit?
    @Binding var habits: [Habit]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: Constants.spacing),
        GridItem(.flexible(), spacing: Constants.spacing)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Constants.spacing) {
                ForEach($habits) { habit in
                    HabitColumn(habit: habit, habitToDisplay: $habitToDisplay)
                }
            }
            .padding()
        }
        .background(Color.systemGroupedBackground)
    }
}

#Preview {
    HabitsOverview(habitToDisplay: .constant(nil), habits: .constant(Habit.exampleHabits))
}
