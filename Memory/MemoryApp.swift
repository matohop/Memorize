//
//  MemoryApp.swift
//  Memory
//
//  Created by Matthew Hopkins on 10/18/23.
//

import SwiftUI

@main
struct MemoryApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
