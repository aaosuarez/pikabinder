//
//  ContentView.swift
//  pikabinder
//
//  Created by Aaron Suarez on 9/23/26.
//

import SwiftUI
import Foundation

let cardRepository = CardRepository()

struct ContentView: View {
    @State private var cards: [Card] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns) {
                ForEach(cards) { card in
                    CardView(card: card, isOwned: ownedCards.contains(card.id))
                }
            }
            .padding(.horizontal)
        }
        .task {
            cards = cardRepository.loadCards().sorted { a, b in
                let isAOwned = ownedCards.contains(a.id)
                let isBOwned = ownedCards.contains(b.id)
                return isAOwned && !isBOwned
            }
        }
    }
}

#Preview {
    ContentView()
}
