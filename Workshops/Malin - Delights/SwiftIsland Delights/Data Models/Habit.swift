//
//  Habit.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-19.
//

import SwiftUI

struct Habit: Identifiable {
    let id: UUID = UUID()
    
    let name: String
    let symbolName: String
    var completedAt: [Date]
    
    var hasStreak: Bool {
        guard let latestCompleted = completedAt.last else { return false }
        
        let calendar = Calendar.current
        
        return calendar.isDateInYesterday(latestCompleted) || calendar.isDateInToday(latestCompleted)
    }
    
    var streakCount: Int {
        let calendar = Calendar.current
        
        let sortedDates = completedAt.sorted(by: >)
        guard let latestDate = sortedDates.first else { return 0 }
        
        if !calendar.isDateInToday(latestDate) &&
            !calendar.isDateInYesterday(latestDate) {
            return 0
        }
        
        var streakCount = 1
        var currentDate = latestDate
        
        for date in sortedDates.dropFirst() {
            // To make it easier to play with the streaks, we're not checking if the streak has already been completed today
//            if calendar.isDate(date, inSameDayAs: currentDate) {
//                continue
//            }
            
            if let daysBetween = calendar.dateComponents([.day], from: date, to: currentDate).day,
               daysBetween <= 1 {
                streakCount += 1
                currentDate = date
            } else {
                break
            }
        }
        
        return streakCount
    }
    
    var streakText: LocalizedStringKey {
        if hasStreak {
            return "\(streakCount)-day streak"
        } else if let latestCompletion = completedAt.sorted(by: >).first {
            return "Completed on \(latestCompletion.formatted(Formatters.monthDayStyle))"
        } else {
            return "Never completed"
        }
    }
    
    var longStreakText: LocalizedStringKey {
        if hasStreak {
            return "Your current streak is ^[\(streakCount) day](inflect: true)"
        } else if let latestCompletion = completedAt.sorted(by: >).first {
            return "Last completed on \(latestCompletion.formatted(Formatters.monthDayStyle))"
        } else {
            return "Future habit waiting to happen"
        }
    }
    
    mutating func complete() {
        completedAt.append(.now)
    }
}

extension Habit {
    static let exampleHabits: [Habit] = [
        Habit(name: "Exercise", symbolName: HabitSymbol.hiit.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Have Fun", symbolName: HabitSymbol.partyPopper.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -8, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -6, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Play Guitar", symbolName: HabitSymbol.guitars.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Sketch", symbolName: HabitSymbol.pencil.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!
        ]),
        Habit(name: "Read Book", symbolName: HabitSymbol.books.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -7, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Practice Latte Art", symbolName: HabitSymbol.cup.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Date()
        ]),
        Habit(name: "Practice Handstand", symbolName: HabitSymbol.hand.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -6, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Play Video Games", symbolName: HabitSymbol.videogame.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -4, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Learn Editing", symbolName: HabitSymbol.desktop.rawValue, completedAt: [
            Calendar.current.date(byAdding: .day, value: -7, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
            Date()
        ]),
        Habit(name: "Skate", symbolName: HabitSymbol.skateboard.rawValue, completedAt: [])
    ]
}
