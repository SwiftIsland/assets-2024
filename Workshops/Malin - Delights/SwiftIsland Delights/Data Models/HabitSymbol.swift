//
//  HabitSymbol.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-22.
//

import Foundation

enum HabitSymbol: String, Identifiable, Equatable, CaseIterable {
    case bicycle = "bicycle"
    case clock = "clock"
    case calendar = "calendar"
    case moon = "moon"
    case sunMax = "sun.max"
    case heart = "heart"
    case flame = "flame"
    case leaf = "leaf"
    case waterbottle = "waterbottle"
    case drop = "drop"
    case book = "book"
    case books = "books.vertical"
    case graduation = "graduationcap"
    case desktop = "play.desktopcomputer"
    case laptop = "laptopcomputer"
    case videogame = "gamecontroller"
    case dumbbell = "dumbbell"
    case figureWalk = "figure.walk"
    case roll = "figure.roll"
    case stretch = "figure.cooldown"
    case figureRun = "figure.run"
    case hiit = "figure.highintensity.intervaltraining"
    case swim = "figure.pool.swim"
    case skateboard = "skateboard"
    case basketball = "basketball"
    case snowboard = "snowboard"
    case hand = "hand.wave"
    case forkKnife = "fork.knife"
    case cup = "cup.and.saucer"
    case ear = "ear"
    case lightbulb = "lightbulb"
    case bubbleLeft = "bubble.left"
    case chartBar = "chart.bar"
    case paintbrush = "paintbrush"
    case pencil = "pencil.and.scribble"
    case musicNote = "music.note"
    case guitars = "guitars"
    case globe = "globe.europe.africa"
    case medal = "medal"
    case partyPopper = "party.popper"
    case sparkles = "sparkles"
    case house = "house"

    var id: String { rawValue }
}
