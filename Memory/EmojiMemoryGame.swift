//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by Matthew Hopkins on 10/29/23.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: [Card] {
        model.cards
    }

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    private static var emojis = ["🎲", "🔋", "💎", "🎱", "💿",
                                 "☎️", "🖨️", "⏳", "🔦", "🕯️",
                                 "🛢️", "🪜", "🔧", "⚙️", "🧲",
                                 "🔫", "🧨", "💈", "💊", "💡"]
    
    // MARK: - Intent(s) - Explicit Animations

    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
